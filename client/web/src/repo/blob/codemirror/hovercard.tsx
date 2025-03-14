/* eslint-disable jsdoc/check-indentation */
/**
 * This module provides various view plugins, facets and fields to implement
 * hovercard functionality. Hopefully the following diagram is useful (I wasn't
 * able to adjust the layout; the graph description is in hovercard.dot).
 *
 *                  ┌−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−┐
 *                  ╎     Extensions integration     ╎
 *                  └−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−┘
 *                    │
 *                    │ provides
 *                    ▼
 *                  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
 *       ┌────────▶ ┃    hovercardSource (facet)     ┃
 *       │          ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
 *       │            │
 *       │            │ enables
 *       │            ▼
 *       │          ┌────────────────────────────────┐          ┌────────────────────────┐
 *       │          │   HoverPlugin (view plugin)    │          │ hovercardTheme (theme) │
 *       │          └────────────────────────────────┘          └────────────────────────┘
 *       │            │                                           ▲
 *       │ uses       │ provides                                  │ enables
 *       │            ▼                                           │
 *       │          ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  enables   ┌─────────────────────────┐
 *       │          ┃                      hovercardRanges (facet)                       ┃ ─────────▶ │   activeRanges (field)  │ ◀┐
 *       │          ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛            └─────────────────────────┘  │
 *       │            │                                 ▲         ▲                                     │                          │
 *       │            │ enables                         │ reads   │ provides                            │ provides                 │
 *       │            ▼                                 │         │                                     ▼                          │
 *       │          ┌────────────────────────────────┐  │       ┌−−−−−−−−−−−−−−−−−−−−−−−−┐            ┏━━━━━━━━━━━━━━━━━━━━━━━━━┓  │
 *  ┌────┼───────── │ HovercardManager (view plugin) │ ─┘       ╎     Hovercard pin      ╎            ┃   decoration (facet)    ┃  │ updates
 *  │    │          └────────────────────────────────┘          └−−−−−−−−−−−−−−−−−−−−−−−−┘            ┗━━━━━━━━━━━━━━━━━━━━━━━━━┛  │
 *  │    │            │                                                                                                            │
 *  │    │            │ creates                                                                                                    │
 *  │    │            ▼                                                                                                            │
 *  │    │          ┌────────────────────────────────┐                                                                             │
 *  │    └───────── │    Hovercard (tooltip view)    │ ────────────────────────────────────────────────────────────────────────────┘
 *  │               └────────────────────────────────┘
 *  │   provides    ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
 *  └─────────────▶ ┃      showTooltips (facet)      ┃
 *                  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
 *
 *  The core part is the {@link hovercardRanges} facet. This facet contains the
 *  ranges for which to potentially show hovercards (there may not be hover
 *  information available for these ranges).
 *  The {@link HovercardManager} creates a CodeMirror {@link Tooltip} for every
 *  range, using {@link Hovercard} as the tooltip view implementation and passes
 *  them as input to {@link showTooltips}.
 *
 *  The input for {@link hovercardRanges} comes from (currently) two sources:
 *  (1) a pin extension which provides input if the URL contains a pinned
 *  location and (2) the {@link HoverManager} which finds valid hovercard ranges
 *  underneath the mouse pointer.
 *
 *  Because with the current implementation we don't know which of the
 *  {@link hovercardRanges} also has hover information associated with it, we
 *  require {@link Hovercard} to update {@link activeRanges} as necessary to
 *  highlight the ranges for which hover information exists.
 */
import { Extension, Facet, RangeSet, StateEffect, StateEffectType, StateField, Text } from '@codemirror/state'
import {
    Decoration,
    EditorView,
    PluginValue,
    repositionTooltips,
    showTooltip,
    Tooltip,
    TooltipView,
    ViewPlugin,
    ViewUpdate,
} from '@codemirror/view'
import { createRoot, Root } from 'react-dom/client'
import { combineLatest, fromEvent, Observable, Subject, Subscription } from 'rxjs'
import { startWith, filter } from 'rxjs/operators'

import { addLineRangeQueryParameter, isErrorLike, toPositionOrRangeQueryParameter } from '@sourcegraph/common'
import { createUpdateableField } from '@sourcegraph/shared/src/components/CodeMirrorEditor'
import { UIPositionSpec, UIRangeSpec } from '@sourcegraph/shared/src/util/url'

