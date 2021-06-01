import classNames from 'classnames'
import CheckCircleIcon from 'mdi-react/CheckCircleIcon'
import CommentOutlineIcon from 'mdi-react/CommentOutlineIcon'
import DeltaIcon from 'mdi-react/DeltaIcon'
import GateArrowRightIcon from 'mdi-react/GateArrowRightIcon'
import TimerSandIcon from 'mdi-react/TimerSandIcon'
import React from 'react'

import { ExternalChangesetFields, ChangesetReviewState } from '../../../../graphql-operations'

export interface ChangesetReviewStatusCellProps {
    className?: string
    reviewState: NonNullable<ExternalChangesetFields['reviewState']>
}

export const ChangesetReviewStatusCell: React.FunctionComponent<ChangesetReviewStatusCellProps> = ({
    className,
    reviewState,
}) => {
    switch (reviewState) {
        case ChangesetReviewState.APPROVED:
            return <ChangesetReviewStatusApproved className={className} />
        case ChangesetReviewState.CHANGES_REQUESTED:
            return <ChangesetReviewStatusChangesRequested className={className} />
        case ChangesetReviewState.COMMENTED:
            return <ChangesetReviewStatusCommented className={className} />
        case ChangesetReviewState.DISMISSED:
            return <ChangesetReviewStatusDismissed className={className} />
        case ChangesetReviewState.PENDING:
            return <ChangesetReviewStatusPending className={className} />
    }
}

export const ChangesetReviewStatusPending: React.FunctionComponent<{ className?: string }> = ({ className }) => (
    <div
        className={classNames(
            'm-0 text-nowrap d-flex flex-column align-items-center justify-content-center',
            className
        )}
    >
        <TimerSandIcon className="text-warning" />
        <span>Pending</span>
    </div>
)
export const ChangesetReviewStatusDismissed: React.FunctionComponent<{ className?: string }> = ({ className }) => (
    <div
        className={classNames(
            'm-0 text-nowrap d-flex flex-column align-items-center justify-content-center',
            className
        )}
    >
        <GateArrowRightIcon className="text-muted" />
        <span>Dismissed</span>
    </div>
)
export const ChangesetReviewStatusCommented: React.FunctionComponent<{ className?: string }> = ({ className }) => (
    <div
        className={classNames(
            'm-0 text-nowrap d-flex flex-column align-items-center justify-content-center',
            className
        )}
    >
        <CommentOutlineIcon className="text-muted" />
        <span>Commented</span>
    </div>
)
export const ChangesetReviewStatusChangesRequested: React.FunctionComponent<{ className?: string }> = ({
    className,
}) => (
    <div
        className={classNames(
            'm-0 text-nowrap d-flex flex-column align-items-center justify-content-center',
            className
        )}
    >
        <DeltaIcon className="text-warning" />
        <span>Changes requested</span>
    </div>
)
export const ChangesetReviewStatusApproved: React.FunctionComponent<{ className?: string }> = ({ className }) => (
    <div
        className={classNames(
            'm-0 text-nowrap d-flex flex-column align-items-center justify-content-center',
            className
        )}
    >
        <CheckCircleIcon className="text-success" />
        <span>Approved</span>
    </div>
)
