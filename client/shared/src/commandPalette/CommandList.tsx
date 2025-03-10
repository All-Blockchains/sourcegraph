import React, { forwardRef, useCallback, useMemo, useState } from 'react'

import { mdiChevronDown, mdiChevronUp, mdiConsole, mdiPuzzle } from '@mdi/js'
import classNames from 'classnames'
import { Remote } from 'comlink'
import * as H from 'history'
import { sortBy, uniq } from 'lodash'
import { from, Subscription } from 'rxjs'
import { filter, switchMap } from 'rxjs/operators'
import stringScore from 'string-score'
import { Key } from 'ts-key-enum'

import { ContributableMenu, Contributions, Evaluated } from '@sourcegraph/client-api'
import { memoizeObservable, logger } from '@sourcegraph/common'
import { Shortcut } from '@sourcegraph/shared/src/react-shortcuts'
import {
    ButtonProps,
    ForwardReferenceComponent,
    Icon,
    Input,
    Label,
    LoadingSpinner,
    Popover,
    PopoverContent,
    PopoverTrigger,
    Position,
} from '@sourcegraph/wildcard'

import { ActionItem, ActionItemAction } from '../actions/ActionItem'
import { wrapRemoteObservable } from '../api/client/api/common'
import { FlatExtensionHostAPI } from '../api/contract'
import { haveInitialExtensionsLoaded } from '../api/features'
import { HighlightedMatches } from '../components/HighlightedMatches'
import { getContributedActionItems } from '../contributions/contributions'
import { RequiredExtensionsControllerProps } from '../extensions/controller'
import { KeyboardShortcut } from '../keyboardShortcuts'
import { PlatformContextProps } from '../platform/context'
import { SettingsCascadeOrError } from '../settings/settings'
import { TelemetryProps } from '../telemetry/telemetryService'

import { EmptyCommandList } from './EmptyCommandList'
import { EmptyCommandListContainer } from './EmptyCommandListContainer'

import styles from './CommandList.module.scss'

/**
 * Customizable CSS classes for elements of the command list button.
 */
export interface CommandListPopoverButtonClassProps {
    /** The class name for the root button element of {@link CommandListPopoverButton}. */
    buttonClassName?: string
    buttonElement?: 'span' | 'a' | 'button'
    buttonOpenClassName?: string
    popoverClassName?: string
    showCaret?: boolean
}

/**
 * Customizable CSS classes for elements of the command list.
 */
export interface CommandListClassProps {
    inputClassName?: string
    formClassName?: string
    listItemClassName?: string
    selectedListItemClassName?: string
    selectedActionItemClassName?: string
    listClassName?: string
    resultsContainerClassName?: string
    actionItemClassName?: string
    noResultsClassName?: string
    iconClassName?: string
}

export interface CommandListProps
    extends CommandListClassProps,
        RequiredExtensionsControllerProps<'executeCommand' | 'extHostAPI'>,
        PlatformContextProps<'settings' | 'sourcegraphURL'>,
        TelemetryProps {
    /** The menu whose commands to display. */
    menu: ContributableMenu

    /** Called when the user has selected an item in the list. */
    onSelect?: () => void

    location: H.Location
}

interface State {
    /** The contributions, merged from all extensions, or undefined before the initial emission. */
    contributions?: Evaluated<Contributions>

    input: string
    selectedIndex: number

    /** Recently invoked actions, which should be sorted first in the list. */
    recentActions: string[] | null

    settingsCascade?: SettingsCascadeOrError
}

// Memoize contributions to prevent flashing loading spinners on subsequent mounts
const getContributions = memoizeObservable(
    (extensionHostAPI: Promise<Remote<FlatExtensionHostAPI>>) =>
        from(extensionHostAPI).pipe(switchMap(extensionHost => wrapRemoteObservable(extensionHost.getContributions()))),
    () => 'getContributions' // only one instance
)

/** Displays a list of commands contributed by extensions for a specific menu. */
export class CommandList extends React.PureComponent<CommandListProps, State> {
    // Persist recent actions in localStorage. Be robust to serialization errors.
    private static RECENT_ACTIONS_STORAGE_KEY = 'commandList.recentActions'

    private static readRecentActions(): string[] | null {
        const value = localStorage.getItem(CommandList.RECENT_ACTIONS_STORAGE_KEY)
        if (value === null) {
            return null
        }
        try {
            const recentActions: unknown = JSON.parse(value)
            if (Array.isArray(recentActions) && recentActions.every(a => typeof a === 'string')) {
                return recentActions as string[]
            }
            return null
        } catch (error) {
            logger.error('Error reading recent actions:', error)
        }
        CommandList.writeRecentActions(null)
        return null
    }

    private static writeRecentActions(recentActions: string[] | null): void {
        try {
            if (recentActions === null) {
                localStorage.removeItem(CommandList.RECENT_ACTIONS_STORAGE_KEY)
            } else {
                const value = JSON.stringify(recentActions)
                localStorage.setItem(CommandList.RECENT_ACTIONS_STORAGE_KEY, value)
            }
        } catch (error) {
            logger.error('Error writing recent actions:', error)
        }
    }