import {
    getClickToGoToDefinition,
    getGoToURL,
    WebHoverOverlay,
    WebHoverOverlayProps,
} from '../../../components/WebHoverOverlay'
import { BlobProps, updateBrowserHistoryIfChanged } from '../Blob'

import { Container } from './react-interop'
import {
    distinctWordAtCoords,
    offsetToUIPosition,
    preciseOffsetAtCoords,
    rangesContain,
    uiPositionToOffset,
    zeroToOneBasedPosition,
    zeroToOneBasedRange,
} from './utils'

import { blobPropsFacet } from '.'

import webOverlayStyles from '../../../components/WebHoverOverlay/WebHoverOverlay.module.scss'

type UIRange = UIRangeSpec['range']
type UIPosition = UIPositionSpec['position']

type HovercardData = Pick<WebHoverOverlayProps, 'hoverOrError' | 'actionsOrError'>
interface HovercardRange {
    // CodeMirror document offsets
    from: number
    to: number

    // Line/column position
    range: UIRange

    // Sometimes the range returned by the hover provider differs from the
    // "word" range determined by CodeMirror. Highlighting and
    // click-to-go-to-definition should use this range if available.
    providerRange?: UIRange

    // Used to provide "click to go to definition". The presence of this value
    // also indicates that the range should be decorated with a pointer cursor.
    onClick?: () => void

    // Whether or not this hovercard is considered "pinned". We only show a
    // close button for pinned hovercards
    pinned?: boolean
}

/**
 * A HovercardSource is a function that is passed a position and returns an
 * observable that provides hover information.
 */
export type HovercardSource = (view: EditorView, position: UIPosition) => Observable<HovercardData>

/**
 * Some style overrides to replicate the existing hovercard style.
 */
const hovercardTheme = EditorView.theme({
    [`.${webOverlayStyles.webHoverOverlay}`]: {
        // This is normally "position: 'absolute'". CodeMirror does the
        // positioning. Without this CodeMirror thinks the hover content is
        // empty.
        position: 'initial !important',
    },
    '.cm-tooltip': {
        // Reset CodeMirror's default style
        border: 'initial',
        backgroundColor: 'initial',
        // Needed to ensure that the hovercard is not covered by the reference
        // panel header.
        zIndex: 1024,
    },
    '.hover-gtd': {
        cursor: 'pointer',
    },
})

/**
 * This field (and effects) are necessary for highlighting the hovered token
 * properly. Unfortunately we cannot create decorations directly from
 * hovercardRanges because we don't know whether any of these ranges have
 * information associated with them. So it's on the Hovercard instances to
 * inform this field about the ranges that have information.
 * This field also monitors hovercardRanges to remove any stray highlights.
 */
const addRange = StateEffect.define<HovercardRange>()
const removeRange = StateEffect.define<HovercardRange>()
const selectionHighlightDecoration = Decoration.mark({ class: 'selection-highlight' })
const selectionGoToDefinitionDecoration = Decoration.mark({ class: 'selection-highlight hover-gtd' })

const activeRanges = StateField.define<Map<number, HovercardRange>>({
    create() {
        return new Map()
    },

    update(ranges, transaction) {
        const availableRanges = transaction.state.facet(hovercardRanges)

        const newRanges = new Map(ranges)
        let changed = false

        // Remove any values not in the current set of ranges. availableRanges and
        // value will be small, so processing them this way should be fine.
        for (const [key, range] of ranges) {
            // It's enough to look for the range start because we never have
            // overlapping ranges.
            if (!rangesContain(availableRanges, range.from)) {
                newRanges.delete(key)
                changed = true
            }
        }

        for (const effect of transaction.effects) {
            if (effect.is(addRange)) {
                if (rangesContain(availableRanges, effect.value.from)) {
                    // Always set the value even if it might already exist. This
                    // ensures we have up-to-date values for `onClick` and
                    // `providerRange`.
                    newRanges.set(effect.value.from, effect.value)
                    changed = true
                }
            }
            if (effect.is(removeRange)) {
                if (newRanges.has(effect.value.from)) {
                    newRanges.delete(effect.value.from)
                    changed = true
                }
            }
        }

        return changed ? newRanges : ranges
    },

    provide(field) {
        return [
            EditorView.decorations.from(field, ranges => view =>
                RangeSet.of(
                    Array.from(ranges.values(), range => {
                        const { from, to } = getHoverOffsets(range, view.state.doc)
                        return range.onClick
                            ? selectionGoToDefinitionDecoration.range(from, to)
                            : selectionHighlightDecoration.range(from, to)
                    }),
                    true
                )
            ),
            // Handles click-to-go-to-definition if enabled (as determined by WebHoverOverlay)
            EditorView.domEventHandlers({
                click(event: MouseEvent, view: EditorView) {
                    const ranges = view.state.field(activeRanges)
                    if (ranges.size === 0) {
                        return false
                    }

                    // Ignore event when the click event is the result of the
                    // user selecting text
                    if (view.state.selection.main.from !== view.state.selection.main.to) {
                        return false
                    }

                    const offset = preciseOffsetAtCoords(view, event)
                    if (offset === null) {
                        return false
                    }

                    for (const range of ranges.values()) {
                        if (isOffsetInHoverRange(offset, range, view.state.doc)) {
                            range.onClick?.()
                            return true
                        }
                    }
                    return false
                },
            }),
        ]
    },
})

