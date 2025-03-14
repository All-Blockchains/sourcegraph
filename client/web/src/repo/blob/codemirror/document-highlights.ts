/**
 * This provides CodeMirror extension for handling document highlights.
 * Extensions which want to provide document highlights should register
 * themselves as a data source with the {@link documentHighlightsSource} facet.
 * {@link DocumentHighlightsManager} takes care of listening to mouse events and
 * triggering an update if necessary. All document highlights are provided via
 * and converted to CodeMirror decorations via the {@link showDocumentHighlights}
 * facet.
 */
import {
    Extension,
    Facet,
    RangeSet,
    RangeSetBuilder,
    RangeValue,
    StateEffectType,
    StateField,
    Text,
} from '@codemirror/state'
import { Decoration, DecorationSet, EditorView, ViewPlugin } from '@codemirror/view'
import { from, fromEvent, Observable, Subscription } from 'rxjs'
import { switchMap, filter, mergeAll, map, tap } from 'rxjs/operators'

import { DocumentHighlight } from '@sourcegraph/codeintellify'
import { Position } from '@sourcegraph/extension-api-types'
import { createUpdateableField } from '@sourcegraph/shared/src/components/CodeMirrorEditor'
import { UIPositionSpec } from '@sourcegraph/shared/src/util/url'

import { offsetToUIPosition, positionToOffset, distinctWordAtCoords, sortRangeValuesByStart } from './utils'

type DocumentHighlightsSource = (position: Position) => Observable<DocumentHighlight[]>

const highlightDecoration = Decoration.mark({ class: 'sourcegraph-document-highlight' })

/**
 * Facet with which an extension can add document highlights to show. Adding a
 * value of this facet enables the necessary extensions to render CodeMirror
 * decorations for the document highlights.
 */
export const showDocumentHighlights = Facet.define<DocumentHighlight[], DocumentHighlight[]>({
    combine: highlights => highlights.flat(),
    compare: (a, b) => a === b || (a.length === 0 && b.length === 0),
    enables: facet =>
        EditorView.decorations.compute([facet], state => {
            const documentHighlights = state.facet(facet)
            let decorations: DecorationSet | null = null

            return view => {
                if (decorations) {
                    return decorations
                }

                return (decorations = documentHighlightsToRangeSet(
                    view.state.doc,
                    documentHighlights,
                    highlightDecoration
                ))
            }
        }),
})

// This helper function is exported for testing purposes
export function documentHighlightsToRangeSet<T extends RangeValue>(
    textDocument: Text,
    highlights: DocumentHighlight[],
    rangeValue: T
): RangeSet<T> {
    if (documentHighlights?.length > 0) {
        const builder = new RangeSetBuilder<T>()

        // Most of the time number of highlights is small and close
        // together so it's likely ok to iterate over all them and
        // not just the ones in the current viewport.
        for (const highlight of sortRangeValuesByStart(highlights)) {
            const rangeStart = positionToOffset(textDocument, highlight.range.start)
            const rangeEnd = positionToOffset(textDocument, highlight.range.end)
            if (rangeStart !== null && rangeEnd !== null) {
                builder.add(rangeStart, rangeEnd, rangeValue)
            }
        }

        return builder.finish()
    }
    return RangeSet.empty
}

/**
 * Facet with which an extension can provide a document highlight source. Each
 * source is called when the cursor position changes. Adding a value for this
 * facet enables the necessary extensions that listen to CodeMirror events.
 */
export const documentHighlightsSource = Facet.define<DocumentHighlightsSource>({
    enables: facet => documentHighlights(facet, showDocumentHighlights),
})

/**
 * Together with {@link DocumentHighlightsManager} provides an extenion that
 * fetches document higlights from Sourcegraph extensions.
 */
function documentHighlights(sources: Facet<DocumentHighlightsSource>, sink: Facet<DocumentHighlight[]>): Extension {
    // This field is used to provide inputs for the documentHighlights facet.
    // The facet gets updated whenever the field changes. The view plugin
    // listens to mouse events, sents queries to the extensions host and
    // dispatches transactions to update the field.
    const [documentHighlightsField, , setDocumentHighlights] = createUpdateableField<DocumentHighlight[]>([], field =>
        sink.from(field)
    )

    return [
        documentHighlightsField,
        ViewPlugin.define(
            view => new DocumentHighlightsManager(view, sources, documentHighlightsField, setDocumentHighlights)
        ),
    ]
}

/**
 * This class listens to CodeMirror mouse events, queries the registered data
 * sources (see {@link documentHighlightsSource}) and updates the
 * {@link showDocumentHighlights} facet with their responses.
 */
class DocumentHighlightsManager {
    private querySubscription: Subscription

    constructor(
        private readonly view: EditorView,
        private readonly sources: Facet<DocumentHighlightsSource>,
        private readonly documentHighlightsField: StateField<DocumentHighlight[]>,
        private readonly setDocumentHighlights: StateEffectType<DocumentHighlight[]>
    ) {
        this.querySubscription = fromEvent<MouseEvent>(this.view.contentDOM, 'mousemove')
            .pipe(
                distinctWordAtCoords(this.view),
                tap(word => {
                    if (!word) {
                        this.clearHighlights()
                    }
                }),
                // Convert from offsets to UIPosition. We only need the start
                // position
                map(word => (word ? offsetToUIPosition(this.view.state.doc, word.from) : null)),
                // Ignore position changes if we already have a document highlight
                // within that range
                filter(
                    position =>
                        !(
                            position &&
                            hasDocumentHighlightAtPosition(view.state.field(documentHighlightsField), position)
                        )
                ),
                // Cancel any running query when a new position comes in (could be null)
                switchMap(position =>
                    from(position ? view.state.facet(this.sources).map(source => source(position)) : []).pipe(
                        mergeAll()
                    )
                )
            )
            .subscribe(highlights => {
                if (highlights.length === 0 && view.state.field(documentHighlightsField).length === 0) {
                    // No need to schedule a transaction if the state is already
                    // empty anyway.
                    return
                }
                view.dispatch({ effects: setDocumentHighlights.of(highlights) })
            })
    }

    public destroy(): void {
        this.querySubscription.unsubscribe()
    }

    private clearHighlights(): void {
        if (this.view.state.field(this.documentHighlightsField).length > 0) {
            this.view.dispatch({ effects: this.setDocumentHighlights.of([]) })
        }
    }
}

/**
 * Helper function for determining whether the given position is with any of the
 * document highlight ranges.
 */
function hasDocumentHighlightAtPosition(
    highlights: DocumentHighlight[],
    position: UIPositionSpec['position']
): boolean {
    for (const {
        range: { start, end },
    } of highlights) {
        if (
            position.line >= start.line + 1 &&
            position.line <= end.line + 1 &&
            position.character >= start.character + 1 &&
            position.character <= end.character + 1
        ) {
            return true
        }
    }
    return false
}
