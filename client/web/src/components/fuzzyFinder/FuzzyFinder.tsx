import React, { useEffect, Dispatch, SetStateAction, useCallback, useRef } from 'react'

import * as H from 'history'

import { Shortcut } from '@sourcegraph/shared/src/react-shortcuts'
import { SettingsCascadeProps } from '@sourcegraph/shared/src/settings/settings'
import { TelemetryProps } from '@sourcegraph/shared/src/telemetry/telemetryService'

import { FuzzyModal } from './FuzzyModal'
import { useFuzzyShortcuts } from './FuzzyShortcuts'
import { fuzzyIsActive, FuzzyTabsProps, FuzzyState, useFuzzyState, FuzzyTabKey } from './FuzzyTabs'

const DEFAULT_MAX_RESULTS = 100

export interface FuzzyFinderContainerProps
    extends TelemetryProps,
        Pick<FuzzyFinderProps, 'location'>,
        SettingsCascadeProps,
        FuzzyTabsProps {
    isVisible: boolean
    setIsVisible: React.Dispatch<SetStateAction<boolean>>
}

/**
 * This components registers a global keyboard shortcut to render the fuzzy
 * finder and renders the fuzzy finder.
 */
export const FuzzyFinderContainer: React.FunctionComponent<FuzzyFinderContainerProps> = props => {
    const { isVisible, setIsVisible } = props
    const isVisibleRef = useRef(isVisible)
    isVisibleRef.current = isVisible
    const state = useFuzzyState(props, () => setIsVisible(false))
    const { tabs, activeTab, setActiveTab, repoRevision, toggleGlobalFiles, toggleGlobalSymbols } = state

    // We need useRef to access the latest state inside `openFuzzyFinder` below.
    // The keyboard shortcut does not pick up changes to the callback even if we
    // declare them as dependencies of `openFuzzyFinder`.
    const tabsRef = useRef(tabs)
    tabsRef.current = tabs
    const repositoryName = useRef('')
    repositoryName.current = repoRevision.repositoryName
    const activeTabRef = useRef(activeTab)
    activeTabRef.current = activeTab

    const openFuzzyFinder = useCallback(
        (tab: FuzzyTabKey): void => {
            if (tabsRef.current.isOnlyFilesEnabled() && !repositoryName.current) {
                return // Legacy mode: only activate inside a repository
            }
            const activeTab = activeTabRef.current
            const isVisible = isVisibleRef.current
            if (!isVisible) {
                setIsVisible(true)
            }
            if (isVisible && tab === activeTab) {
                switch (tab) {
                    case 'files':
                        toggleGlobalFiles()
                        break
                    case 'symbols':
                        toggleGlobalSymbols()
                        break
                }
            } else {
                const newTab = tabsRef.current.focusNamedTab(tab)
                if (newTab) {
                    setActiveTab(newTab)
                }
            }
        },
        [setActiveTab, setIsVisible, toggleGlobalFiles, toggleGlobalSymbols]
    )

    const shortcuts = useFuzzyShortcuts(props.settingsCascade.final)

    useEffect(() => {
        if (isVisible) {
            props.telemetryService.log('FuzzyFinderViewed', { action: 'shortcut open' })
        }
    }, [props.telemetryService, isVisible])

    if (tabs.isAllDisabled()) {
        return null
    }

    // Disable the fuzzy finder if only the 'files' tab is enabled and we're not
    // in a repository-related page.
    if (tabs.isOnlyFilesEnabled() && !fuzzyIsActive(activeTab, repoRevision, 'files')) {
        return null
    }

    return (
        <>
            {shortcuts
                .filter(shortcut => shortcut.isEnabled)
                .flatMap(shortcut =>
                    shortcut.shortcut?.keybindings.map(keybinding => (
                        <Shortcut
                            {...keybinding}
                            key={`fuzzy-shortcut-${shortcut.name}-${JSON.stringify(keybinding)}`}
                            onMatch={() => openFuzzyFinder(shortcut.name)}
                            ignoreInput={true}
                        />
                    ))
                )}
            {isVisible && (
                <FuzzyFinder {...state} setIsVisible={bool => setIsVisible(bool)} location={props.location} />
            )}
        </>
    )
}

interface FuzzyFinderProps extends FuzzyState {
    setIsVisible: Dispatch<SetStateAction<boolean>>

    location: H.Location

    /**
     * The maximum number of files a repo can have to use case-insensitive fuzzy finding.
     *
     * Case-insensitive fuzzy finding is more expensive to compute compared to
     * word-sensitive fuzzy finding.  The fuzzy modal will use case-insensitive
     * fuzzy finding when the repo has fewer files than this number, and
     * word-sensitive fuzzy finding otherwise.
     */
    caseInsensitiveFileCountThreshold?: number
}

const FuzzyFinder: React.FunctionComponent<React.PropsWithChildren<FuzzyFinderProps>> = props => {
    const { setIsVisible } = props
    const onClose = useCallback(() => setIsVisible(false), [setIsVisible])

    return <FuzzyModal {...props} initialMaxResults={DEFAULT_MAX_RESULTS} initialQuery="" onClose={onClose} />
}