function isOffsetInHoverRange(offset: number, range: HovercardRange, textDocument: Text): boolean {
    if (range.from <= offset && offset <= range.to) {
        return true
    }

    if (range.providerRange) {
        const { from, to } = getHoverOffsets(range, textDocument)
        return from <= offset && offset <= to
    }

    return false
}

function getHoverOffsets(range: HovercardRange, textDocument: Text): { from: number; to: number } {
    if (range.providerRange) {
        const from = uiPositionToOffset(textDocument, range.providerRange.start)
        const to = uiPositionToOffset(textDocument, range.providerRange.end)
        // We only use the code intel range if it maps to a valid position
        // within the document. Otherwise we fall back to the range
        // determined by CodeMirror
        return { from: from ?? range.from, to: to ?? range.to }
    }
    return range
}

/**
 * HovercardMangaer is responsible for creating {@link Tooltip}s and updating
 * the {@link showTooltips} facet.
 * This is done to prevent prevent flickering when a hovercard is pinned or when
 * a pinned and a hovered hovercard are rendered. This class keeps track of for
 * which ranges a tooltip exists and will add/remove tooltips as necessary.
 * Flickering is prevented by reusing existing tooltip instances for existing
 * ranges.
 */
class HovercardManager implements PluginValue {
    private tooltips: Map<string, Tooltip> = new Map()
    private hovercardRanges: readonly HovercardRange[] = []

    constructor(private readonly view: EditorView, private readonly setTooltips: StateEffectType<Tooltip[]>) {}

    public update(update: ViewUpdate): void {
        const ranges = update.state.facet(hovercardRanges)
        if (this.hovercardRanges !== ranges) {
            this.hovercardRanges = ranges
            this.updateTooltips()
        }
    }

    private updateTooltips(): void {
        // Remove removed tooltips
        for (const [key, tooltip] of this.tooltips) {
            if (!this.hovercardRanges.some(range => range.from === tooltip.pos && range.to === tooltip.end)) {
                this.tooltips.delete(key)
            }
        }

        // Add new ranges
        for (const range of this.hovercardRanges) {
            const key = this.toKey(range)
            if (!this.tooltips.has(key)) {
                this.tooltips.set(key, {
                    pos: range.from,
                    end: range.to,
                    above: true,
                    create: view => new Hovercard(view, range),
                })
            }
        }

        // We cannot directly dispatch a transaction within an update cycle
        window.requestAnimationFrame(() =>
            this.view.dispatch({ effects: this.setTooltips.of(Array.from(this.tooltips.values())) })
        )
    }

    private toKey(range: HovercardRange): string {
        return `${range.from}:${range.to}`
    }
}

function hovercardManager(): Extension {
    const [tooltips, , setTooltips] = createUpdateableField<Tooltip[]>([], field =>
        showTooltip.computeN([field], state => state.field(field))
    )

    return [tooltips, ViewPlugin.define(view => new HovercardManager(view, setTooltips))]
}

/**
 * Facet to which an extension can add a value to show a hovercard.
 */
export const hovercardRanges = Facet.define<HovercardRange>({
    enables: [
        hovercardTheme,
        // Compute CodeMirror tooltips from hovercard ranges
        hovercardManager(),
        // Highlight hovered token(s)
        activeRanges,
    ],
})

/**
 * Facet with which an extension can provide a hovercard source. For simplicity
 * only one source can be provided, others are ignored (in practice there is
 * only one source at the moment anyway).
 */