    public state: State = {
        input: '',
        selectedIndex: 0,
        recentActions: CommandList.readRecentActions(),
    }

    private subscriptions = new Subscription()

    private selectedItem: ActionItem | null = null
    private setSelectedItem = (actionItem: ActionItem | null): void => {
        this.selectedItem = actionItem
    }

    public componentDidMount(): void {
        this.subscriptions.add(
            // Don't listen for subscriptions until all initial extensions have loaded (to prevent UI jitter)
            haveInitialExtensionsLoaded(this.props.extensionsController.extHostAPI)
                .pipe(
                    filter(haveLoaded => haveLoaded),
                    switchMap(() => getContributions(this.props.extensionsController.extHostAPI))
                )
                .subscribe(contributions => {
                    this.setState({ contributions })
                })
        )

        this.subscriptions.add(
            this.props.platformContext.settings.subscribe(settingsCascade => this.setState({ settingsCascade }))
        )
    }

    public componentDidUpdate(_previousProps: CommandListProps, previousState: State): void {
        if (this.state.recentActions !== previousState.recentActions) {
            CommandList.writeRecentActions(this.state.recentActions)
        }
    }

    public componentWillUnmount(): void {
        this.subscriptions.unsubscribe()
    }

    public render(): JSX.Element | null {
        if (!this.state.contributions) {
            return (
                <EmptyCommandListContainer className={styles.commandList}>
                    <div className="d-flex py-5 align-items-center justify-content-center">
                        <LoadingSpinner inline={false} />
                        <span className="mx-2">Loading Sourcegraph extensions</span>
                        <Icon aria-hidden={true} svgPath={mdiPuzzle} />
                    </div>
                </EmptyCommandListContainer>
            )
        }

        const allItems = getContributedActionItems(this.state.contributions, this.props.menu)

        // Filter and sort by score.
        const query = this.state.input.trim()
        const items = filterAndRankItems(allItems, this.state.input, this.state.recentActions)

        // Support wrapping around.
        const selectedIndex = ((this.state.selectedIndex % items.length) + items.length) % items.length

        return (
            <div className={styles.commandList}>
                <header>
                    {/* eslint-disable-next-line react/forbid-elements */}
                    <form className={this.props.formClassName} onSubmit={this.onSubmit}>
                        <Label className="sr-only" htmlFor="command-list-input">
                            Command
                        </Label>
                        <Input
                            id="command-list-input"
                            inputClassName={this.props.inputClassName}
                            value={this.state.input}
                            placeholder="Run Sourcegraph action..."
                            spellCheck={false}
                            autoFocus={true}
                            autoCorrect="off"
                            autoComplete="off"
                            onChange={this.onInputChange}
                            onKeyDown={this.onInputKeyDown}
                            onClick={this.onInputClick}
                        />
                    </form>
                </header>
                <div className={this.props.resultsContainerClassName}>
                    <ul className={this.props.listClassName}>
                        {items.length > 0 ? (
                            items.map((item, index) => (
                                <li
                                    className={classNames(
                                        this.props.listItemClassName,
                                        index === selectedIndex && this.props.selectedListItemClassName
                                    )}
                                    key={item.action.id}
                                >
                                    <ActionItem
                                        {...this.props}
                                        className={classNames(
                                            this.props.actionItemClassName,
                                            index === selectedIndex && this.props.selectedActionItemClassName
                                        )}
                                        {...item}
                                        ref={index === selectedIndex ? this.setSelectedItem : undefined}
                                        title={
                                            <HighlightedMatches
                                                text={[item.action.category, item.action.title || item.action.command]
                                                    .filter(Boolean)
                                                    .join(': ')}
                                                pattern={query}
                                            />
                                        }
                                        onDidExecute={this.onActionDidExecute}
                                    />
                                </li>
                            ))
                        ) : query.length > 0 ? (
                            <li className={this.props.noResultsClassName}>No matching commands</li>
                        ) : (
                            <EmptyCommandList
                                settingsCascade={this.state.settingsCascade}
                                sourcegraphURL={this.props.platformContext.sourcegraphURL}
                            />
                        )}
                    </ul>
                </div>
            </div>
        )
    }

    private onInputChange: React.ChangeEventHandler<HTMLInputElement> = event => {
        this.setState({ input: event.currentTarget.value, selectedIndex: 0 })
    }

    private onInputKeyDown: React.KeyboardEventHandler<HTMLInputElement> = event => {
        switch (event.key) {
            case Key.ArrowDown: {
                event.preventDefault()
                this.setSelectedIndex(1)
                break
            }
            case Key.ArrowUp: {
                event.preventDefault()
                this.setSelectedIndex(-1)
                break
            }
            case Key.Enter: {
                if (this.selectedItem) {
                    this.selectedItem.runAction(event)
                }
                break
            }
        }
    }

    // prevent input click from closing the popover
    private onInputClick: React.MouseEventHandler<HTMLInputElement> = event => {
        event.stopPropagation()
    }

    private onSubmit: React.FormEventHandler = event => event.preventDefault()

