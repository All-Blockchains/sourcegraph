import React, { useEffect, useMemo } from 'react'

import { RouteComponentProps } from 'react-router'
import { Observable, Subject } from 'rxjs'
import { map } from 'rxjs/operators'

import { createAggregateError } from '@sourcegraph/common'
import { gql } from '@sourcegraph/http-client'
import * as GQL from '@sourcegraph/shared/src/schema'
import { H2 } from '@sourcegraph/wildcard'

import { queryGraphQL } from '../../../../backend/graphql'
import { FilteredConnection } from '../../../../components/FilteredConnection'
import { PageTitle } from '../../../../components/PageTitle'
import { eventLogger } from '../../../../tracking/eventLogger'
import { userURL } from '../../../../user'
import { AccountName } from '../../../dotcom/productSubscriptions/AccountName'

const siteAdminCustomerFragment = gql`
    fragment CustomerFields on User {
        id
        username
        displayName
    }
`

interface SiteAdminCustomerNodeProps {
    node: Pick<GQL.IUser, 'id' | 'username' | 'displayName'>
}

/**
 * Displays a customer in a connection in the site admin area.
 */
const SiteAdminCustomerNode: React.FunctionComponent<React.PropsWithChildren<SiteAdminCustomerNodeProps>> = ({
    node,
}) => (
    <li className="list-group-item py-2">
        <div className="d-flex align-items-center justify-content-between">
            <span className="mr-3">
                <AccountName account={node} link={`${userURL(node.username)}/subscriptions`} />
            </span>
        </div>
    </li>
)

interface Props extends RouteComponentProps<{}> {}

class FilteredSiteAdminCustomerConnection extends FilteredConnection<
    Pick<GQL.IUser, 'id' | 'username' | 'displayName'>,
    Pick<SiteAdminCustomerNodeProps, Exclude<keyof SiteAdminCustomerNodeProps, 'node'>>
> {}

/**
 * Displays a list of customers associated with user accounts on Sourcegraph.com.
 */
export const SiteAdminProductCustomersPage: React.FunctionComponent<React.PropsWithChildren<Props>> = props => {
    useEffect(() => eventLogger.logViewEvent('SiteAdminProductCustomers'), [])

    const updates = useMemo(() => new Subject<void>(), [])
    const nodeProps: Pick<SiteAdminCustomerNodeProps, Exclude<keyof SiteAdminCustomerNodeProps, 'node'>> = {}

    return (
        <div className="site-admin-customers-page">
            <PageTitle title="Customers" />
            <div className="d-flex justify-content-between align-items-center mb-1">
                <H2 className="mb-0">Customers</H2>
            </div>
            <FilteredSiteAdminCustomerConnection
                className="list-group list-group-flush mt-3"
                noun="customer"
                pluralNoun="customers"
                queryConnection={queryCustomers}
                nodeComponent={SiteAdminCustomerNode}
                nodeComponentProps={nodeProps}
                noSummaryIfAllNodesVisible={true}
                updates={updates}
                history={props.history}
                location={props.location}
            />
        </div>
    )
}

function queryCustomers(args: { first?: number; query?: string }): Observable<GQL.IUserConnection> {
    return queryGraphQL(
        gql`
            query Customers($first: Int, $query: String) {
                users(first: $first, query: $query) {
                    nodes {
                        ...CustomerFields
                    }
                    totalCount
                    pageInfo {
                        hasNextPage
                    }
                }
            }
            ${siteAdminCustomerFragment}
        `,
        {
            first: args.first,
            query: args.query,
        } as GQL.IUsersOnQueryArguments
    ).pipe(
        map(({ data, errors }) => {
            if (!data || !data.users || (errors && errors.length > 0)) {
                throw createAggregateError(errors)
            }
            return data.users
        })
    )
}