export const hovercardSource = Facet.define<HovercardSource, HovercardSource>({
    combine: sources => sources[0],
    enables: hovercard(),
})

/**
 * Listens to mousemove events, determines whether the position under the mouse
 * cursor is eligible (whether a "word" is under the mouse cursor) and creates
 * range objects for {@link hovercardRanges}.
 */
class HoverManager implements PluginValue {
    private nextOffset = new Subject<number | null>()
    private subscription: Subscription

    constructor(
        private readonly view: EditorView,
        private readonly setHovercardPosition: StateEffectType<HovercardRange | null>
    ) {
        this.subscription = fromEvent<MouseEvent>(this.view.dom, 'mousemove')
            .pipe(
                // Ignore events when hovering over hovercards
                filter(event => !(event.target as HTMLElement | null)?.closest('.cm-code-intel-hovercard')),
                // Ignore events inside an active range.  Without this hovercards
                // flicker when the active range is wider than the
                // word-under-cursor range.
                filter(event => {
                    const offset = preciseOffsetAtCoords(view, event)
                    if (offset === null) {
                        return true
                    }
                    const ranges = view.state.field(activeRanges)
                    return Array.from(ranges.values()).every(
                        range => !isOffsetInHoverRange(offset, range, view.state.doc)
                    )
                }),
                distinctWordAtCoords(this.view)
            )
            .subscribe(position => {
                this.view.dispatch({
                    effects: this.setHovercardPosition.of(
                        position
                            ? {
                                  ...position,
                                  range: offsetToUIPosition(this.view.state.doc, position.from, position.to),
                              }
                            : null
                    ),
                })
            })

        this.view.dom.addEventListener('mouseleave', this.mouseleave)
    }

    private mouseleave = (): void => {
        this.nextOffset.next(null)
    }

    public destroy(): void {
        this.view.dom.removeEventListener('mouseleave', this.mouseleave)
        this.subscription.unsubscribe()
    }
}

function hovercard(): Extension {
    const [hovercardRange, , setHovercardRange] = createUpdateableField<HovercardRange | null>(null, field =>
        hovercardRanges.computeN([field], state => {
            const range = state.field(field)
            return range ? [range] : []
        })
    )

    return [hovercardRange, ViewPlugin.define(view => new HoverManager(view, setHovercardRange))]
}

// WebHoverOverlay expects to be passed the overlay position. Since CodeMirror
// positions the element we always use the same value.
const dummyOverlayPosition = { left: 0, bottom: 0 }

/**
 * This class is responsible for rendering a WebHoverOverlay component as a
 * CodeMirror tooltip. When constructed the instance subscribes to the hovercard
 * data source and the component props, and updates the component as it receives
 * changes.
 */
class Hovercard implements TooltipView {
    public dom: HTMLElement
    private root: Root | null = null
    private nextContainer = new Subject<HTMLElement>()
    private nextProps = new Subject<BlobProps>()
    private props: BlobProps | null = null
    public overlap = true
    private subscription: Subscription
    private nextPinned = new Subject<boolean>()

    constructor(private readonly view: EditorView, private readonly range: HovercardRange) {
        this.dom = document.createElement('div')

        this.subscription = combineLatest([
            this.nextContainer,
            this.view.state.facet(hovercardSource)(view, range.range.start),
            this.nextProps.pipe(startWith(view.state.facet(blobPropsFacet))),
            this.nextPinned.pipe(startWith(range.pinned ?? false)),
        ]).subscribe(([container, hovercardData, props, pinned]) => {
            // undefined means the data is still loading
            if (hovercardData.hoverOrError !== undefined) {
                if (!this.root) {
                    // Defer creating a React container until absolutely
                    // necessary
                    this.root = createRoot(container)
                }
                this.render(this.root, hovercardData, props, pinned)
            }
        })
    }

    public mount(): void {
        this.nextContainer.next(this.dom)
    }

    public update(update: ViewUpdate): void {
        // Umount React components when tooltip range does exist anymore
        if (
            !update.state
                .facet(hovercardRanges)
                .some(range => range.from === this.range.from && range.to === this.range.to)
        ) {
            window.requestAnimationFrame(() => {
                this.root?.unmount()
            })
            this.subscription.unsubscribe()
            return
        }

        // Update component when props change
        const props = update.state.facet(blobPropsFacet)
        if (this.props !== props) {
            this.props = props
            this.nextProps.next(props)
        }
    }

