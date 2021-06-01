import classNames from 'classnames'
import CheckCircleIcon from 'mdi-react/CheckCircleIcon'
import CloseCircleIcon from 'mdi-react/CloseCircleIcon'
import TimerSandIcon from 'mdi-react/TimerSandIcon'
import React from 'react'

import { ExternalChangesetFields, ChangesetCheckState } from '../../../../graphql-operations'

export interface ChangesetCheckStatusCellProps {
    className?: string
    checkState: NonNullable<ExternalChangesetFields['checkState']>
}

export const ChangesetCheckStatusCell: React.FunctionComponent<ChangesetCheckStatusCellProps> = ({
    className,
    checkState,
}) => {
    switch (checkState) {
        case ChangesetCheckState.PENDING:
            return <ChangesetCheckStatusPending className={className} />
        case ChangesetCheckState.PASSED:
            return <ChangesetCheckStatusPassed className={className} />
        case ChangesetCheckState.FAILED:
            return <ChangesetCheckStatusFailed className={className} />
    }
}

export const ChangesetCheckStatusPending: React.FunctionComponent<{ className?: string }> = ({ className }) => (
    <div
        className={classNames(
            'm-0 text-nowrap d-flex flex-column align-items-center justify-content-center',
            className
        )}
    >
        <TimerSandIcon className="text-warning" data-tooltip="Check state is pending" />
        <span>Pending</span>
    </div>
)
export const ChangesetCheckStatusPassed: React.FunctionComponent<{ className?: string }> = ({ className }) => (
    <div
        className={classNames(
            'm-0 text-nowrap d-flex flex-column align-items-center justify-content-center',
            className
        )}
    >
        <CheckCircleIcon className="text-success" data-tooltip="All checks complete" />
        <span>Passed</span>
    </div>
)
export const ChangesetCheckStatusFailed: React.FunctionComponent<{ className?: string }> = ({ className }) => (
    <div
        className={classNames(
            'm-0 text-nowrap d-flex flex-column align-items-center justify-content-center',
            className
        )}
    >
        <CloseCircleIcon className="text-danger" data-tooltip="Some checks failed" />
        <span>Failed</span>
    </div>
)