    private setSelectedIndex(delta: number): void {
        this.setState(previousState => ({ selectedIndex: previousState.selectedIndex + delta }))
    }

    private onActionDidExecute = (actionID: string): void => {
        const KEEP_RECENT_ACTIONS = 10
        this.setState(previousState => {
            const { recentActions } = previousState
            if (!recentActions) {
                return { recentActions: [actionID] }
            }
            return { recentActions: uniq([actionID, ...recentActions]).slice(0, KEEP_RECENT_ACTIONS) }
        })

        if (this.props.onSelect) {
            this.props.onSelect()
        }
    }
}

export function filterAndRankItems(
    items: Pick<ActionItemAction, 'action' | 'active'>[],
    query: string,
    recentActions: string[] | null
): ActionItemAction[] {
    if (!query) {
        if (recentActions === null) {
            return items
        }
        // Show recent actions first.
        return sortBy(
            items,
            (item: Pick<ActionItemAction, 'action'>): number | null => {
                const index = recentActions.indexOf(item.action.id)
                return index === -1 ? null : index
            },
            ({ action }) => action.id
        )
    }

    // Memoize labels and scores.
    const labels = new Array<string>(items.length)
    const scores = new Array<number>(items.length)
    const scoredItems = items
        .filter((item, index) => {
            let label = labels[index]
            if (label === undefined) {
                label = `${item.action.category ? `${item.action.category}: ` : ''}${
                    item.action.title || item.action.command || ''
                }`
                labels[index] = label
            }
            if (scores[index] === undefined) {
                scores[index] = stringScore(label, query, 0)
            }
            return scores[index] > 0
        })
        .map((item, index) => {
            const recentIndex = recentActions?.indexOf(item.action.id)
            return { item, score: scores[index], recentIndex: recentIndex === -1 ? null : recentIndex }
        })
    return sortBy(scoredItems, 'recentIndex', 'score', ({ item }) => item.action.id).map(({ item }) => item)
}

export interface CommandListPopoverButtonProps
    extends CommandListProps,
        CommandListPopoverButtonClassProps,
        CommandListClassProps,
        Pick<ButtonProps, 'variant'> {
    keyboardShortcutForShow?: KeyboardShortcut
}

export const CommandListPopoverButton = forwardRef((props, ref) => {
    const {
        as: Component = 'span',
        buttonElement,
        buttonClassName,
        buttonOpenClassName,
        popoverClassName,
        showCaret = true,
        keyboardShortcutForShow,
        variant,
    } = props

    const [isOpen, setIsOpen] = useState(false)

    // Capture active element on open in order to restore focus on close.
    const originallyFocusedElement = useMemo(() => {
        if (isOpen && document.activeElement instanceof HTMLElement) {
            return document.activeElement
        }
        return null
    }, [isOpen])

    const close = useCallback(() => {
        originallyFocusedElement?.focus()
        setIsOpen(false)
    }, [originallyFocusedElement])

    const toggleIsOpen = useCallback(() => {
        if (isOpen) {
            originallyFocusedElement?.focus()
        }
        setIsOpen(!isOpen)
    }, [isOpen, originallyFocusedElement])

    return (
        <Popover isOpen={isOpen} onOpenChange={toggleIsOpen}>
            <PopoverTrigger
                ref={ref}
                // Support legacy buttonElement prop since it's used in the different code hosts
                // specifications
                as={(buttonElement as 'button') ?? Component}
                // eslint-disable-next-line @typescript-eslint/ban-ts-comment
                // @ts-ignore
                variant={variant}
                aria-label="Command list"
                className={classNames(styles.popoverButton, buttonClassName, isOpen && buttonOpenClassName)}
                onClick={toggleIsOpen}
            >
                <Icon size="md" aria-hidden={true} svgPath={mdiConsole} />
                {showCaret && <Icon svgPath={isOpen ? mdiChevronUp : mdiChevronDown} aria-hidden={true} />}
            </PopoverTrigger>

            <PopoverContent className={popoverClassName} position={Position.bottomEnd}>
                <CommandList
                    inputClassName={props.inputClassName}
                    formClassName={props.formClassName}
                    listItemClassName={props.listItemClassName}
                    selectedListItemClassName={props.selectedListItemClassName}
                    selectedActionItemClassName={props.selectedActionItemClassName}
                    listClassName={props.listClassName}
                    resultsContainerClassName={props.resultsContainerClassName}
                    actionItemClassName={props.actionItemClassName}
                    noResultsClassName={props.noResultsClassName}
                    iconClassName={props.iconClassName}
                    menu={props.menu}
                    platformContext={props.platformContext}
                    extensionsController={props.extensionsController}
                    location={props.location}
                    telemetryService={props.telemetryService}
                    onSelect={close}
                />

                {keyboardShortcutForShow?.keybindings.map((keybinding, index) => (
                    <Shortcut key={index} {...keybinding} onMatch={toggleIsOpen} />
                ))}
            </PopoverContent>
        </Popover>
    )
}) as ForwardReferenceComponent<'button', CommandListPopoverButtonProps>