    private addRange(extendedProperties: { providerRange?: UIRange; onClick?: () => void }): void {
        window.requestAnimationFrame(() => {
            this.view.dispatch({ effects: addRange.of({ ...this.range, ...extendedProperties }) })
        })
    }

    private removeRange(): void {
        window.requestAnimationFrame(() => {
            this.view.dispatch({ effects: removeRange.of(this.range) })
        })
    }

    private render(
        root: Root,
        { hoverOrError, actionsOrError }: HovercardData,
        props: BlobProps,
        pinned: boolean
    ): void {
        // Only render if we either have something for hover or actions. Adapted
        // from shouldRenderOverlay in codeintellify/src/hoverifier.ts
        if (
            !(
                (hoverOrError && hoverOrError !== 'loading') ||
                (actionsOrError &&
                    actionsOrError !== 'loading' &&
                    (isErrorLike(actionsOrError) || actionsOrError.length > 0))
            ) ||
            props.extensionsController === null
        ) {
            this.removeRange()
            root.render([])
            return
        }

        // Used to implement "click to go to definition"
        let onClick: (() => void) | undefined

        // Adaption of the "click to go to definition" code inside
        // WebHoverOverlay
        if (getClickToGoToDefinition(props.settingsCascade)) {
            const urlAndType = getGoToURL(actionsOrError, props.location)
            if (urlAndType) {
                const { url, actionType } = urlAndType
                onClick = () => {
                    props.telemetryService.log(`${actionType}HoverOverlay.click`)
                    if (props.nav) {
                        props.nav(url)
                    } else {
                        props.history.push(url)
                    }
                }
            }
        }

        const hoverContext = {
            commitID: props.blobInfo.commitID,
            filePath: props.blobInfo.filePath,
            repoName: props.blobInfo.repoName,
            revision: props.blobInfo.revision,
        }

        let hoveredToken: WebHoverOverlayProps['hoveredToken'] = {
            ...hoverContext,
            ...this.range.range.start,
        }

        if (hoverOrError && hoverOrError !== 'loading' && !isErrorLike(hoverOrError) && hoverOrError.range) {
            hoveredToken = {
                ...hoveredToken,
                ...zeroToOneBasedPosition(hoverOrError.range.start),
            }
            this.addRange({
                providerRange: zeroToOneBasedRange(hoverOrError.range),
                onClick,
            })
        } else {
            this.addRange({ onClick })
        }

        root.render(
            <Container onRender={() => repositionTooltips(this.view)} history={props.history}>
                <div className="cm-code-intel-hovercard">
                    <WebHoverOverlay
                        // Blob props
                        location={props.location}
                        onHoverShown={props.onHoverShown}
                        isLightTheme={props.isLightTheme}
                        platformContext={props.platformContext}
                        settingsCascade={props.settingsCascade}
                        telemetryService={props.telemetryService}
                        extensionsController={props.extensionsController}
                        // Hover props
                        actionsOrError={actionsOrError}
                        hoverOrError={hoverOrError}
                        // CodeMirror handles the positioning but a
                        // non-nullable value must be passed for the
                        // hovercard to render
                        overlayPosition={dummyOverlayPosition}
                        hoveredToken={hoveredToken}
                        onAlertDismissed={() => repositionTooltips(this.view)}
                        pinOptions={{
                            showCloseButton: pinned,
                            onCloseButtonClick: () => {
                                const parameters = new URLSearchParams(props.location.search)
                                parameters.delete('popover')

                                updateBrowserHistoryIfChanged(props.history, props.location, parameters)
                                this.nextPinned.next(false)
                            },
                            onCopyLinkButtonClick: async () => {
                                const context = {
                                    position: this.range.range.start,
                                    range: {
                                        start: this.range.range.start,
                                        end: this.range.range.start,
                                    },
                                }
                                const search = new URLSearchParams(location.search)
                                search.set('popover', 'pinned')
                                updateBrowserHistoryIfChanged(
                                    props.history,
                                    props.location,
                                    addLineRangeQueryParameter(search, toPositionOrRangeQueryParameter(context))
                                )
                                await navigator.clipboard.writeText(window.location.href)

                                this.nextPinned.next(true)
                            },
                        }}
                    />
                </div>
            </Container>
        )
    }
}
