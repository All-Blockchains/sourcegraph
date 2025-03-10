# Dashboards reference

<!-- DO NOT EDIT: generated via: go generate ./monitoring -->

This document contains a complete reference on Sourcegraph's available dashboards, as well as details on how to interpret the panels and metrics.

To learn more about Sourcegraph's metrics and how to view these dashboards, see [our metrics guide](https://docs.sourcegraph.com/admin/observability/metrics).

## Frontend

<p class="subtitle">Serves all end-user browser and API requests.</p>

To see this dashboard, visit `/-/debug/grafana/d/frontend/frontend` on your Sourcegraph instance.

### Frontend: Search at a glance

#### frontend: 99th_percentile_search_request_duration

<p class="subtitle">99th percentile successful search request duration over 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-99th-percentile-search-request-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum by (le)(rate(src_search_streaming_latency_seconds_bucket{source="browser"}[5m])))`

</details>

<br />

#### frontend: 90th_percentile_search_request_duration

<p class="subtitle">90th percentile successful search request duration over 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-90th-percentile-search-request-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le)(rate(src_search_streaming_latency_seconds_bucket{source="browser"}[5m])))`

</details>

<br />

#### frontend: hard_timeout_search_responses

<p class="subtitle">Hard timeout search responses every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-hard-timeout-search-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `(sum(increase(src_graphql_search_response{status="timeout",source="browser",request_name!="CodeIntelSearch"}[5m])) + sum(increase(src_graphql_search_response{status="alert",alert_type="timed_out",source="browser",request_name!="CodeIntelSearch"}[5m]))) / sum(increase(src_graphql_search_response{source="browser",request_name!="CodeIntelSearch"}[5m])) * 100`

</details>

<br />

#### frontend: hard_error_search_responses

<p class="subtitle">Hard error search responses every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-hard-error-search-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (status)(increase(src_graphql_search_response{status=~"error",source="browser",request_name!="CodeIntelSearch"}[5m])) / ignoring(status) group_left sum(increase(src_graphql_search_response{source="browser",request_name!="CodeIntelSearch"}[5m])) * 100`

</details>

<br />

#### frontend: partial_timeout_search_responses

<p class="subtitle">Partial timeout search responses every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-partial-timeout-search-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (status)(increase(src_graphql_search_response{status="partial_timeout",source="browser",request_name!="CodeIntelSearch"}[5m])) / ignoring(status) group_left sum(increase(src_graphql_search_response{source="browser",request_name!="CodeIntelSearch"}[5m])) * 100`

</details>

<br />

#### frontend: search_alert_user_suggestions

<p class="subtitle">Search alert user suggestions shown every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-search-alert-user-suggestions) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100013` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (alert_type)(increase(src_graphql_search_response{status="alert",alert_type!~"timed_out|no_results__suggest_quotes",source="browser",request_name!="CodeIntelSearch"}[5m])) / ignoring(alert_type) group_left sum(increase(src_graphql_search_response{source="browser",request_name!="CodeIntelSearch"}[5m])) * 100`

</details>

<br />

#### frontend: page_load_latency

<p class="subtitle">90th percentile page load latency over all routes over 10m</p>

Refer to the [alerts reference](./alerts.md#frontend-page-load-latency) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100020` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.9, sum by(le) (rate(src_http_request_duration_seconds_bucket{route!="raw",route!="blob",route!~"graphql.*"}[10m])))`

</details>

<br />

#### frontend: blob_load_latency

<p class="subtitle">90th percentile blob load latency over 10m</p>

Refer to the [alerts reference](./alerts.md#frontend-blob-load-latency) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100021` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.9, sum by(le) (rate(src_http_request_duration_seconds_bucket{route="blob"}[10m])))`

</details>

<br />

### Frontend: Search-based code intelligence at a glance

#### frontend: 99th_percentile_search_codeintel_request_duration

<p class="subtitle">99th percentile code-intel successful search request duration over 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-99th-percentile-search-codeintel-request-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum by (le)(rate(src_graphql_field_seconds_bucket{type="Search",field="results",error="false",source="browser",request_name="CodeIntelSearch"}[5m])))`

</details>

<br />

#### frontend: 90th_percentile_search_codeintel_request_duration

<p class="subtitle">90th percentile code-intel successful search request duration over 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-90th-percentile-search-codeintel-request-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le)(rate(src_graphql_field_seconds_bucket{type="Search",field="results",error="false",source="browser",request_name="CodeIntelSearch"}[5m])))`

</details>

<br />

#### frontend: hard_timeout_search_codeintel_responses

<p class="subtitle">Hard timeout search code-intel responses every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-hard-timeout-search-codeintel-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `(sum(increase(src_graphql_search_response{status="timeout",source="browser",request_name="CodeIntelSearch"}[5m])) + sum(increase(src_graphql_search_response{status="alert",alert_type="timed_out",source="browser",request_name="CodeIntelSearch"}[5m]))) / sum(increase(src_graphql_search_response{source="browser",request_name="CodeIntelSearch"}[5m])) * 100`

</details>

<br />

#### frontend: hard_error_search_codeintel_responses

<p class="subtitle">Hard error search code-intel responses every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-hard-error-search-codeintel-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (status)(increase(src_graphql_search_response{status=~"error",source="browser",request_name="CodeIntelSearch"}[5m])) / ignoring(status) group_left sum(increase(src_graphql_search_response{source="browser",request_name="CodeIntelSearch"}[5m])) * 100`

</details>

<br />

#### frontend: partial_timeout_search_codeintel_responses

<p class="subtitle">Partial timeout search code-intel responses every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-partial-timeout-search-codeintel-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (status)(increase(src_graphql_search_response{status="partial_timeout",source="browser",request_name="CodeIntelSearch"}[5m])) / ignoring(status) group_left sum(increase(src_graphql_search_response{status="partial_timeout",source="browser",request_name="CodeIntelSearch"}[5m])) * 100`

</details>

<br />

#### frontend: search_codeintel_alert_user_suggestions

<p class="subtitle">Search code-intel alert user suggestions shown every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-search-codeintel-alert-user-suggestions) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100113` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (alert_type)(increase(src_graphql_search_response{status="alert",alert_type!~"timed_out",source="browser",request_name="CodeIntelSearch"}[5m])) / ignoring(alert_type) group_left sum(increase(src_graphql_search_response{source="browser",request_name="CodeIntelSearch"}[5m])) * 100`

</details>

<br />

### Frontend: Search GraphQL API usage at a glance

#### frontend: 99th_percentile_search_api_request_duration

<p class="subtitle">99th percentile successful search API request duration over 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-99th-percentile-search-api-request-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum by (le)(rate(src_graphql_field_seconds_bucket{type="Search",field="results",error="false",source="other"}[5m])))`

</details>

<br />

#### frontend: 90th_percentile_search_api_request_duration

<p class="subtitle">90th percentile successful search API request duration over 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-90th-percentile-search-api-request-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le)(rate(src_graphql_field_seconds_bucket{type="Search",field="results",error="false",source="other"}[5m])))`

</details>

<br />

#### frontend: hard_error_search_api_responses

<p class="subtitle">Hard error search API responses every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-hard-error-search-api-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (status)(increase(src_graphql_search_response{status=~"error",source="other"}[5m])) / ignoring(status) group_left sum(increase(src_graphql_search_response{source="other"}[5m]))`

</details>

<br />

#### frontend: partial_timeout_search_api_responses

<p class="subtitle">Partial timeout search API responses every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-partial-timeout-search-api-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_graphql_search_response{status="partial_timeout",source="other"}[5m])) / sum(increase(src_graphql_search_response{source="other"}[5m]))`

</details>

<br />

#### frontend: search_api_alert_user_suggestions

<p class="subtitle">Search API alert user suggestions shown every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-search-api-alert-user-suggestions) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (alert_type)(increase(src_graphql_search_response{status="alert",alert_type!~"timed_out|no_results__suggest_quotes",source="other"}[5m])) / ignoring(alert_type) group_left sum(increase(src_graphql_search_response{status="alert",source="other"}[5m]))`

</details>

<br />

### Frontend: Codeintel: Precise code intelligence usage at a glance

#### frontend: codeintel_resolvers_total

<p class="subtitle">Aggregate graphql operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_resolvers_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_resolvers_99th_percentile_duration

<p class="subtitle">Aggregate successful graphql operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_resolvers_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_resolvers_errors_total

<p class="subtitle">Aggregate graphql operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_resolvers_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_resolvers_error_rate

<p class="subtitle">Aggregate graphql operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_resolvers_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_codeintel_resolvers_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_codeintel_resolvers_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: codeintel_resolvers_total

<p class="subtitle">Graphql operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_resolvers_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_resolvers_99th_percentile_duration

<p class="subtitle">99th percentile successful graphql operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_resolvers_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: codeintel_resolvers_errors_total

<p class="subtitle">Graphql operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_resolvers_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_resolvers_error_rate

<p class="subtitle">Graphql operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100313` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_resolvers_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_codeintel_resolvers_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_codeintel_resolvers_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Codeintel: Auto-index enqueuer

#### frontend: codeintel_autoindex_enqueuer_total

<p class="subtitle">Aggregate enqueuer operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindex_enqueuer_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_autoindex_enqueuer_99th_percentile_duration

<p class="subtitle">Aggregate successful enqueuer operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_autoindex_enqueuer_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_autoindex_enqueuer_errors_total

<p class="subtitle">Aggregate enqueuer operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindex_enqueuer_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_autoindex_enqueuer_error_rate

<p class="subtitle">Aggregate enqueuer operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100403` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindex_enqueuer_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_codeintel_autoindex_enqueuer_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_codeintel_autoindex_enqueuer_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: codeintel_autoindex_enqueuer_total

<p class="subtitle">Enqueuer operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindex_enqueuer_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_autoindex_enqueuer_99th_percentile_duration

<p class="subtitle">99th percentile successful enqueuer operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100411` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_autoindex_enqueuer_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: codeintel_autoindex_enqueuer_errors_total

<p class="subtitle">Enqueuer operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100412` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindex_enqueuer_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_autoindex_enqueuer_error_rate

<p class="subtitle">Enqueuer operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100413` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindex_enqueuer_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_codeintel_autoindex_enqueuer_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_codeintel_autoindex_enqueuer_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Codeintel: dbstore stats

#### frontend: codeintel_uploads_store_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploads_store_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploads_store_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploads_store_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100502` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploads_store_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100503` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_codeintel_uploads_store_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_codeintel_uploads_store_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: codeintel_uploads_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100510` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploads_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100511` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploads_store_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: codeintel_uploads_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100512` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploads_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100513` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_codeintel_uploads_store_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Workerutil: lsif_indexes dbworker/store stats

#### frontend: workerutil_dbworker_store_codeintel_index_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_codeintel_index_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: workerutil_dbworker_store_codeintel_index_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_workerutil_dbworker_store_codeintel_index_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: workerutil_dbworker_store_codeintel_index_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100602` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_codeintel_index_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: workerutil_dbworker_store_codeintel_index_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100603` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_codeintel_index_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_workerutil_dbworker_store_codeintel_index_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_workerutil_dbworker_store_codeintel_index_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Codeintel: lsifstore stats

#### frontend: codeintel_uploads_lsifstore_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100700` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_lsifstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploads_lsifstore_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100701` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploads_lsifstore_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploads_lsifstore_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100702` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploads_lsifstore_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100703` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_codeintel_uploads_lsifstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: codeintel_uploads_lsifstore_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100710` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_lsifstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploads_lsifstore_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100711` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploads_lsifstore_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: codeintel_uploads_lsifstore_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100712` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploads_lsifstore_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100713` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_codeintel_uploads_lsifstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Codeintel: gitserver client

#### frontend: codeintel_gitserver_total

<p class="subtitle">Aggregate client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100800` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_gitserver_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_gitserver_99th_percentile_duration

<p class="subtitle">Aggregate successful client operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100801` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_gitserver_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_gitserver_errors_total

<p class="subtitle">Aggregate client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100802` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_gitserver_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_gitserver_error_rate

<p class="subtitle">Aggregate client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100803` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_gitserver_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_codeintel_gitserver_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_codeintel_gitserver_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: codeintel_gitserver_total

<p class="subtitle">Client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100810` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_gitserver_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_gitserver_99th_percentile_duration

<p class="subtitle">99th percentile successful client operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100811` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_gitserver_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: codeintel_gitserver_errors_total

<p class="subtitle">Client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100812` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_gitserver_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_gitserver_error_rate

<p class="subtitle">Client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100813` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_gitserver_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_codeintel_gitserver_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_codeintel_gitserver_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Codeintel: uploadstore stats

#### frontend: codeintel_uploadstore_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploadstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploadstore_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100901` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploadstore_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploadstore_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100902` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploadstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploadstore_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100903` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploadstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_codeintel_uploadstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_codeintel_uploadstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: codeintel_uploadstore_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100910` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploadstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploadstore_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100911` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploadstore_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: codeintel_uploadstore_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100912` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploadstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_uploadstore_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=100913` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploadstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_codeintel_uploadstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_codeintel_uploadstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Codeintel: dependencies service stats

#### frontend: codeintel_dependencies_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependencies_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_dependencies_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependencies_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101003` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependencies_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_codeintel_dependencies_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_codeintel_dependencies_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: codeintel_dependencies_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_dependencies_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_dependencies_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: codeintel_dependencies_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_dependencies_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101013` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_dependencies_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_codeintel_dependencies_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_codeintel_dependencies_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Codeintel: dependencies service store stats

#### frontend: codeintel_dependencies_background_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependencies_background_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_background_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_dependencies_background_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_background_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_background_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101103` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_codeintel_dependencies_background_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: codeintel_dependencies_background_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_dependencies_background_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_background_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_dependencies_background_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: codeintel_dependencies_background_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_background_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101113` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_codeintel_dependencies_background_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Codeintel: dependencies service background stats

#### frontend: codeintel_dependencies_background_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependencies_background_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_background_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_dependencies_background_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_background_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_background_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101203` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_codeintel_dependencies_background_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: codeintel_dependencies_background_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_dependencies_background_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_background_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_dependencies_background_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: codeintel_dependencies_background_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_dependencies_background_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101213` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_codeintel_dependencies_background_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_codeintel_dependencies_background_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Codeintel: lockfiles service stats

#### frontend: codeintel_lockfiles_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_lockfiles_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_lockfiles_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_lockfiles_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_lockfiles_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_lockfiles_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_lockfiles_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_lockfiles_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_codeintel_lockfiles_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_codeintel_lockfiles_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: codeintel_lockfiles_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_lockfiles_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_lockfiles_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_lockfiles_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: codeintel_lockfiles_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_lockfiles_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: codeintel_lockfiles_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101313` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_lockfiles_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_codeintel_lockfiles_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_codeintel_lockfiles_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Gitserver: Gitserver Client

#### frontend: gitserver_client_total

<p class="subtitle">Aggregate graphql operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_gitserver_client_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: gitserver_client_99th_percentile_duration

<p class="subtitle">Aggregate successful graphql operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_gitserver_client_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: gitserver_client_errors_total

<p class="subtitle">Aggregate graphql operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_gitserver_client_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: gitserver_client_error_rate

<p class="subtitle">Aggregate graphql operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101403` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_gitserver_client_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_gitserver_client_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_gitserver_client_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: gitserver_client_total

<p class="subtitle">Graphql operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_gitserver_client_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: gitserver_client_99th_percentile_duration

<p class="subtitle">99th percentile successful graphql operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101411` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_gitserver_client_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: gitserver_client_errors_total

<p class="subtitle">Graphql operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101412` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_gitserver_client_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: gitserver_client_error_rate

<p class="subtitle">Graphql operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101413` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_gitserver_client_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_gitserver_client_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_gitserver_client_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Batches: dbstore stats

#### frontend: batches_dbstore_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_dbstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_dbstore_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_batches_dbstore_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_dbstore_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101502` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_dbstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_dbstore_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101503` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_dbstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_batches_dbstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_batches_dbstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: batches_dbstore_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101510` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_dbstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_dbstore_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101511` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_batches_dbstore_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: batches_dbstore_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101512` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_dbstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_dbstore_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101513` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_dbstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_batches_dbstore_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_batches_dbstore_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Batches: service stats

#### frontend: batches_service_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_service_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_service_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_batches_service_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_service_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101602` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_service_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_service_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101603` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_service_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_batches_service_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_batches_service_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: batches_service_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101610` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_service_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_service_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101611` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_batches_service_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: batches_service_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101612` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_service_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_service_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101613` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_service_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_batches_service_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_batches_service_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Batches: Workspace execution dbstore

#### frontend: workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101700` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101701` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101702` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101703` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Batches: HTTP API File Handler

#### frontend: batches_httpapi_total

<p class="subtitle">Aggregate http handler operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101800` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_httpapi_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_httpapi_99th_percentile_duration

<p class="subtitle">Aggregate successful http handler operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101801` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_batches_httpapi_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_httpapi_errors_total

<p class="subtitle">Aggregate http handler operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101802` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_httpapi_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_httpapi_error_rate

<p class="subtitle">Aggregate http handler operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101803` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_httpapi_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_batches_httpapi_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_batches_httpapi_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: batches_httpapi_total

<p class="subtitle">Http handler operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101810` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_httpapi_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_httpapi_99th_percentile_duration

<p class="subtitle">99th percentile successful http handler operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101811` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_batches_httpapi_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: batches_httpapi_errors_total

<p class="subtitle">Http handler operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101812` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_httpapi_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: batches_httpapi_error_rate

<p class="subtitle">Http handler operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101813` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_httpapi_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op)(increase(src_batches_httpapi_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op)(increase(src_batches_httpapi_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Out-of-band migrations: up migration invocation (one batch processed)

#### frontend: oobmigration_total

<p class="subtitle">Migration handler operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_oobmigration_total{op="up",job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: oobmigration_99th_percentile_duration

<p class="subtitle">Aggregate successful migration handler operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101901` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_oobmigration_duration_seconds_bucket{op="up",job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: oobmigration_errors_total

<p class="subtitle">Migration handler operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101902` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_oobmigration_errors_total{op="up",job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: oobmigration_error_rate

<p class="subtitle">Migration handler operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=101903` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_oobmigration_errors_total{op="up",job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_oobmigration_total{op="up",job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_oobmigration_errors_total{op="up",job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Out-of-band migrations: down migration invocation (one batch processed)

#### frontend: oobmigration_total

<p class="subtitle">Migration handler operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_oobmigration_total{op="down",job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: oobmigration_99th_percentile_duration

<p class="subtitle">Aggregate successful migration handler operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_oobmigration_duration_seconds_bucket{op="down",job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: oobmigration_errors_total

<p class="subtitle">Migration handler operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_oobmigration_errors_total{op="down",job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: oobmigration_error_rate

<p class="subtitle">Migration handler operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102003` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_oobmigration_errors_total{op="down",job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_oobmigration_total{op="down",job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_oobmigration_errors_total{op="down",job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

### Frontend: Internal service requests

#### frontend: internal_indexed_search_error_responses

<p class="subtitle">Internal indexed search error responses every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-internal-indexed-search-error-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(code) (increase(src_zoekt_request_duration_seconds_count{code!~"2.."}[5m])) / ignoring(code) group_left sum(increase(src_zoekt_request_duration_seconds_count[5m])) * 100`

</details>

<br />

#### frontend: internal_unindexed_search_error_responses

<p class="subtitle">Internal unindexed search error responses every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-internal-unindexed-search-error-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(code) (increase(searcher_service_request_total{code!~"2.."}[5m])) / ignoring(code) group_left sum(increase(searcher_service_request_total[5m])) * 100`

</details>

<br />

#### frontend: internalapi_error_responses

<p class="subtitle">Internal API error responses every 5m by route</p>

Refer to the [alerts reference](./alerts.md#frontend-internalapi-error-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(category) (increase(src_frontend_internal_request_duration_seconds_count{code!~"2.."}[5m])) / ignoring(code) group_left sum(increase(src_frontend_internal_request_duration_seconds_count[5m])) * 100`

</details>

<br />

#### frontend: 99th_percentile_gitserver_duration

<p class="subtitle">99th percentile successful gitserver query duration over 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-99th-percentile-gitserver-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum by (le,category)(rate(src_gitserver_request_duration_seconds_bucket{job=~"(sourcegraph-)?frontend"}[5m])))`

</details>

<br />

#### frontend: gitserver_error_responses

<p class="subtitle">Gitserver error responses every 5m</p>

Refer to the [alerts reference](./alerts.md#frontend-gitserver-error-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (category)(increase(src_gitserver_request_duration_seconds_count{job=~"(sourcegraph-)?frontend",code!~"2.."}[5m])) / ignoring(code) group_left sum by (category)(increase(src_gitserver_request_duration_seconds_count{job=~"(sourcegraph-)?frontend"}[5m])) * 100`

</details>

<br />

#### frontend: observability_test_alert_warning

<p class="subtitle">Warning test alert metric</p>

Refer to the [alerts reference](./alerts.md#frontend-observability-test-alert-warning) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102120` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(owner) (observability_test_metric_warning)`

</details>

<br />

#### frontend: observability_test_alert_critical

<p class="subtitle">Critical test alert metric</p>

Refer to the [alerts reference](./alerts.md#frontend-observability-test-alert-critical) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102121` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(owner) (observability_test_metric_critical)`

</details>

<br />

### Frontend: Authentication API requests

#### frontend: sign_in_rate

<p class="subtitle">Rate of API requests to sign-in</p>

Rate (QPS) of requests to sign-in

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(irate(src_http_request_duration_seconds_count{route="sign-in",method="post"}[5m]))`

</details>

<br />

#### frontend: sign_in_latency_p99

<p class="subtitle">99 percentile of sign-in latency</p>

99% percentile of sign-in latency

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum(rate(src_http_request_duration_seconds_bucket{route="sign-in",method="post"}[5m])) by (le))`

</details>

<br />

#### frontend: sign_in_error_rate

<p class="subtitle">Percentage of sign-in requests by http code</p>

Percentage of sign-in requests grouped by http code

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (code)(irate(src_http_request_duration_seconds_count{route="sign-in",method="post"}[5m]))/ ignoring (code) group_left sum(irate(src_http_request_duration_seconds_count{route="sign-in",method="post"}[5m]))*100`

</details>

<br />

#### frontend: sign_up_rate

<p class="subtitle">Rate of API requests to sign-up</p>

Rate (QPS) of requests to sign-up

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(irate(src_http_request_duration_seconds_count{route="sign-up",method="post"}[5m]))`

</details>

<br />

#### frontend: sign_up_latency_p99

<p class="subtitle">99 percentile of sign-up latency</p>

99% percentile of sign-up latency

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum(rate(src_http_request_duration_seconds_bucket{route="sign-up",method="post"}[5m])) by (le))`

</details>

<br />

#### frontend: sign_up_code_percentage

<p class="subtitle">Percentage of sign-up requests by http code</p>

Percentage of sign-up requests grouped by http code

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (code)(irate(src_http_request_duration_seconds_count{route="sign-up",method="post"}[5m]))/ ignoring (code) group_left sum(irate(src_http_request_duration_seconds_count{route="sign-out"}[5m]))*100`

</details>

<br />

#### frontend: sign_out_rate

<p class="subtitle">Rate of API requests to sign-out</p>

Rate (QPS) of requests to sign-out

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102220` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(irate(src_http_request_duration_seconds_count{route="sign-out"}[5m]))`

</details>

<br />

#### frontend: sign_out_latency_p99

<p class="subtitle">99 percentile of sign-out latency</p>

99% percentile of sign-out latency

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102221` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum(rate(src_http_request_duration_seconds_bucket{route="sign-out"}[5m])) by (le))`

</details>

<br />

#### frontend: sign_out_error_rate

<p class="subtitle">Percentage of sign-out requests that return non-303 http code</p>

Percentage of sign-out requests grouped by http code

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102222` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: ` sum by (code)(irate(src_http_request_duration_seconds_count{route="sign-out"}[5m]))/ ignoring (code) group_left sum(irate(src_http_request_duration_seconds_count{route="sign-out"}[5m]))*100`

</details>

<br />

#### frontend: account_failed_sign_in_attempts

<p class="subtitle">Rate of failed sign-in attempts</p>

Failed sign-in attempts per minute

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102230` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(src_frontend_account_failed_sign_in_attempts_total[1m]))`

</details>

<br />

#### frontend: account_lockouts

<p class="subtitle">Rate of account lockouts</p>

Account lockouts per minute

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102231` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Identity and Access Management team](https://handbook.sourcegraph.com/departments/engineering/teams/iam).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(src_frontend_account_lockouts_total[1m]))`

</details>

<br />

### Frontend: Organisation GraphQL API requests

#### frontend: org_members_rate

<p class="subtitle">Rate of API requests to list organisation members</p>

Rate (QPS) of API requests to list organisation members

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(irate(src_graphql_request_duration_seconds_count{route="OrganizationMembers"}[5m]))`

</details>

<br />

#### frontend: org_members_latency_p99

<p class="subtitle">99 percentile latency of API requests to list organisation members</p>

99 percentile latency ofAPI requests to list organisation members

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum(rate(src_graphql_request_duration_seconds_bucket{route="OrganizationMembers"}[5m])) by (le))`

</details>

<br />

#### frontend: org_members_error_rate

<p class="subtitle">Percentage of API requests to list organisation members that return an error</p>

Percentage of API requests to list organisation members that return an error

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum (irate(src_graphql_request_duration_seconds_count{route="OrganizationMembers",success="false"}[5m]))/sum(irate(src_graphql_request_duration_seconds_count{route="OrganizationMembers"}[5m]))*100`

</details>

<br />

#### frontend: create_org_rate

<p class="subtitle">Rate of API requests to create an organisation</p>

Rate (QPS) of API requests to create an organisation

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(irate(src_graphql_request_duration_seconds_count{route="CreateOrganization"}[5m]))`

</details>

<br />

#### frontend: create_org_latency_p99

<p class="subtitle">99 percentile latency of API requests to create an organisation</p>

99 percentile latency ofAPI requests to create an organisation

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum(rate(src_graphql_request_duration_seconds_bucket{route="CreateOrganization"}[5m])) by (le))`

</details>

<br />

#### frontend: create_org_error_rate

<p class="subtitle">Percentage of API requests to create an organisation that return an error</p>

Percentage of API requests to create an organisation that return an error

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum (irate(src_graphql_request_duration_seconds_count{route="CreateOrganization",success="false"}[5m]))/sum(irate(src_graphql_request_duration_seconds_count{route="CreateOrganization"}[5m]))*100`

</details>

<br />

#### frontend: remove_org_member_rate

<p class="subtitle">Rate of API requests to remove organisation member</p>

Rate (QPS) of API requests to remove organisation member

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102320` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(irate(src_graphql_request_duration_seconds_count{route="RemoveUserFromOrganization"}[5m]))`

</details>

<br />

#### frontend: remove_org_member_latency_p99

<p class="subtitle">99 percentile latency of API requests to remove organisation member</p>

99 percentile latency ofAPI requests to remove organisation member

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102321` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum(rate(src_graphql_request_duration_seconds_bucket{route="RemoveUserFromOrganization"}[5m])) by (le))`

</details>

<br />

#### frontend: remove_org_member_error_rate

<p class="subtitle">Percentage of API requests to remove organisation member that return an error</p>

Percentage of API requests to remove organisation member that return an error

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102322` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum (irate(src_graphql_request_duration_seconds_count{route="RemoveUserFromOrganization",success="false"}[5m]))/sum(irate(src_graphql_request_duration_seconds_count{route="RemoveUserFromOrganization"}[5m]))*100`

</details>

<br />

#### frontend: invite_org_member_rate

<p class="subtitle">Rate of API requests to invite a new organisation member</p>

Rate (QPS) of API requests to invite a new organisation member

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102330` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(irate(src_graphql_request_duration_seconds_count{route="InviteUserToOrganization"}[5m]))`

</details>

<br />

#### frontend: invite_org_member_latency_p99

<p class="subtitle">99 percentile latency of API requests to invite a new organisation member</p>

99 percentile latency ofAPI requests to invite a new organisation member

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102331` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum(rate(src_graphql_request_duration_seconds_bucket{route="InviteUserToOrganization"}[5m])) by (le))`

</details>

<br />

#### frontend: invite_org_member_error_rate

<p class="subtitle">Percentage of API requests to invite a new organisation member that return an error</p>

Percentage of API requests to invite a new organisation member that return an error

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102332` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum (irate(src_graphql_request_duration_seconds_count{route="InviteUserToOrganization",success="false"}[5m]))/sum(irate(src_graphql_request_duration_seconds_count{route="InviteUserToOrganization"}[5m]))*100`

</details>

<br />

#### frontend: org_invite_respond_rate

<p class="subtitle">Rate of API requests to respond to an org invitation</p>

Rate (QPS) of API requests to respond to an org invitation

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102340` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(irate(src_graphql_request_duration_seconds_count{route="RespondToOrganizationInvitation"}[5m]))`

</details>

<br />

#### frontend: org_invite_respond_latency_p99

<p class="subtitle">99 percentile latency of API requests to respond to an org invitation</p>

99 percentile latency ofAPI requests to respond to an org invitation

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102341` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum(rate(src_graphql_request_duration_seconds_bucket{route="RespondToOrganizationInvitation"}[5m])) by (le))`

</details>

<br />

#### frontend: org_invite_respond_error_rate

<p class="subtitle">Percentage of API requests to respond to an org invitation that return an error</p>

Percentage of API requests to respond to an org invitation that return an error

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102342` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum (irate(src_graphql_request_duration_seconds_count{route="RespondToOrganizationInvitation",success="false"}[5m]))/sum(irate(src_graphql_request_duration_seconds_count{route="RespondToOrganizationInvitation"}[5m]))*100`

</details>

<br />

#### frontend: org_repositories_rate

<p class="subtitle">Rate of API requests to list repositories owned by an org</p>

Rate (QPS) of API requests to list repositories owned by an org

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102350` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(irate(src_graphql_request_duration_seconds_count{route="OrgRepositories"}[5m]))`

</details>

<br />

#### frontend: org_repositories_latency_p99

<p class="subtitle">99 percentile latency of API requests to list repositories owned by an org</p>

99 percentile latency ofAPI requests to list repositories owned by an org

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102351` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum(rate(src_graphql_request_duration_seconds_bucket{route="OrgRepositories"}[5m])) by (le))`

</details>

<br />

#### frontend: org_repositories_error_rate

<p class="subtitle">Percentage of API requests to list repositories owned by an org that return an error</p>

Percentage of API requests to list repositories owned by an org that return an error

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102352` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum (irate(src_graphql_request_duration_seconds_count{route="OrgRepositories",success="false"}[5m]))/sum(irate(src_graphql_request_duration_seconds_count{route="OrgRepositories"}[5m]))*100`

</details>

<br />

### Frontend: Cloud KMS and cache

#### frontend: cloudkms_cryptographic_requests

<p class="subtitle">Cryptographic requests to Cloud KMS every 1m</p>

Refer to the [alerts reference](./alerts.md#frontend-cloudkms-cryptographic-requests) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_cloudkms_cryptographic_total[1m]))`

</details>

<br />

#### frontend: encryption_cache_hit_ratio

<p class="subtitle">Average encryption cache hit ratio per workload</p>

- Encryption cache hit ratio (hits/(hits+misses)) - minimum across all instances of a workload.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `min by (kubernetes_name) (src_encryption_cache_hit_total/(src_encryption_cache_hit_total+src_encryption_cache_miss_total))`

</details>

<br />

#### frontend: encryption_cache_evictions

<p class="subtitle">Rate of encryption cache evictions - sum across all instances of a given workload</p>

- Rate of encryption cache evictions (caused by cache exceeding its maximum size) - sum across all instances of a workload

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (kubernetes_name) (irate(src_encryption_cache_eviction_total[5m]))`

</details>

<br />

### Frontend: Database connections

#### frontend: max_open_conns

<p class="subtitle">Maximum open</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_max_open{app_name="frontend"})`

</details>

<br />

#### frontend: open_conns

<p class="subtitle">Established</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_open{app_name="frontend"})`

</details>

<br />

#### frontend: in_use

<p class="subtitle">Used</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102510` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_in_use{app_name="frontend"})`

</details>

<br />

#### frontend: idle

<p class="subtitle">Idle</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102511` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_idle{app_name="frontend"})`

</details>

<br />

#### frontend: mean_blocked_seconds_per_conn_request

<p class="subtitle">Mean blocked seconds per conn request</p>

Refer to the [alerts reference](./alerts.md#frontend-mean-blocked-seconds-per-conn-request) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102520` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_blocked_seconds{app_name="frontend"}[5m])) / sum by (app_name, db_name) (increase(src_pgsql_conns_waited_for{app_name="frontend"}[5m]))`

</details>

<br />

#### frontend: closed_max_idle

<p class="subtitle">Closed by SetMaxIdleConns</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102530` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle{app_name="frontend"}[5m]))`

</details>

<br />

#### frontend: closed_max_lifetime

<p class="subtitle">Closed by SetConnMaxLifetime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102531` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_lifetime{app_name="frontend"}[5m]))`

</details>

<br />

#### frontend: closed_max_idle_time

<p class="subtitle">Closed by SetConnMaxIdleTime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102532` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle_time{app_name="frontend"}[5m]))`

</details>

<br />

### Frontend: Container monitoring (not available on server)

#### frontend: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod (frontend|sourcegraph-frontend)` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p (frontend|sourcegraph-frontend)`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' (frontend|sourcegraph-frontend)` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the (frontend|sourcegraph-frontend) container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs (frontend|sourcegraph-frontend)` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^(frontend|sourcegraph-frontend).*"}) > 60)`

</details>

<br />

#### frontend: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#frontend-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^(frontend|sourcegraph-frontend).*"}`

</details>

<br />

#### frontend: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#frontend-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102602` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^(frontend|sourcegraph-frontend).*"}`

</details>

<br />

#### frontend: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102603` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^(frontend|sourcegraph-frontend).*"}[1h]) + rate(container_fs_writes_total{name=~"^(frontend|sourcegraph-frontend).*"}[1h]))`

</details>

<br />

### Frontend: Provisioning indicators (not available on server)

#### frontend: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#frontend-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102700` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^(frontend|sourcegraph-frontend).*"}[1d])`

</details>

<br />

#### frontend: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#frontend-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102701` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^(frontend|sourcegraph-frontend).*"}[1d])`

</details>

<br />

#### frontend: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#frontend-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102710` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^(frontend|sourcegraph-frontend).*"}[5m])`

</details>

<br />

#### frontend: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#frontend-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102711` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^(frontend|sourcegraph-frontend).*"}[5m])`

</details>

<br />

#### frontend: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#frontend-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102712` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^(frontend|sourcegraph-frontend).*"})`

</details>

<br />

### Frontend: Golang runtime monitoring

#### frontend: go_goroutines

<p class="subtitle">Maximum active goroutines</p>

A high value here indicates a possible goroutine leak.

Refer to the [alerts reference](./alerts.md#frontend-go-goroutines) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102800` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_goroutines{job=~".*(frontend|sourcegraph-frontend)"})`

</details>

<br />

#### frontend: go_gc_duration_seconds

<p class="subtitle">Maximum go garbage collection duration</p>

Refer to the [alerts reference](./alerts.md#frontend-go-gc-duration-seconds) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102801` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_gc_duration_seconds{job=~".*(frontend|sourcegraph-frontend)"})`

</details>

<br />

### Frontend: Kubernetes monitoring (only available on Kubernetes)

#### frontend: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#frontend-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=102900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*(frontend|sourcegraph-frontend)"}) / count by (app) (up{app=~".*(frontend|sourcegraph-frontend)"}) * 100`

</details>

<br />

### Frontend: Ranking

#### frontend: mean_position_of_clicked_search_result_6h

<p class="subtitle">Mean position of clicked search result over 6h</p>

The top-most result on the search results has position 0. Low values are considered better. This metric only tracks top-level items and not individual line matches.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (type) (rate(src_search_ranking_result_clicked_sum[6h]))/sum by (type) (rate(src_search_ranking_result_clicked_count[6h]))`

</details>

<br />

#### frontend: distribution_of_clicked_search_result_type_over_6h_in_percent

<p class="subtitle">Distribution of clicked search result type over 6h in %</p>

The distribution of clicked search results by result type. At every point in time, the values should sum to 100.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `round(sum(increase(src_search_ranking_result_clicked_sum{type="commit"}[6h])) / sum (increase(src_search_ranking_result_clicked_sum[6h]))*100)`

</details>

<br />

### Frontend: Sentinel queries (only on sourcegraph.com)

#### frontend: mean_successful_sentinel_duration_over_2h

<p class="subtitle">Mean successful sentinel search duration over 2h</p>

Mean search duration for all successful sentinel queries

Refer to the [alerts reference](./alerts.md#frontend-mean-successful-sentinel-duration-over-2h) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(src_search_response_latency_seconds_sum{source=~`searchblitz.*`, status=`success`}[2h])) / sum(rate(src_search_response_latency_seconds_count{source=~`searchblitz.*`, status=`success`}[2h]))`

</details>

<br />

#### frontend: mean_sentinel_stream_latency_over_2h

<p class="subtitle">Mean successful sentinel stream latency over 2h</p>

Mean time to first result for all successful streaming sentinel queries

Refer to the [alerts reference](./alerts.md#frontend-mean-sentinel-stream-latency-over-2h) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(src_search_streaming_latency_seconds_sum{source=~"searchblitz.*"}[2h])) / sum(rate(src_search_streaming_latency_seconds_count{source=~"searchblitz.*"}[2h]))`

</details>

<br />

#### frontend: 90th_percentile_successful_sentinel_duration_over_2h

<p class="subtitle">90th percentile successful sentinel search duration over 2h</p>

90th percentile search duration for all successful sentinel queries

Refer to the [alerts reference](./alerts.md#frontend-90th-percentile-successful-sentinel-duration-over-2h) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le)(label_replace(rate(src_search_response_latency_seconds_bucket{source=~"searchblitz.*", status="success"}[2h]), "source", "$1", "source", "searchblitz_(.*)")))`

</details>

<br />

#### frontend: 90th_percentile_sentinel_stream_latency_over_2h

<p class="subtitle">90th percentile successful sentinel stream latency over 2h</p>

90th percentile time to first result for all successful streaming sentinel queries

Refer to the [alerts reference](./alerts.md#frontend-90th-percentile-sentinel-stream-latency-over-2h) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le)(label_replace(rate(src_search_streaming_latency_seconds_bucket{source=~"searchblitz.*"}[2h]), "source", "$1", "source", "searchblitz_(.*)")))`

</details>

<br />

#### frontend: mean_successful_sentinel_duration_by_query

<p class="subtitle">Mean successful sentinel search duration by query</p>

Mean search duration for successful sentinel queries, broken down by query. Useful for debugging whether a slowdown is limited to a specific type of query.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103120` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(src_search_response_latency_seconds_sum{source=~"searchblitz.*", status="success"}[$sentinel_sampling_duration])) by (source) / sum(rate(src_search_response_latency_seconds_count{source=~"searchblitz.*", status="success"}[$sentinel_sampling_duration])) by (source)`

</details>

<br />

#### frontend: mean_sentinel_stream_latency_by_query

<p class="subtitle">Mean successful sentinel stream latency by query</p>

Mean time to first result for successful streaming sentinel queries, broken down by query. Useful for debugging whether a slowdown is limited to a specific type of query.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103121` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(src_search_streaming_latency_seconds_sum{source=~"searchblitz.*"}[$sentinel_sampling_duration])) by (source) / sum(rate(src_search_streaming_latency_seconds_count{source=~"searchblitz.*"}[$sentinel_sampling_duration])) by (source)`

</details>

<br />

#### frontend: 90th_percentile_successful_sentinel_duration_by_query

<p class="subtitle">90th percentile successful sentinel search duration by query</p>

90th percentile search duration for successful sentinel queries, broken down by query. Useful for debugging whether a slowdown is limited to a specific type of query.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103130` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum(rate(src_search_response_latency_seconds_bucket{source=~"searchblitz.*", status="success"}[$sentinel_sampling_duration])) by (le, source))`

</details>

<br />

#### frontend: 90th_percentile_successful_stream_latency_by_query

<p class="subtitle">90th percentile successful sentinel stream latency by query</p>

90th percentile time to first result for successful streaming sentinel queries, broken down by query. Useful for debugging whether a slowdown is limited to a specific type of query.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103131` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum(rate(src_search_streaming_latency_seconds_bucket{source=~"searchblitz.*"}[$sentinel_sampling_duration])) by (le, source))`

</details>

<br />

#### frontend: 90th_percentile_unsuccessful_duration_by_query

<p class="subtitle">90th percentile unsuccessful sentinel search duration by query</p>

90th percentile search duration of _unsuccessful_ sentinel queries (by error or timeout), broken down by query. Useful for debugging how the performance of failed requests affect UX.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103140` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum(rate(src_search_response_latency_seconds_bucket{source=~`searchblitz.*`, status!=`success`}[$sentinel_sampling_duration])) by (le, source))`

</details>

<br />

#### frontend: 75th_percentile_successful_sentinel_duration_by_query

<p class="subtitle">75th percentile successful sentinel search duration by query</p>

75th percentile search duration of successful sentinel queries, broken down by query. Useful for debugging whether a slowdown is limited to a specific type of query.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103150` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.75, sum(rate(src_search_response_latency_seconds_bucket{source=~"searchblitz.*", status="success"}[$sentinel_sampling_duration])) by (le, source))`

</details>

<br />

#### frontend: 75th_percentile_successful_stream_latency_by_query

<p class="subtitle">75th percentile successful sentinel stream latency by query</p>

75th percentile time to first result for successful streaming sentinel queries, broken down by query. Useful for debugging whether a slowdown is limited to a specific type of query.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103151` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.75, sum(rate(src_search_streaming_latency_seconds_bucket{source=~"searchblitz.*"}[$sentinel_sampling_duration])) by (le, source))`

</details>

<br />

#### frontend: 75th_percentile_unsuccessful_duration_by_query

<p class="subtitle">75th percentile unsuccessful sentinel search duration by query</p>

75th percentile search duration of _unsuccessful_ sentinel queries (by error or timeout), broken down by query. Useful for debugging how the performance of failed requests affect UX.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103160` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.75, sum(rate(src_search_response_latency_seconds_bucket{source=~`searchblitz.*`, status!=`success`}[$sentinel_sampling_duration])) by (le, source))`

</details>

<br />

#### frontend: unsuccessful_status_rate

<p class="subtitle">Unsuccessful status rate</p>

The rate of unsuccessful sentinel queries, broken down by failure type.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103170` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(src_graphql_search_response{source=~"searchblitz.*", status!="success"}[$sentinel_sampling_duration])) by (status)`

</details>

<br />

### Frontend: Search aggregations: proactive and expanded search aggregations

#### frontend: insights_aggregations_total

<p class="subtitle">Aggregate search aggregations operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_insights_aggregations_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: insights_aggregations_99th_percentile_duration

<p class="subtitle">Aggregate successful search aggregations operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_insights_aggregations_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: insights_aggregations_errors_total

<p class="subtitle">Aggregate search aggregations operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_insights_aggregations_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: insights_aggregations_error_rate

<p class="subtitle">Aggregate search aggregations operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103203` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_insights_aggregations_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum(increase(src_insights_aggregations_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum(increase(src_insights_aggregations_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

#### frontend: insights_aggregations_total

<p class="subtitle">Search aggregations operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op,extended_mode)(increase(src_insights_aggregations_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: insights_aggregations_99th_percentile_duration

<p class="subtitle">99th percentile successful search aggregations operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op,extended_mode)(rate(src_insights_aggregations_duration_seconds_bucket{job=~"^(frontend|sourcegraph-frontend).*"}[5m])))`

</details>

<br />

#### frontend: insights_aggregations_errors_total

<p class="subtitle">Search aggregations operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op,extended_mode)(increase(src_insights_aggregations_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))`

</details>

<br />

#### frontend: insights_aggregations_error_rate

<p class="subtitle">Search aggregations operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/frontend/frontend?viewPanel=103213` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op,extended_mode)(increase(src_insights_aggregations_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) / (sum by (op,extended_mode)(increase(src_insights_aggregations_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m])) + sum by (op,extended_mode)(increase(src_insights_aggregations_errors_total{job=~"^(frontend|sourcegraph-frontend).*"}[5m]))) * 100`

</details>

<br />

## Git Server

<p class="subtitle">Stores, manages, and operates Git repositories.</p>

To see this dashboard, visit `/-/debug/grafana/d/gitserver/gitserver` on your Sourcegraph instance.

#### gitserver: memory_working_set

<p class="subtitle">Memory working set</p>



This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (container_memory_working_set_bytes{container_label_io_kubernetes_container_name="gitserver", container_label_io_kubernetes_pod_name=~`${shard:regex}`})`

</details>

<br />

#### gitserver: go_routines

<p class="subtitle">Go routines</p>



This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `go_goroutines{app="gitserver", instance=~`${shard:regex}`}`

</details>

<br />

#### gitserver: cpu_throttling_time

<p class="subtitle">Container CPU throttling time %</p>



This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) ((rate(container_cpu_cfs_throttled_periods_total{container_label_io_kubernetes_container_name="gitserver", container_label_io_kubernetes_pod_name=~`${shard:regex}`}[5m]) / rate(container_cpu_cfs_periods_total{container_label_io_kubernetes_container_name="gitserver", container_label_io_kubernetes_pod_name=~`${shard:regex}`}[5m])) * 100)`

</details>

<br />

#### gitserver: cpu_usage_seconds

<p class="subtitle">Cpu usage seconds</p>



This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (rate(container_cpu_usage_seconds_total{container_label_io_kubernetes_container_name="gitserver", container_label_io_kubernetes_pod_name=~`${shard:regex}`}[5m]))`

</details>

<br />

#### gitserver: disk_space_remaining

<p class="subtitle">Disk space remaining by instance</p>

Refer to the [alerts reference](./alerts.md#gitserver-disk-space-remaining) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100020` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `(src_gitserver_disk_space_available / src_gitserver_disk_space_total) * 100`

</details>

<br />

#### gitserver: io_reads_total

<p class="subtitle">I/o reads total</p>



This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100030` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_container_name) (rate(container_fs_reads_total{container_label_io_kubernetes_container_name="gitserver"}[5m]))`

</details>

<br />

#### gitserver: io_writes_total

<p class="subtitle">I/o writes total</p>



This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100031` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_container_name) (rate(container_fs_writes_total{container_label_io_kubernetes_container_name="gitserver"}[5m]))`

</details>

<br />

#### gitserver: io_reads

<p class="subtitle">I/o reads</p>



This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100040` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (rate(container_fs_reads_total{container_label_io_kubernetes_container_name="gitserver", container_label_io_kubernetes_pod_name=~`${shard:regex}`}[5m]))`

</details>

<br />

#### gitserver: io_writes

<p class="subtitle">I/o writes</p>



This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100041` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (rate(container_fs_writes_total{container_label_io_kubernetes_container_name="gitserver", container_label_io_kubernetes_pod_name=~`${shard:regex}`}[5m]))`

</details>

<br />

#### gitserver: io_read_througput

<p class="subtitle">I/o read throughput</p>



This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100050` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (rate(container_fs_reads_bytes_total{container_label_io_kubernetes_container_name="gitserver", container_label_io_kubernetes_pod_name=~`${shard:regex}`}[5m]))`

</details>

<br />

#### gitserver: io_write_throughput

<p class="subtitle">I/o write throughput</p>



This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100051` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (rate(container_fs_writes_bytes_total{container_label_io_kubernetes_container_name="gitserver", container_label_io_kubernetes_pod_name=~`${shard:regex}`}[5m]))`

</details>

<br />

#### gitserver: running_git_commands

<p class="subtitle">Git commands running on each gitserver instance</p>

A high value signals load.

Refer to the [alerts reference](./alerts.md#gitserver-running-git-commands) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100060` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (instance, cmd) (src_gitserver_exec_running{instance=~`${shard:regex}`})`

</details>

<br />

#### gitserver: git_commands_received

<p class="subtitle">Rate of git commands received across all instances</p>

per second rate per command across all instances

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100061` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (cmd) (rate(src_gitserver_exec_duration_seconds_count[5m]))`

</details>

<br />

#### gitserver: repository_clone_queue_size

<p class="subtitle">Repository clone queue size</p>

Refer to the [alerts reference](./alerts.md#gitserver-repository-clone-queue-size) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100070` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(src_gitserver_clone_queue)`

</details>

<br />

#### gitserver: repository_existence_check_queue_size

<p class="subtitle">Repository existence check queue size</p>

Refer to the [alerts reference](./alerts.md#gitserver-repository-existence-check-queue-size) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100071` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(src_gitserver_lsremote_queue)`

</details>

<br />

#### gitserver: echo_command_duration_test

<p class="subtitle">Echo test command duration</p>

A high value here likely indicates a problem, especially if consistently high.
You can query for individual commands using `sum by (cmd)(src_gitserver_exec_running)` in Grafana (`/-/debug/grafana`) to see if a specific Git Server command might be spiking in frequency.

If this value is consistently high, consider the following:

- **Single container deployments:** Upgrade to a [Docker Compose deployment](../deploy/docker-compose/migrate.md) which offers better scalability and resource isolation.
- **Kubernetes and Docker Compose:** Check that you are running a similar number of git server replicas and that their CPU/memory limits are allocated according to what is shown in the [Sourcegraph resource estimator](../deploy/resource_estimator.md).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100080` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_gitserver_echo_duration_seconds)`

</details>

<br />

#### gitserver: frontend_internal_api_error_responses

<p class="subtitle">Frontend-internal API error responses every 5m by route</p>

Refer to the [alerts reference](./alerts.md#gitserver-frontend-internal-api-error-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100081` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (category)(increase(src_frontend_internal_request_duration_seconds_count{job="gitserver",code!~"2.."}[5m])) / ignoring(category) group_left sum(increase(src_frontend_internal_request_duration_seconds_count{job="gitserver"}[5m]))`

</details>

<br />

### Git Server: Gitserver: Gitserver API (powered by internal/observation)

#### gitserver: gitserver_api_total

<p class="subtitle">Aggregate graphql operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_gitserver_api_total{job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: gitserver_api_99th_percentile_duration

<p class="subtitle">Aggregate successful graphql operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_gitserver_api_duration_seconds_bucket{job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: gitserver_api_errors_total

<p class="subtitle">Aggregate graphql operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_gitserver_api_errors_total{job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: gitserver_api_error_rate

<p class="subtitle">Aggregate graphql operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100103` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_gitserver_api_errors_total{job=~"^gitserver.*"}[5m])) / (sum(increase(src_gitserver_api_total{job=~"^gitserver.*"}[5m])) + sum(increase(src_gitserver_api_errors_total{job=~"^gitserver.*"}[5m]))) * 100`

</details>

<br />

#### gitserver: gitserver_api_total

<p class="subtitle">Graphql operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_gitserver_api_total{job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: gitserver_api_99th_percentile_duration

<p class="subtitle">99th percentile successful graphql operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_gitserver_api_duration_seconds_bucket{job=~"^gitserver.*"}[5m])))`

</details>

<br />

#### gitserver: gitserver_api_errors_total

<p class="subtitle">Graphql operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_gitserver_api_errors_total{job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: gitserver_api_error_rate

<p class="subtitle">Graphql operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100113` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_gitserver_api_errors_total{job=~"^gitserver.*"}[5m])) / (sum by (op)(increase(src_gitserver_api_total{job=~"^gitserver.*"}[5m])) + sum by (op)(increase(src_gitserver_api_errors_total{job=~"^gitserver.*"}[5m]))) * 100`

</details>

<br />

### Git Server: Global operation semaphores

#### gitserver: batch_log_semaphore_wait_99th_percentile_duration

<p class="subtitle">Aggregate successful batch log semaphore operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_batch_log_semaphore_wait_duration_seconds_bucket{job=~"^gitserver.*"}[5m]))`

</details>

<br />

### Git Server: Gitservice for internal cloning

#### gitserver: aggregate_gitservice_request_duration

<p class="subtitle">95th percentile gitservice request duration aggregate</p>

A high value means any internal service trying to clone a repo from gitserver is slowed down.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, sum(rate(src_gitserver_gitservice_duration_seconds_bucket{type=`gitserver`, error=`false`}[5m])) by (le))`

</details>

<br />

#### gitserver: gitservice_request_duration

<p class="subtitle">95th percentile gitservice request duration per shard</p>

A high value means any internal service trying to clone a repo from gitserver is slowed down.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, sum(rate(src_gitserver_gitservice_duration_seconds_bucket{type=`gitserver`, error=`false`, instance=~`${shard:regex}`}[5m])) by (le, instance))`

</details>

<br />

#### gitserver: aggregate_gitservice_error_request_duration

<p class="subtitle">95th percentile gitservice error request duration aggregate</p>

95th percentile gitservice error request duration aggregate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, sum(rate(src_gitserver_gitservice_duration_seconds_bucket{type=`gitserver`, error=`true`}[5m])) by (le))`

</details>

<br />

#### gitserver: gitservice_request_duration

<p class="subtitle">95th percentile gitservice error request duration per shard</p>

95th percentile gitservice error request duration per shard

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, sum(rate(src_gitserver_gitservice_duration_seconds_bucket{type=`gitserver`, error=`true`, instance=~`${shard:regex}`}[5m])) by (le, instance))`

</details>

<br />

#### gitserver: aggregate_gitservice_request_rate

<p class="subtitle">Aggregate gitservice request rate</p>

Aggregate gitservice request rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100320` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(src_gitserver_gitservice_duration_seconds_count{type=`gitserver`, error=`false`}[5m]))`

</details>

<br />

#### gitserver: gitservice_request_rate

<p class="subtitle">Gitservice request rate per shard</p>

Per shard gitservice request rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100321` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(src_gitserver_gitservice_duration_seconds_count{type=`gitserver`, error=`false`, instance=~`${shard:regex}`}[5m]))`

</details>

<br />

#### gitserver: aggregate_gitservice_request_error_rate

<p class="subtitle">Aggregate gitservice request error rate</p>

Aggregate gitservice request error rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100330` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(src_gitserver_gitservice_duration_seconds_count{type=`gitserver`, error=`true`}[5m]))`

</details>

<br />

#### gitserver: gitservice_request_error_rate

<p class="subtitle">Gitservice request error rate per shard</p>

Per shard gitservice request error rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100331` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(src_gitserver_gitservice_duration_seconds_count{type=`gitserver`, error=`true`, instance=~`${shard:regex}`}[5m]))`

</details>

<br />

#### gitserver: aggregate_gitservice_requests_running

<p class="subtitle">Aggregate gitservice requests running</p>

Aggregate gitservice requests running

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100340` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(src_gitserver_gitservice_running{type=`gitserver`})`

</details>

<br />

#### gitserver: gitservice_requests_running

<p class="subtitle">Gitservice requests running per shard</p>

Per shard gitservice requests running

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100341` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(src_gitserver_gitservice_running{type=`gitserver`, instance=~`${shard:regex}`}) by (instance)`

</details>

<br />

### Git Server: Gitserver cleanup jobs

#### gitserver: janitor_running

<p class="subtitle">If the janitor process is running</p>

1, if the janitor process is currently running

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (instance) (src_gitserver_janitor_running)`

</details>

<br />

#### gitserver: janitor_job_duration

<p class="subtitle">95th percentile job run duration</p>

95th percentile job run duration

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, sum(rate(src_gitserver_janitor_job_duration_seconds_bucket[5m])) by (le, job_name))`

</details>

<br />

#### gitserver: janitor_job_failures

<p class="subtitle">Failures over 5m (by job)</p>

the rate of failures over 5m (by job)

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100420` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (job_name) (rate(src_gitserver_janitor_job_duration_seconds_count{success="false"}[5m]))`

</details>

<br />

#### gitserver: repos_removed

<p class="subtitle">Repositories removed due to disk pressure</p>

Repositories removed due to disk pressure

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100430` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (instance) (rate(src_gitserver_repos_removed_disk_pressure[5m]))`

</details>

<br />

#### gitserver: non_existent_repos_removed

<p class="subtitle">Repositories removed because they are not defined in the DB</p>

Repositoriess removed because they are not defined in the DB

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100440` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (instance) (increase(src_gitserver_non_existing_repos_removed[5m]))`

</details>

<br />

#### gitserver: sg_maintenance_reason

<p class="subtitle">Successful sg maintenance jobs over 1h (by reason)</p>

the rate of successful sg maintenance jobs and the reason why they were triggered

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100450` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (reason) (rate(src_gitserver_maintenance_status{success="true"}[1h]))`

</details>

<br />

#### gitserver: git_prune_skipped

<p class="subtitle">Successful git prune jobs over 1h</p>

the rate of successful git prune jobs over 1h and whether they were skipped

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100460` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (skipped) (rate(src_gitserver_prune_status{success="true"}[1h]))`

</details>

<br />

### Git Server: Search

#### gitserver: search_latency

<p class="subtitle">Mean time until first result is sent</p>

Mean latency (time to first result) of gitserver search requests

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `rate(src_gitserver_search_latency_seconds_sum[5m]) / rate(src_gitserver_search_latency_seconds_count[5m])`

</details>

<br />

#### gitserver: search_duration

<p class="subtitle">Mean search duration</p>

Mean duration of gitserver search requests

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `rate(src_gitserver_search_duration_seconds_sum[5m]) / rate(src_gitserver_search_duration_seconds_count[5m])`

</details>

<br />

#### gitserver: search_rate

<p class="subtitle">Rate of searches run by pod</p>

The rate of searches executed on gitserver by pod

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100510` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `rate(src_gitserver_search_latency_seconds_count{instance=~`${shard:regex}`}[5m])`

</details>

<br />

#### gitserver: running_searches

<p class="subtitle">Number of searches currently running by pod</p>

The number of searches currently executing on gitserver by pod

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100511` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search team](https://handbook.sourcegraph.com/departments/engineering/teams/search/product).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (instance) (src_gitserver_search_running{instance=~`${shard:regex}`})`

</details>

<br />

### Git Server: Codeintel: Coursier invocation stats

#### gitserver: codeintel_coursier_total

<p class="subtitle">Aggregate invocations operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_coursier_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: codeintel_coursier_99th_percentile_duration

<p class="subtitle">Aggregate successful invocations operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_coursier_duration_seconds_bucket{op!="RunCommand",job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: codeintel_coursier_errors_total

<p class="subtitle">Aggregate invocations operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100602` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: codeintel_coursier_error_rate

<p class="subtitle">Aggregate invocations operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100603` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m])) / (sum(increase(src_codeintel_coursier_total{op!="RunCommand",job=~"^gitserver.*"}[5m])) + sum(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))) * 100`

</details>

<br />

#### gitserver: codeintel_coursier_total

<p class="subtitle">Invocations operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100610` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_coursier_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: codeintel_coursier_99th_percentile_duration

<p class="subtitle">99th percentile successful invocations operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100611` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_coursier_duration_seconds_bucket{op!="RunCommand",job=~"^gitserver.*"}[5m])))`

</details>

<br />

#### gitserver: codeintel_coursier_errors_total

<p class="subtitle">Invocations operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100612` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: codeintel_coursier_error_rate

<p class="subtitle">Invocations operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100613` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m])) / (sum by (op)(increase(src_codeintel_coursier_total{op!="RunCommand",job=~"^gitserver.*"}[5m])) + sum by (op)(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))) * 100`

</details>

<br />

### Git Server: Codeintel: npm invocation stats

#### gitserver: codeintel_npm_total

<p class="subtitle">Aggregate invocations operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100700` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_npm_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: codeintel_npm_99th_percentile_duration

<p class="subtitle">Aggregate successful invocations operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100701` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_npm_duration_seconds_bucket{op!="RunCommand",job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: codeintel_npm_errors_total

<p class="subtitle">Aggregate invocations operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100702` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: codeintel_npm_error_rate

<p class="subtitle">Aggregate invocations operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100703` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m])) / (sum(increase(src_codeintel_npm_total{op!="RunCommand",job=~"^gitserver.*"}[5m])) + sum(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))) * 100`

</details>

<br />

#### gitserver: codeintel_npm_total

<p class="subtitle">Invocations operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100710` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_npm_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: codeintel_npm_99th_percentile_duration

<p class="subtitle">99th percentile successful invocations operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100711` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_npm_duration_seconds_bucket{op!="RunCommand",job=~"^gitserver.*"}[5m])))`

</details>

<br />

#### gitserver: codeintel_npm_errors_total

<p class="subtitle">Invocations operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100712` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))`

</details>

<br />

#### gitserver: codeintel_npm_error_rate

<p class="subtitle">Invocations operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100713` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m])) / (sum by (op)(increase(src_codeintel_npm_total{op!="RunCommand",job=~"^gitserver.*"}[5m])) + sum by (op)(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^gitserver.*"}[5m]))) * 100`

</details>

<br />

### Git Server: HTTP handlers

#### gitserver: healthy_request_rate

<p class="subtitle">Requests per second, by route, when status code is 200</p>

The number of healthy HTTP requests per second to internal HTTP api

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100800` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (route) (rate(src_http_request_duration_seconds_count{app="gitserver",code=~"2.."}[5m]))`

</details>

<br />

#### gitserver: unhealthy_request_rate

<p class="subtitle">Requests per second, by route, when status code is not 200</p>

The number of unhealthy HTTP requests per second to internal HTTP api

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100801` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (route) (rate(src_http_request_duration_seconds_count{app="gitserver",code!~"2.."}[5m]))`

</details>

<br />

#### gitserver: request_rate_by_code

<p class="subtitle">Requests per second, by status code</p>

The number of HTTP requests per second by code

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100802` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (code) (rate(src_http_request_duration_seconds_count{app="gitserver"}[5m]))`

</details>

<br />

#### gitserver: 95th_percentile_healthy_requests

<p class="subtitle">95th percentile duration by route, when status code is 200</p>

The 95th percentile duration by route when the status code is 200 

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100810` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, sum(rate(src_http_request_duration_seconds_bucket{app="gitserver",code=~"2.."}[5m])) by (le, route))`

</details>

<br />

#### gitserver: 95th_percentile_unhealthy_requests

<p class="subtitle">95th percentile duration by route, when status code is not 200</p>

The 95th percentile duration by route when the status code is not 200 

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100811` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, sum(rate(src_http_request_duration_seconds_bucket{app="gitserver",code!~"2.."}[5m])) by (le, route))`

</details>

<br />

### Git Server: Database connections

#### gitserver: max_open_conns

<p class="subtitle">Maximum open</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_max_open{app_name="gitserver"})`

</details>

<br />

#### gitserver: open_conns

<p class="subtitle">Established</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100901` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_open{app_name="gitserver"})`

</details>

<br />

#### gitserver: in_use

<p class="subtitle">Used</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100910` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_in_use{app_name="gitserver"})`

</details>

<br />

#### gitserver: idle

<p class="subtitle">Idle</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100911` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_idle{app_name="gitserver"})`

</details>

<br />

#### gitserver: mean_blocked_seconds_per_conn_request

<p class="subtitle">Mean blocked seconds per conn request</p>

Refer to the [alerts reference](./alerts.md#gitserver-mean-blocked-seconds-per-conn-request) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100920` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_blocked_seconds{app_name="gitserver"}[5m])) / sum by (app_name, db_name) (increase(src_pgsql_conns_waited_for{app_name="gitserver"}[5m]))`

</details>

<br />

#### gitserver: closed_max_idle

<p class="subtitle">Closed by SetMaxIdleConns</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100930` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle{app_name="gitserver"}[5m]))`

</details>

<br />

#### gitserver: closed_max_lifetime

<p class="subtitle">Closed by SetConnMaxLifetime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100931` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_lifetime{app_name="gitserver"}[5m]))`

</details>

<br />

#### gitserver: closed_max_idle_time

<p class="subtitle">Closed by SetConnMaxIdleTime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=100932` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle_time{app_name="gitserver"}[5m]))`

</details>

<br />

### Git Server: Container monitoring (not available on server)

#### gitserver: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod gitserver` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p gitserver`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' gitserver` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the gitserver container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs gitserver` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^gitserver.*"}) > 60)`

</details>

<br />

#### gitserver: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#gitserver-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^gitserver.*"}`

</details>

<br />

#### gitserver: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#gitserver-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^gitserver.*"}`

</details>

<br />

#### gitserver: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101003` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^gitserver.*"}[1h]) + rate(container_fs_writes_total{name=~"^gitserver.*"}[1h]))`

</details>

<br />

### Git Server: Provisioning indicators (not available on server)

#### gitserver: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#gitserver-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^gitserver.*"}[1d])`

</details>

<br />

#### gitserver: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Git Server is expected to use up all the memory it is provided.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^gitserver.*"}[1d])`

</details>

<br />

#### gitserver: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#gitserver-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^gitserver.*"}[5m])`

</details>

<br />

#### gitserver: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Git Server is expected to use up all the memory it is provided.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^gitserver.*"}[5m])`

</details>

<br />

#### gitserver: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#gitserver-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^gitserver.*"})`

</details>

<br />

### Git Server: Golang runtime monitoring

#### gitserver: go_goroutines

<p class="subtitle">Maximum active goroutines</p>

A high value here indicates a possible goroutine leak.

Refer to the [alerts reference](./alerts.md#gitserver-go-goroutines) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_goroutines{job=~".*gitserver"})`

</details>

<br />

#### gitserver: go_gc_duration_seconds

<p class="subtitle">Maximum go garbage collection duration</p>

Refer to the [alerts reference](./alerts.md#gitserver-go-gc-duration-seconds) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_gc_duration_seconds{job=~".*gitserver"})`

</details>

<br />

### Git Server: Kubernetes monitoring (only available on Kubernetes)

#### gitserver: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#gitserver-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/gitserver/gitserver?viewPanel=101300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*gitserver"}) / count by (app) (up{app=~".*gitserver"}) * 100`

</details>

<br />

## GitHub Proxy

<p class="subtitle">Proxies all requests to github.com, keeping track of and managing rate limits.</p>

To see this dashboard, visit `/-/debug/grafana/d/github-proxy/github-proxy` on your Sourcegraph instance.

### GitHub Proxy: GitHub API monitoring

#### github-proxy: github_proxy_waiting_requests

<p class="subtitle">Number of requests waiting on the global mutex</p>

Refer to the [alerts reference](./alerts.md#github-proxy-github-proxy-waiting-requests) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(github_proxy_waiting_requests)`

</details>

<br />

### GitHub Proxy: Container monitoring (not available on server)

#### github-proxy: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod github-proxy` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p github-proxy`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' github-proxy` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the github-proxy container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs github-proxy` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^github-proxy.*"}) > 60)`

</details>

<br />

#### github-proxy: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#github-proxy-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^github-proxy.*"}`

</details>

<br />

#### github-proxy: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#github-proxy-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^github-proxy.*"}`

</details>

<br />

#### github-proxy: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100103` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^github-proxy.*"}[1h]) + rate(container_fs_writes_total{name=~"^github-proxy.*"}[1h]))`

</details>

<br />

### GitHub Proxy: Provisioning indicators (not available on server)

#### github-proxy: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#github-proxy-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^github-proxy.*"}[1d])`

</details>

<br />

#### github-proxy: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#github-proxy-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^github-proxy.*"}[1d])`

</details>

<br />

#### github-proxy: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#github-proxy-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^github-proxy.*"}[5m])`

</details>

<br />

#### github-proxy: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#github-proxy-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^github-proxy.*"}[5m])`

</details>

<br />

#### github-proxy: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#github-proxy-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^github-proxy.*"})`

</details>

<br />

### GitHub Proxy: Golang runtime monitoring

#### github-proxy: go_goroutines

<p class="subtitle">Maximum active goroutines</p>

A high value here indicates a possible goroutine leak.

Refer to the [alerts reference](./alerts.md#github-proxy-go-goroutines) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_goroutines{job=~".*github-proxy"})`

</details>

<br />

#### github-proxy: go_gc_duration_seconds

<p class="subtitle">Maximum go garbage collection duration</p>

Refer to the [alerts reference](./alerts.md#github-proxy-go-gc-duration-seconds) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_gc_duration_seconds{job=~".*github-proxy"})`

</details>

<br />

### GitHub Proxy: Kubernetes monitoring (only available on Kubernetes)

#### github-proxy: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#github-proxy-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/github-proxy/github-proxy?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*github-proxy"}) / count by (app) (up{app=~".*github-proxy"}) * 100`

</details>

<br />

## Postgres

<p class="subtitle">Postgres metrics, exported from postgres_exporter (not available on server).</p>

To see this dashboard, visit `/-/debug/grafana/d/postgres/postgres` on your Sourcegraph instance.

#### postgres: connections

<p class="subtitle">Active connections</p>

Refer to the [alerts reference](./alerts.md#postgres-connections) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (job) (pg_stat_activity_count{datname!~"template.*|postgres|cloudsqladmin"}) OR sum by (job) (pg_stat_activity_count{job="codeinsights-db", datname!~"template.*|cloudsqladmin"})`

</details>

<br />

#### postgres: usage_connections_percentage

<p class="subtitle">Connection in use</p>

Refer to the [alerts reference](./alerts.md#postgres-usage-connections-percentage) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(pg_stat_activity_count) by (job) / (sum(pg_settings_max_connections) by (job) - sum(pg_settings_superuser_reserved_connections) by (job)) * 100`

</details>

<br />

#### postgres: transaction_durations

<p class="subtitle">Maximum transaction durations</p>

Refer to the [alerts reference](./alerts.md#postgres-transaction-durations) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (job) (pg_stat_activity_max_tx_duration{datname!~"template.*|postgres|cloudsqladmin",job!="codeintel-db"}) OR sum by (job) (pg_stat_activity_max_tx_duration{job="codeinsights-db", datname!~"template.*|cloudsqladmin"})`

</details>

<br />

### Postgres: Database and collector status

#### postgres: postgres_up

<p class="subtitle">Database availability</p>

A non-zero value indicates the database is online.

Refer to the [alerts reference](./alerts.md#postgres-postgres-up) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `pg_up`

</details>

<br />

#### postgres: invalid_indexes

<p class="subtitle">Invalid indexes (unusable by the query planner)</p>

A non-zero value indicates the that Postgres failed to build an index. Expect degraded performance until the index is manually rebuilt.

Refer to the [alerts reference](./alerts.md#postgres-invalid-indexes) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (relname)(pg_invalid_index_count)`

</details>

<br />

#### postgres: pg_exporter_err

<p class="subtitle">Errors scraping postgres exporter</p>

This value indicates issues retrieving metrics from postgres_exporter.

Refer to the [alerts reference](./alerts.md#postgres-pg-exporter-err) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `pg_exporter_last_scrape_error`

</details>

<br />

#### postgres: migration_in_progress

<p class="subtitle">Active schema migration</p>

A 0 value indicates that no migration is in progress.

Refer to the [alerts reference](./alerts.md#postgres-migration-in-progress) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `pg_sg_migration_status`

</details>

<br />

### Postgres: Object size and bloat

#### postgres: pg_table_size

<p class="subtitle">Table size</p>

Total size of this table

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (relname)(pg_table_bloat_size)`

</details>

<br />

#### postgres: pg_table_bloat_ratio

<p class="subtitle">Table bloat ratio</p>

Estimated bloat ratio of this table (high bloat = high overhead)

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (relname)(pg_table_bloat_ratio) * 100`

</details>

<br />

#### postgres: pg_index_size

<p class="subtitle">Index size</p>

Total size of this index

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (relname)(pg_index_bloat_size)`

</details>

<br />

#### postgres: pg_index_bloat_ratio

<p class="subtitle">Index bloat ratio</p>

Estimated bloat ratio of this index (high bloat = high overhead)

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (relname)(pg_index_bloat_ratio) * 100`

</details>

<br />

### Postgres: Provisioning indicators (not available on server)

#### postgres: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#postgres-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^(pgsql|codeintel-db|codeinsights).*"}[1d])`

</details>

<br />

#### postgres: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#postgres-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^(pgsql|codeintel-db|codeinsights).*"}[1d])`

</details>

<br />

#### postgres: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#postgres-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^(pgsql|codeintel-db|codeinsights).*"}[5m])`

</details>

<br />

#### postgres: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#postgres-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^(pgsql|codeintel-db|codeinsights).*"}[5m])`

</details>

<br />

#### postgres: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#postgres-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^(pgsql|codeintel-db|codeinsights).*"})`

</details>

<br />

### Postgres: Kubernetes monitoring (only available on Kubernetes)

#### postgres: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#postgres-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/postgres/postgres?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*(pgsql|codeintel-db|codeinsights)"}) / count by (app) (up{app=~".*(pgsql|codeintel-db|codeinsights)"}) * 100`

</details>

<br />

## Precise Code Intel Worker

<p class="subtitle">Handles conversion of uploaded precise code intelligence bundles.</p>

To see this dashboard, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker` on your Sourcegraph instance.

### Precise Code Intel Worker: Codeintel: LSIF uploads

#### precise-code-intel-worker: codeintel_upload_queue_size

<p class="subtitle">Unprocessed upload record queue size</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_upload_total{job=~"^precise-code-intel-worker.*"})`

</details>

<br />

#### precise-code-intel-worker: codeintel_upload_queue_growth_rate

<p class="subtitle">Unprocessed upload record queue growth rate over 30m</p>

This value compares the rate of enqueues against the rate of finished jobs.

	- A value < than 1 indicates that process rate > enqueue rate
	- A value = than 1 indicates that process rate = enqueue rate
	- A value > than 1 indicates that process rate < enqueue rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_upload_total{job=~"^precise-code-intel-worker.*"}[30m])) / sum(increase(src_codeintel_upload_processor_total{job=~"^precise-code-intel-worker.*"}[30m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_upload_queued_max_age

<p class="subtitle">Unprocessed upload record queue longest time in queue</p>

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-codeintel-upload-queued-max-age) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_upload_queued_duration_seconds_total{job=~"^precise-code-intel-worker.*"})`

</details>

<br />

### Precise Code Intel Worker: Codeintel: LSIF uploads

#### precise-code-intel-worker: codeintel_upload_handlers

<p class="subtitle">Handler active handlers</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(src_codeintel_upload_processor_handlers{job=~"^precise-code-intel-worker.*"})`

</details>

<br />

#### precise-code-intel-worker: codeintel_upload_processor_upload_size

<p class="subtitle">Sum of upload sizes in bytes being processed by each precise code-intel worker instance</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(instance) (src_codeintel_upload_processor_upload_size{job="precise-code-intel-worker"})`

</details>

<br />

#### precise-code-intel-worker: codeintel_upload_processor_total

<p class="subtitle">Handler operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_upload_processor_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_upload_processor_99th_percentile_duration

<p class="subtitle">Aggregate successful handler operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_upload_processor_duration_seconds_bucket{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_upload_processor_errors_total

<p class="subtitle">Handler operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_upload_processor_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_upload_processor_error_rate

<p class="subtitle">Handler operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100113` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_upload_processor_errors_total{job=~"^precise-code-intel-worker.*"}[5m])) / (sum(increase(src_codeintel_upload_processor_total{job=~"^precise-code-intel-worker.*"}[5m])) + sum(increase(src_codeintel_upload_processor_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))) * 100`

</details>

<br />

### Precise Code Intel Worker: Codeintel: dbstore stats

#### precise-code-intel-worker: codeintel_uploads_store_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_store_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploads_store_duration_seconds_bucket{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_store_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_store_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100203` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_errors_total{job=~"^precise-code-intel-worker.*"}[5m])) / (sum(increase(src_codeintel_uploads_store_total{job=~"^precise-code-intel-worker.*"}[5m])) + sum(increase(src_codeintel_uploads_store_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))) * 100`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploads_store_duration_seconds_bucket{job=~"^precise-code-intel-worker.*"}[5m])))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100213` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^precise-code-intel-worker.*"}[5m])) / (sum by (op)(increase(src_codeintel_uploads_store_total{job=~"^precise-code-intel-worker.*"}[5m])) + sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))) * 100`

</details>

<br />

### Precise Code Intel Worker: Codeintel: lsifstore stats

#### precise-code-intel-worker: codeintel_uploads_lsifstore_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_lsifstore_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_lsifstore_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploads_lsifstore_duration_seconds_bucket{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_lsifstore_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_lsifstore_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m])) / (sum(increase(src_codeintel_uploads_lsifstore_total{job=~"^precise-code-intel-worker.*"}[5m])) + sum(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))) * 100`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_lsifstore_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_lsifstore_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_lsifstore_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploads_lsifstore_duration_seconds_bucket{job=~"^precise-code-intel-worker.*"}[5m])))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_lsifstore_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploads_lsifstore_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100313` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m])) / (sum by (op)(increase(src_codeintel_uploads_lsifstore_total{job=~"^precise-code-intel-worker.*"}[5m])) + sum by (op)(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))) * 100`

</details>

<br />

### Precise Code Intel Worker: Workerutil: lsif_uploads dbworker/store stats

#### precise-code-intel-worker: workerutil_dbworker_store_codeintel_upload_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_codeintel_upload_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: workerutil_dbworker_store_codeintel_upload_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_workerutil_dbworker_store_codeintel_upload_duration_seconds_bucket{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: workerutil_dbworker_store_codeintel_upload_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_codeintel_upload_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: workerutil_dbworker_store_codeintel_upload_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100403` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_codeintel_upload_errors_total{job=~"^precise-code-intel-worker.*"}[5m])) / (sum(increase(src_workerutil_dbworker_store_codeintel_upload_total{job=~"^precise-code-intel-worker.*"}[5m])) + sum(increase(src_workerutil_dbworker_store_codeintel_upload_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))) * 100`

</details>

<br />

### Precise Code Intel Worker: Codeintel: gitserver client

#### precise-code-intel-worker: codeintel_gitserver_total

<p class="subtitle">Aggregate client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_gitserver_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_gitserver_99th_percentile_duration

<p class="subtitle">Aggregate successful client operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_gitserver_duration_seconds_bucket{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_gitserver_errors_total

<p class="subtitle">Aggregate client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100502` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_gitserver_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_gitserver_error_rate

<p class="subtitle">Aggregate client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100503` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_gitserver_errors_total{job=~"^precise-code-intel-worker.*"}[5m])) / (sum(increase(src_codeintel_gitserver_total{job=~"^precise-code-intel-worker.*"}[5m])) + sum(increase(src_codeintel_gitserver_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))) * 100`

</details>

<br />

#### precise-code-intel-worker: codeintel_gitserver_total

<p class="subtitle">Client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100510` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_gitserver_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_gitserver_99th_percentile_duration

<p class="subtitle">99th percentile successful client operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100511` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_gitserver_duration_seconds_bucket{job=~"^precise-code-intel-worker.*"}[5m])))`

</details>

<br />

#### precise-code-intel-worker: codeintel_gitserver_errors_total

<p class="subtitle">Client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100512` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_gitserver_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_gitserver_error_rate

<p class="subtitle">Client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100513` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_gitserver_errors_total{job=~"^precise-code-intel-worker.*"}[5m])) / (sum by (op)(increase(src_codeintel_gitserver_total{job=~"^precise-code-intel-worker.*"}[5m])) + sum by (op)(increase(src_codeintel_gitserver_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))) * 100`

</details>

<br />

### Precise Code Intel Worker: Codeintel: uploadstore stats

#### precise-code-intel-worker: codeintel_uploadstore_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploadstore_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploadstore_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploadstore_duration_seconds_bucket{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploadstore_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100602` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploadstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploadstore_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100603` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploadstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m])) / (sum(increase(src_codeintel_uploadstore_total{job=~"^precise-code-intel-worker.*"}[5m])) + sum(increase(src_codeintel_uploadstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))) * 100`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploadstore_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100610` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploadstore_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploadstore_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100611` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploadstore_duration_seconds_bucket{job=~"^precise-code-intel-worker.*"}[5m])))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploadstore_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100612` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploadstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: codeintel_uploadstore_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100613` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploadstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m])) / (sum by (op)(increase(src_codeintel_uploadstore_total{job=~"^precise-code-intel-worker.*"}[5m])) + sum by (op)(increase(src_codeintel_uploadstore_errors_total{job=~"^precise-code-intel-worker.*"}[5m]))) * 100`

</details>

<br />

### Precise Code Intel Worker: Internal service requests

#### precise-code-intel-worker: frontend_internal_api_error_responses

<p class="subtitle">Frontend-internal API error responses every 5m by route</p>

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-frontend-internal-api-error-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100700` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (category)(increase(src_frontend_internal_request_duration_seconds_count{job="precise-code-intel-worker",code!~"2.."}[5m])) / ignoring(category) group_left sum(increase(src_frontend_internal_request_duration_seconds_count{job="precise-code-intel-worker"}[5m]))`

</details>

<br />

### Precise Code Intel Worker: Database connections

#### precise-code-intel-worker: max_open_conns

<p class="subtitle">Maximum open</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100800` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_max_open{app_name="precise-code-intel-worker"})`

</details>

<br />

#### precise-code-intel-worker: open_conns

<p class="subtitle">Established</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100801` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_open{app_name="precise-code-intel-worker"})`

</details>

<br />

#### precise-code-intel-worker: in_use

<p class="subtitle">Used</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100810` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_in_use{app_name="precise-code-intel-worker"})`

</details>

<br />

#### precise-code-intel-worker: idle

<p class="subtitle">Idle</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100811` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_idle{app_name="precise-code-intel-worker"})`

</details>

<br />

#### precise-code-intel-worker: mean_blocked_seconds_per_conn_request

<p class="subtitle">Mean blocked seconds per conn request</p>

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-mean-blocked-seconds-per-conn-request) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100820` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_blocked_seconds{app_name="precise-code-intel-worker"}[5m])) / sum by (app_name, db_name) (increase(src_pgsql_conns_waited_for{app_name="precise-code-intel-worker"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: closed_max_idle

<p class="subtitle">Closed by SetMaxIdleConns</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100830` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle{app_name="precise-code-intel-worker"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: closed_max_lifetime

<p class="subtitle">Closed by SetConnMaxLifetime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100831` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_lifetime{app_name="precise-code-intel-worker"}[5m]))`

</details>

<br />

#### precise-code-intel-worker: closed_max_idle_time

<p class="subtitle">Closed by SetConnMaxIdleTime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100832` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle_time{app_name="precise-code-intel-worker"}[5m]))`

</details>

<br />

### Precise Code Intel Worker: Container monitoring (not available on server)

#### precise-code-intel-worker: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod precise-code-intel-worker` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p precise-code-intel-worker`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' precise-code-intel-worker` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the precise-code-intel-worker container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs precise-code-intel-worker` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^precise-code-intel-worker.*"}) > 60)`

</details>

<br />

#### precise-code-intel-worker: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100901` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^precise-code-intel-worker.*"}`

</details>

<br />

#### precise-code-intel-worker: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100902` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^precise-code-intel-worker.*"}`

</details>

<br />

#### precise-code-intel-worker: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=100903` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^precise-code-intel-worker.*"}[1h]) + rate(container_fs_writes_total{name=~"^precise-code-intel-worker.*"}[1h]))`

</details>

<br />

### Precise Code Intel Worker: Provisioning indicators (not available on server)

#### precise-code-intel-worker: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=101000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^precise-code-intel-worker.*"}[1d])`

</details>

<br />

#### precise-code-intel-worker: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=101001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^precise-code-intel-worker.*"}[1d])`

</details>

<br />

#### precise-code-intel-worker: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=101010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^precise-code-intel-worker.*"}[5m])`

</details>

<br />

#### precise-code-intel-worker: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=101011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^precise-code-intel-worker.*"}[5m])`

</details>

<br />

#### precise-code-intel-worker: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=101012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^precise-code-intel-worker.*"})`

</details>

<br />

### Precise Code Intel Worker: Golang runtime monitoring

#### precise-code-intel-worker: go_goroutines

<p class="subtitle">Maximum active goroutines</p>

A high value here indicates a possible goroutine leak.

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-go-goroutines) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=101100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_goroutines{job=~".*precise-code-intel-worker"})`

</details>

<br />

#### precise-code-intel-worker: go_gc_duration_seconds

<p class="subtitle">Maximum go garbage collection duration</p>

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-go-gc-duration-seconds) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=101101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_gc_duration_seconds{job=~".*precise-code-intel-worker"})`

</details>

<br />

### Precise Code Intel Worker: Kubernetes monitoring (only available on Kubernetes)

#### precise-code-intel-worker: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#precise-code-intel-worker-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/precise-code-intel-worker/precise-code-intel-worker?viewPanel=101200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*precise-code-intel-worker"}) / count by (app) (up{app=~".*precise-code-intel-worker"}) * 100`

</details>

<br />

## Redis

<p class="subtitle">Metrics from both redis databases.</p>

To see this dashboard, visit `/-/debug/grafana/d/redis/redis` on your Sourcegraph instance.

### Redis: Redis Store

#### redis: redis-store_up

<p class="subtitle">Redis-store availability</p>

A value of 1 indicates the service is currently running

Refer to the [alerts reference](./alerts.md#redis-redis-store-up) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `redis_up{app="redis-store"}`

</details>

<br />

### Redis: Redis Cache

#### redis: redis-cache_up

<p class="subtitle">Redis-cache availability</p>

A value of 1 indicates the service is currently running

Refer to the [alerts reference](./alerts.md#redis-redis-cache-up) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `redis_up{app="redis-cache"}`

</details>

<br />

### Redis: Provisioning indicators (not available on server)

#### redis: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#redis-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^redis-cache.*"}[1d])`

</details>

<br />

#### redis: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#redis-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^redis-cache.*"}[1d])`

</details>

<br />

#### redis: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#redis-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^redis-cache.*"}[5m])`

</details>

<br />

#### redis: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#redis-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^redis-cache.*"}[5m])`

</details>

<br />

#### redis: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#redis-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^redis-cache.*"})`

</details>

<br />

### Redis: Provisioning indicators (not available on server)

#### redis: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#redis-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^redis-store.*"}[1d])`

</details>

<br />

#### redis: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#redis-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^redis-store.*"}[1d])`

</details>

<br />

#### redis: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#redis-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^redis-store.*"}[5m])`

</details>

<br />

#### redis: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#redis-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^redis-store.*"}[5m])`

</details>

<br />

#### redis: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#redis-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^redis-store.*"})`

</details>

<br />

### Redis: Kubernetes monitoring (only available on Kubernetes)

#### redis: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#redis-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*redis-cache"}) / count by (app) (up{app=~".*redis-cache"}) * 100`

</details>

<br />

### Redis: Kubernetes monitoring (only available on Kubernetes)

#### redis: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#redis-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/redis/redis?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*redis-store"}) / count by (app) (up{app=~".*redis-store"}) * 100`

</details>

<br />

## Worker

<p class="subtitle">Manages background processes.</p>

To see this dashboard, visit `/-/debug/grafana/d/worker/worker` on your Sourcegraph instance.

### Worker: Active jobs

#### worker: worker_job_count

<p class="subtitle">Number of worker instances running each job</p>

The number of worker instances running each job type.
It is necessary for each job type to be managed by at least one worker instance.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100000` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum by (job_name) (src_worker_jobs{job="worker"})`

</details>

<br />

#### worker: worker_job_codeintel-upload-janitor_count

<p class="subtitle">Number of worker instances running the codeintel-upload-janitor job</p>

Refer to the [alerts reference](./alerts.md#worker-worker-job-codeintel-upload-janitor-count) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum (src_worker_jobs{job="worker", job_name="codeintel-upload-janitor"})`

</details>

<br />

#### worker: worker_job_codeintel-commitgraph-updater_count

<p class="subtitle">Number of worker instances running the codeintel-commitgraph-updater job</p>

Refer to the [alerts reference](./alerts.md#worker-worker-job-codeintel-commitgraph-updater-count) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum (src_worker_jobs{job="worker", job_name="codeintel-commitgraph-updater"})`

</details>

<br />

#### worker: worker_job_codeintel-autoindexing-scheduler_count

<p class="subtitle">Number of worker instances running the codeintel-autoindexing-scheduler job</p>

Refer to the [alerts reference](./alerts.md#worker-worker-job-codeintel-autoindexing-scheduler-count) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum (src_worker_jobs{job="worker", job_name="codeintel-autoindexing-scheduler"})`

</details>

<br />

### Worker: Database record encrypter

#### worker: records_encrypted_at_rest_percentage

<p class="subtitle">Percentage of database records encrypted at rest</p>

Percentage of encrypted database records

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `(max(src_records_encrypted_at_rest_total) by (tableName)) / ((max(src_records_encrypted_at_rest_total) by (tableName)) + (max(src_records_unencrypted_at_rest_total) by (tableName))) * 100`

</details>

<br />

#### worker: records_encrypted_total

<p class="subtitle">Database records encrypted every 5m</p>

Number of encrypted database records every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (tableName)(increase(src_records_encrypted_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: records_decrypted_total

<p class="subtitle">Database records decrypted every 5m</p>

Number of encrypted database records every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (tableName)(increase(src_records_decrypted_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: record_encryption_errors_total

<p class="subtitle">Encryption operation errors every 5m</p>

Number of database record encryption/decryption errors every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100103` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_record_encryption_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

### Worker: Codeintel: Repository with stale commit graph

#### worker: codeintel_commit_graph_queue_size

<p class="subtitle">Repository queue size</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_commit_graph_total{job=~"^worker.*"})`

</details>

<br />

#### worker: codeintel_commit_graph_queue_growth_rate

<p class="subtitle">Repository queue growth rate over 30m</p>

This value compares the rate of enqueues against the rate of finished jobs.

	- A value < than 1 indicates that process rate > enqueue rate
	- A value = than 1 indicates that process rate = enqueue rate
	- A value > than 1 indicates that process rate < enqueue rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_commit_graph_total{job=~"^worker.*"}[30m])) / sum(increase(src_codeintel_commit_graph_processor_total{job=~"^worker.*"}[30m]))`

</details>

<br />

#### worker: codeintel_commit_graph_queued_max_age

<p class="subtitle">Repository queue longest time in queue</p>

Refer to the [alerts reference](./alerts.md#worker-codeintel-commit-graph-queued-max-age) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_commit_graph_queued_duration_seconds_total{job=~"^worker.*"})`

</details>

<br />

### Worker: Codeintel: Repository commit graph updates

#### worker: codeintel_commit_graph_processor_total

<p class="subtitle">Update operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_commit_graph_processor_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_commit_graph_processor_99th_percentile_duration

<p class="subtitle">Aggregate successful update operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_commit_graph_processor_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_commit_graph_processor_errors_total

<p class="subtitle">Update operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_commit_graph_processor_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_commit_graph_processor_error_rate

<p class="subtitle">Update operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_commit_graph_processor_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_codeintel_commit_graph_processor_total{job=~"^worker.*"}[5m])) + sum(increase(src_codeintel_commit_graph_processor_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Codeintel: Dependency index job

#### worker: codeintel_dependency_index_queue_size

<p class="subtitle">Dependency index job queue size</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_dependency_index_total{job=~"^worker.*"})`

</details>

<br />

#### worker: codeintel_dependency_index_queue_growth_rate

<p class="subtitle">Dependency index job queue growth rate over 30m</p>

This value compares the rate of enqueues against the rate of finished jobs.

	- A value < than 1 indicates that process rate > enqueue rate
	- A value = than 1 indicates that process rate = enqueue rate
	- A value > than 1 indicates that process rate < enqueue rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependency_index_total{job=~"^worker.*"}[30m])) / sum(increase(src_codeintel_dependency_index_processor_total{job=~"^worker.*"}[30m]))`

</details>

<br />

#### worker: codeintel_dependency_index_queued_max_age

<p class="subtitle">Dependency index job queue longest time in queue</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_dependency_index_queued_duration_seconds_total{job=~"^worker.*"})`

</details>

<br />

### Worker: Codeintel: Dependency index jobs

#### worker: codeintel_dependency_index_handlers

<p class="subtitle">Handler active handlers</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(src_codeintel_dependency_index_processor_handlers{job=~"^worker.*"})`

</details>

<br />

#### worker: codeintel_dependency_index_processor_total

<p class="subtitle">Handler operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100510` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependency_index_processor_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_dependency_index_processor_99th_percentile_duration

<p class="subtitle">Aggregate successful handler operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100511` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_dependency_index_processor_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_dependency_index_processor_errors_total

<p class="subtitle">Handler operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100512` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependency_index_processor_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_dependency_index_processor_error_rate

<p class="subtitle">Handler operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100513` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependency_index_processor_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_codeintel_dependency_index_processor_total{job=~"^worker.*"}[5m])) + sum(increase(src_codeintel_dependency_index_processor_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Codeintel: Janitor stats

#### worker: codeintel_background_repositories_scanned_total

<p class="subtitle">Repository records scanned every 5m</p>

Number of repositories considered for data retention scanning every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_repositories_scanned_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_upload_records_scanned_total

<p class="subtitle">Lsif upload records scanned every 5m</p>

Number of upload records considered for data retention scanning every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_upload_records_scanned_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_commits_scanned_total

<p class="subtitle">Lsif upload commits scanned every 5m</p>

Number of commits considered for data retention scanning every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100602` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_commits_scanned_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_upload_records_expired_total

<p class="subtitle">Lsif upload records expired every 5m</p>

Number of upload records found to be expired every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100603` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_upload_records_expired_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_upload_records_removed_total

<p class="subtitle">Lsif upload records deleted every 5m</p>

Number of LSIF upload records deleted due to expiration or unreachability every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100610` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_upload_records_removed_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_index_records_removed_total

<p class="subtitle">Lsif index records deleted every 5m</p>

Number of LSIF index records deleted due to expiration or unreachability every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100611` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_index_records_removed_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_uploads_purged_total

<p class="subtitle">Lsif upload data bundles deleted every 5m</p>

Number of LSIF upload data bundles purged from the codeintel-db database every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100612` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_uploads_purged_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_documentation_search_records_removed_total

<p class="subtitle">Documentation search record records deleted every 5m</p>

Number of documentation search records removed from the codeintel-db database every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100613` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_documentation_search_records_removed_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_audit_log_records_expired_total

<p class="subtitle">Lsif upload audit log records deleted every 5m</p>

Number of LSIF upload audit log records deleted due to expiration every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100620` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_audit_log_records_expired_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_errors_total

<p class="subtitle">Janitor operation errors every 5m</p>

Number of code intelligence janitor errors every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100621` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

### Worker: Codeintel: Auto-index scheduler

#### worker: codeintel_autoindexing_total

<p class="subtitle">Auto-indexing job scheduler operations every 10m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100700` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_total{op='HandleIndexSchedule',job=~"^worker.*"}[10m]))`

</details>

<br />

#### worker: codeintel_autoindexing_99th_percentile_duration

<p class="subtitle">Aggregate successful auto-indexing job scheduler operation duration distribution over 10m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100701` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_autoindexing_duration_seconds_bucket{op='HandleIndexSchedule',job=~"^worker.*"}[10m]))`

</details>

<br />

#### worker: codeintel_autoindexing_errors_total

<p class="subtitle">Auto-indexing job scheduler operation errors every 10m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100702` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_errors_total{op='HandleIndexSchedule',job=~"^worker.*"}[10m]))`

</details>

<br />

#### worker: codeintel_autoindexing_error_rate

<p class="subtitle">Auto-indexing job scheduler operation error rate over 10m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100703` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_errors_total{op='HandleIndexSchedule',job=~"^worker.*"}[10m])) / (sum(increase(src_codeintel_autoindexing_total{op='HandleIndexSchedule',job=~"^worker.*"}[10m])) + sum(increase(src_codeintel_autoindexing_errors_total{op='HandleIndexSchedule',job=~"^worker.*"}[10m]))) * 100`

</details>

<br />

### Worker: Codeintel: dbstore stats

#### worker: codeintel_uploads_store_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100800` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_uploads_store_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100801` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploads_store_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_uploads_store_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100802` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_uploads_store_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100803` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_codeintel_uploads_store_total{job=~"^worker.*"}[5m])) + sum(increase(src_codeintel_uploads_store_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

#### worker: codeintel_uploads_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100810` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_uploads_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100811` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploads_store_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### worker: codeintel_uploads_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100812` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_uploads_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100813` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^worker.*"}[5m])) / (sum by (op)(increase(src_codeintel_uploads_store_total{job=~"^worker.*"}[5m])) + sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Codeintel: lsifstore stats

#### worker: codeintel_uploads_lsifstore_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_lsifstore_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_uploads_lsifstore_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100901` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploads_lsifstore_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_uploads_lsifstore_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100902` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_uploads_lsifstore_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100903` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_codeintel_uploads_lsifstore_total{job=~"^worker.*"}[5m])) + sum(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

#### worker: codeintel_uploads_lsifstore_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100910` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_lsifstore_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_uploads_lsifstore_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100911` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploads_lsifstore_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### worker: codeintel_uploads_lsifstore_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100912` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_uploads_lsifstore_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=100913` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^worker.*"}[5m])) / (sum by (op)(increase(src_codeintel_uploads_lsifstore_total{job=~"^worker.*"}[5m])) + sum by (op)(increase(src_codeintel_uploads_lsifstore_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Workerutil: lsif_dependency_indexes dbworker/store stats

#### worker: workerutil_dbworker_store_codeintel_dependency_index_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_codeintel_dependency_index_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_codeintel_dependency_index_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_workerutil_dbworker_store_codeintel_dependency_index_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_codeintel_dependency_index_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_codeintel_dependency_index_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_codeintel_dependency_index_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101003` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_codeintel_dependency_index_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_workerutil_dbworker_store_codeintel_dependency_index_total{job=~"^worker.*"}[5m])) + sum(increase(src_workerutil_dbworker_store_codeintel_dependency_index_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Codeintel: gitserver client

#### worker: codeintel_gitserver_total

<p class="subtitle">Aggregate client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_gitserver_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_gitserver_99th_percentile_duration

<p class="subtitle">Aggregate successful client operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_gitserver_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_gitserver_errors_total

<p class="subtitle">Aggregate client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_gitserver_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_gitserver_error_rate

<p class="subtitle">Aggregate client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101103` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_gitserver_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_codeintel_gitserver_total{job=~"^worker.*"}[5m])) + sum(increase(src_codeintel_gitserver_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

#### worker: codeintel_gitserver_total

<p class="subtitle">Client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_gitserver_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_gitserver_99th_percentile_duration

<p class="subtitle">99th percentile successful client operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_gitserver_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### worker: codeintel_gitserver_errors_total

<p class="subtitle">Client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_gitserver_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_gitserver_error_rate

<p class="subtitle">Client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101113` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_gitserver_errors_total{job=~"^worker.*"}[5m])) / (sum by (op)(increase(src_codeintel_gitserver_total{job=~"^worker.*"}[5m])) + sum by (op)(increase(src_codeintel_gitserver_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Codeintel: Dependency repository insert

#### worker: codeintel_dependency_repos_total

<p class="subtitle">Aggregate insert operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependency_repos_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_dependency_repos_99th_percentile_duration

<p class="subtitle">Aggregate successful insert operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_dependency_repos_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_dependency_repos_errors_total

<p class="subtitle">Aggregate insert operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependency_repos_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_dependency_repos_error_rate

<p class="subtitle">Aggregate insert operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101203` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dependency_repos_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_codeintel_dependency_repos_total{job=~"^worker.*"}[5m])) + sum(increase(src_codeintel_dependency_repos_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

#### worker: codeintel_dependency_repos_total

<p class="subtitle">Insert operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (scheme,new)(increase(src_codeintel_dependency_repos_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_dependency_repos_99th_percentile_duration

<p class="subtitle">99th percentile successful insert operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,scheme,new)(rate(src_codeintel_dependency_repos_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### worker: codeintel_dependency_repos_errors_total

<p class="subtitle">Insert operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (scheme,new)(increase(src_codeintel_dependency_repos_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_dependency_repos_error_rate

<p class="subtitle">Insert operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101213` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (scheme,new)(increase(src_codeintel_dependency_repos_errors_total{job=~"^worker.*"}[5m])) / (sum by (scheme,new)(increase(src_codeintel_dependency_repos_total{job=~"^worker.*"}[5m])) + sum by (scheme,new)(increase(src_codeintel_dependency_repos_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Batches: dbstore stats

#### worker: batches_dbstore_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_dbstore_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: batches_dbstore_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_batches_dbstore_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: batches_dbstore_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_dbstore_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: batches_dbstore_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_dbstore_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_batches_dbstore_total{job=~"^worker.*"}[5m])) + sum(increase(src_batches_dbstore_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

#### worker: batches_dbstore_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_dbstore_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: batches_dbstore_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_batches_dbstore_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### worker: batches_dbstore_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_dbstore_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: batches_dbstore_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101313` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_dbstore_errors_total{job=~"^worker.*"}[5m])) / (sum by (op)(increase(src_batches_dbstore_total{job=~"^worker.*"}[5m])) + sum by (op)(increase(src_batches_dbstore_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Batches: service stats

#### worker: batches_service_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_service_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: batches_service_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_batches_service_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: batches_service_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_service_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: batches_service_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101403` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_service_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_batches_service_total{job=~"^worker.*"}[5m])) + sum(increase(src_batches_service_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

#### worker: batches_service_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_service_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: batches_service_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101411` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_batches_service_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### worker: batches_service_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101412` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_service_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: batches_service_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101413` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_service_errors_total{job=~"^worker.*"}[5m])) / (sum by (op)(increase(src_batches_service_total{job=~"^worker.*"}[5m])) + sum by (op)(increase(src_batches_service_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Batches: Workspace resolver dbstore

#### worker: workerutil_dbworker_store_batch_changes_batch_spec_resolution_worker_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batch_changes_batch_spec_resolution_worker_store_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_batch_changes_batch_spec_resolution_worker_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_workerutil_dbworker_store_batch_changes_batch_spec_resolution_worker_store_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### worker: workerutil_dbworker_store_batch_changes_batch_spec_resolution_worker_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101502` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batch_changes_batch_spec_resolution_worker_store_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_batch_changes_batch_spec_resolution_worker_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101503` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batch_changes_batch_spec_resolution_worker_store_errors_total{job=~"^worker.*"}[5m])) / (sum by (op)(increase(src_workerutil_dbworker_store_batch_changes_batch_spec_resolution_worker_store_total{job=~"^worker.*"}[5m])) + sum by (op)(increase(src_workerutil_dbworker_store_batch_changes_batch_spec_resolution_worker_store_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Batches: Bulk operation processor dbstore

#### worker: workerutil_dbworker_store_batches_bulk_worker_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batches_bulk_worker_store_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_batches_bulk_worker_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_workerutil_dbworker_store_batches_bulk_worker_store_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### worker: workerutil_dbworker_store_batches_bulk_worker_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101602` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batches_bulk_worker_store_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_batches_bulk_worker_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101603` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batches_bulk_worker_store_errors_total{job=~"^worker.*"}[5m])) / (sum by (op)(increase(src_workerutil_dbworker_store_batches_bulk_worker_store_total{job=~"^worker.*"}[5m])) + sum by (op)(increase(src_workerutil_dbworker_store_batches_bulk_worker_store_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Batches: Changeset reconciler dbstore

#### worker: workerutil_dbworker_store_batches_reconciler_worker_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101700` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batches_reconciler_worker_store_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_batches_reconciler_worker_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101701` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_workerutil_dbworker_store_batches_reconciler_worker_store_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### worker: workerutil_dbworker_store_batches_reconciler_worker_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101702` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batches_reconciler_worker_store_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_batches_reconciler_worker_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101703` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batches_reconciler_worker_store_errors_total{job=~"^worker.*"}[5m])) / (sum by (op)(increase(src_workerutil_dbworker_store_batches_reconciler_worker_store_total{job=~"^worker.*"}[5m])) + sum by (op)(increase(src_workerutil_dbworker_store_batches_reconciler_worker_store_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Batches: Workspace execution dbstore

#### worker: workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101800` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101801` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### worker: workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101802` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101803` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_errors_total{job=~"^worker.*"}[5m])) / (sum by (op)(increase(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_total{job=~"^worker.*"}[5m])) + sum by (op)(increase(src_workerutil_dbworker_store_batch_spec_workspace_execution_worker_store_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Codeintel: lsif_upload record resetter

#### worker: codeintel_background_upload_record_resets_total

<p class="subtitle">Lsif upload records reset to queued state every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_upload_record_resets_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_upload_record_reset_failures_total

<p class="subtitle">Lsif upload records reset to errored state every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101901` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_upload_record_reset_failures_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_upload_record_reset_errors_total

<p class="subtitle">Lsif upload operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=101902` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_upload_record_reset_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

### Worker: Codeintel: lsif_index record resetter

#### worker: codeintel_background_index_record_resets_total

<p class="subtitle">Lsif index records reset to queued state every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_index_record_resets_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_index_record_reset_failures_total

<p class="subtitle">Lsif index records reset to errored state every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_index_record_reset_failures_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_index_record_reset_errors_total

<p class="subtitle">Lsif index operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_index_record_reset_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

### Worker: Codeintel: lsif_dependency_index record resetter

#### worker: codeintel_background_dependency_index_record_resets_total

<p class="subtitle">Lsif dependency index records reset to queued state every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_dependency_index_record_resets_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_dependency_index_record_reset_failures_total

<p class="subtitle">Lsif dependency index records reset to errored state every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_dependency_index_record_reset_failures_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: codeintel_background_dependency_index_record_reset_errors_total

<p class="subtitle">Lsif dependency index operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_dependency_index_record_reset_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

### Worker: Codeinsights: Query Runner Queue

#### worker: query_runner_worker_queue_size

<p class="subtitle">Code insights query runner queue queue size</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_query_runner_worker_total{job=~"^worker.*"})`

</details>

<br />

#### worker: query_runner_worker_queue_growth_rate

<p class="subtitle">Code insights query runner queue queue growth rate over 30m</p>

This value compares the rate of enqueues against the rate of finished jobs.

	- A value < than 1 indicates that process rate > enqueue rate
	- A value = than 1 indicates that process rate = enqueue rate
	- A value > than 1 indicates that process rate < enqueue rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_query_runner_worker_total{job=~"^worker.*"}[30m])) / sum(increase(src_query_runner_worker_processor_total{job=~"^worker.*"}[30m]))`

</details>

<br />

### Worker: Codeinsights: insights queue processor

#### worker: query_runner_worker_handlers

<p class="subtitle">Handler active handlers</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(src_query_runner_worker_processor_handlers{job=~"^worker.*"})`

</details>

<br />

#### worker: query_runner_worker_processor_total

<p class="subtitle">Handler operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_query_runner_worker_processor_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: query_runner_worker_processor_99th_percentile_duration

<p class="subtitle">Aggregate successful handler operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_query_runner_worker_processor_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: query_runner_worker_processor_errors_total

<p class="subtitle">Handler operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_query_runner_worker_processor_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: query_runner_worker_processor_error_rate

<p class="subtitle">Handler operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102313` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_query_runner_worker_processor_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_query_runner_worker_processor_total{job=~"^worker.*"}[5m])) + sum(increase(src_query_runner_worker_processor_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Codeinsights: code insights query runner queue record resetter

#### worker: query_runner_worker_record_resets_total

<p class="subtitle">Insights query runner queue records reset to queued state every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_query_runner_worker_record_resets_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: query_runner_worker_record_reset_failures_total

<p class="subtitle">Insights query runner queue records reset to errored state every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_query_runner_worker_record_reset_failures_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: query_runner_worker_record_reset_errors_total

<p class="subtitle">Insights query runner queue operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_query_runner_worker_record_reset_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

### Worker: Codeinsights: dbstore stats

#### worker: workerutil_dbworker_store_insights_query_runner_jobs_store_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_insights_query_runner_jobs_store_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_insights_query_runner_jobs_store_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_workerutil_dbworker_store_insights_query_runner_jobs_store_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_insights_query_runner_jobs_store_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102502` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_insights_query_runner_jobs_store_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_insights_query_runner_jobs_store_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102503` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_workerutil_dbworker_store_insights_query_runner_jobs_store_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_workerutil_dbworker_store_insights_query_runner_jobs_store_total{job=~"^worker.*"}[5m])) + sum(increase(src_workerutil_dbworker_store_insights_query_runner_jobs_store_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

#### worker: workerutil_dbworker_store_insights_query_runner_jobs_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102510` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_insights_query_runner_jobs_store_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_insights_query_runner_jobs_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102511` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_workerutil_dbworker_store_insights_query_runner_jobs_store_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### worker: workerutil_dbworker_store_insights_query_runner_jobs_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102512` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_insights_query_runner_jobs_store_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### worker: workerutil_dbworker_store_insights_query_runner_jobs_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102513` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_workerutil_dbworker_store_insights_query_runner_jobs_store_errors_total{job=~"^worker.*"}[5m])) / (sum by (op)(increase(src_workerutil_dbworker_store_insights_query_runner_jobs_store_total{job=~"^worker.*"}[5m])) + sum by (op)(increase(src_workerutil_dbworker_store_insights_query_runner_jobs_store_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Worker: Code Insights queue utilization

#### worker: insights_queue_unutilized_size

<p class="subtitle">Insights queue size that is not utilized (not processing)</p>

Any value on this panel indicates code insights is not processing queries from its queue. This observable and alert only fire if there are records in the queue and there have been no dequeue attempts for 30 minutes.

Refer to the [alerts reference](./alerts.md#worker-insights-queue-unutilized-size) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_query_runner_worker_total{job=~"^worker.*"}) > 0 and on(job) sum by (op)(increase(src_workerutil_dbworker_store_insights_query_runner_jobs_store_total{job=~"^worker.*",op="Dequeue"}[5m])) < 1`

</details>

<br />

### Worker: Internal service requests

#### worker: frontend_internal_api_error_responses

<p class="subtitle">Frontend-internal API error responses every 5m by route</p>

Refer to the [alerts reference](./alerts.md#worker-frontend-internal-api-error-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102700` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (category)(increase(src_frontend_internal_request_duration_seconds_count{job="worker",code!~"2.."}[5m])) / ignoring(category) group_left sum(increase(src_frontend_internal_request_duration_seconds_count{job="worker"}[5m]))`

</details>

<br />

### Worker: Database connections

#### worker: max_open_conns

<p class="subtitle">Maximum open</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102800` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_max_open{app_name="worker"})`

</details>

<br />

#### worker: open_conns

<p class="subtitle">Established</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102801` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_open{app_name="worker"})`

</details>

<br />

#### worker: in_use

<p class="subtitle">Used</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102810` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_in_use{app_name="worker"})`

</details>

<br />

#### worker: idle

<p class="subtitle">Idle</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102811` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_idle{app_name="worker"})`

</details>

<br />

#### worker: mean_blocked_seconds_per_conn_request

<p class="subtitle">Mean blocked seconds per conn request</p>

Refer to the [alerts reference](./alerts.md#worker-mean-blocked-seconds-per-conn-request) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102820` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_blocked_seconds{app_name="worker"}[5m])) / sum by (app_name, db_name) (increase(src_pgsql_conns_waited_for{app_name="worker"}[5m]))`

</details>

<br />

#### worker: closed_max_idle

<p class="subtitle">Closed by SetMaxIdleConns</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102830` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle{app_name="worker"}[5m]))`

</details>

<br />

#### worker: closed_max_lifetime

<p class="subtitle">Closed by SetConnMaxLifetime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102831` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_lifetime{app_name="worker"}[5m]))`

</details>

<br />

#### worker: closed_max_idle_time

<p class="subtitle">Closed by SetConnMaxIdleTime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102832` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle_time{app_name="worker"}[5m]))`

</details>

<br />

### Worker: Container monitoring (not available on server)

#### worker: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod worker` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p worker`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' worker` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the worker container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs worker` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^worker.*"}) > 60)`

</details>

<br />

#### worker: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#worker-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102901` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^worker.*"}`

</details>

<br />

#### worker: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#worker-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102902` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^worker.*"}`

</details>

<br />

#### worker: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=102903` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^worker.*"}[1h]) + rate(container_fs_writes_total{name=~"^worker.*"}[1h]))`

</details>

<br />

### Worker: Provisioning indicators (not available on server)

#### worker: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#worker-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=103000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^worker.*"}[1d])`

</details>

<br />

#### worker: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#worker-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=103001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^worker.*"}[1d])`

</details>

<br />

#### worker: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#worker-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=103010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^worker.*"}[5m])`

</details>

<br />

#### worker: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#worker-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=103011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^worker.*"}[5m])`

</details>

<br />

#### worker: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#worker-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=103012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^worker.*"})`

</details>

<br />

### Worker: Golang runtime monitoring

#### worker: go_goroutines

<p class="subtitle">Maximum active goroutines</p>

A high value here indicates a possible goroutine leak.

Refer to the [alerts reference](./alerts.md#worker-go-goroutines) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=103100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_goroutines{job=~".*worker"})`

</details>

<br />

#### worker: go_gc_duration_seconds

<p class="subtitle">Maximum go garbage collection duration</p>

Refer to the [alerts reference](./alerts.md#worker-go-gc-duration-seconds) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=103101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_gc_duration_seconds{job=~".*worker"})`

</details>

<br />

### Worker: Kubernetes monitoring (only available on Kubernetes)

#### worker: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#worker-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/worker/worker?viewPanel=103200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*worker"}) / count by (app) (up{app=~".*worker"}) * 100`

</details>

<br />

## Repo Updater

<p class="subtitle">Manages interaction with code hosts, instructs Gitserver to update repositories.</p>

To see this dashboard, visit `/-/debug/grafana/d/repo-updater/repo-updater` on your Sourcegraph instance.

### Repo Updater: Repositories

#### repo-updater: syncer_sync_last_time

<p class="subtitle">Time since last sync</p>

A high value here indicates issues synchronizing repo metadata.
If the value is persistently high, make sure all external services have valid tokens.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(timestamp(vector(time()))) - max(src_repoupdater_syncer_sync_last_time)`

</details>

<br />

#### repo-updater: src_repoupdater_max_sync_backoff

<p class="subtitle">Time since oldest sync</p>

Refer to the [alerts reference](./alerts.md#repo-updater-src-repoupdater-max-sync-backoff) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_repoupdater_max_sync_backoff)`

</details>

<br />

#### repo-updater: src_repoupdater_syncer_sync_errors_total

<p class="subtitle">Site level external service sync error rate</p>

Refer to the [alerts reference](./alerts.md#repo-updater-src-repoupdater-syncer-sync-errors-total) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (family) (rate(src_repoupdater_syncer_sync_errors_total{owner!="user",reason!="invalid_npm_path",reason!="internal_rate_limit"}[5m]))`

</details>

<br />

#### repo-updater: syncer_sync_start

<p class="subtitle">Repo metadata sync was started</p>

Refer to the [alerts reference](./alerts.md#repo-updater-syncer-sync-start) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (family) (rate(src_repoupdater_syncer_start_sync{family="Syncer.SyncExternalService"}[9h0m0s]))`

</details>

<br />

#### repo-updater: syncer_sync_duration

<p class="subtitle">95th repositories sync duration</p>

Refer to the [alerts reference](./alerts.md#repo-updater-syncer-sync-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, max by (le, family, success) (rate(src_repoupdater_syncer_sync_duration_seconds_bucket[1m])))`

</details>

<br />

#### repo-updater: source_duration

<p class="subtitle">95th repositories source duration</p>

Refer to the [alerts reference](./alerts.md#repo-updater-source-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, max by (le) (rate(src_repoupdater_source_duration_seconds_bucket[1m])))`

</details>

<br />

#### repo-updater: syncer_synced_repos

<p class="subtitle">Repositories synced</p>

Refer to the [alerts reference](./alerts.md#repo-updater-syncer-synced-repos) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100020` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(rate(src_repoupdater_syncer_synced_repos_total[1m]))`

</details>

<br />

#### repo-updater: sourced_repos

<p class="subtitle">Repositories sourced</p>

Refer to the [alerts reference](./alerts.md#repo-updater-sourced-repos) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100021` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(rate(src_repoupdater_source_repos_total[1m]))`

</details>

<br />

#### repo-updater: user_added_repos

<p class="subtitle">Total number of user added repos</p>

Refer to the [alerts reference](./alerts.md#repo-updater-user-added-repos) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100022` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_repoupdater_user_repos_total)`

</details>

<br />

#### repo-updater: purge_failed

<p class="subtitle">Repositories purge failed</p>

Refer to the [alerts reference](./alerts.md#repo-updater-purge-failed) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100030` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(rate(src_repoupdater_purge_failed[1m]))`

</details>

<br />

#### repo-updater: sched_auto_fetch

<p class="subtitle">Repositories scheduled due to hitting a deadline</p>

Refer to the [alerts reference](./alerts.md#repo-updater-sched-auto-fetch) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100040` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(rate(src_repoupdater_sched_auto_fetch[1m]))`

</details>

<br />

#### repo-updater: sched_manual_fetch

<p class="subtitle">Repositories scheduled due to user traffic</p>

Check repo-updater logs if this value is persistently high.
This does not indicate anything if there are no user added code hosts.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100041` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(rate(src_repoupdater_sched_manual_fetch[1m]))`

</details>

<br />

#### repo-updater: sched_known_repos

<p class="subtitle">Repositories managed by the scheduler</p>

Refer to the [alerts reference](./alerts.md#repo-updater-sched-known-repos) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100050` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_repoupdater_sched_known_repos)`

</details>

<br />

#### repo-updater: sched_update_queue_length

<p class="subtitle">Rate of growth of update queue length over 5 minutes</p>

Refer to the [alerts reference](./alerts.md#repo-updater-sched-update-queue-length) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100051` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(deriv(src_repoupdater_sched_update_queue_length[5m]))`

</details>

<br />

#### repo-updater: sched_loops

<p class="subtitle">Scheduler loops</p>

Refer to the [alerts reference](./alerts.md#repo-updater-sched-loops) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100052` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(rate(src_repoupdater_sched_loops[1m]))`

</details>

<br />

#### repo-updater: src_repoupdater_stale_repos

<p class="subtitle">Repos that haven't been fetched in more than 8 hours</p>

Refer to the [alerts reference](./alerts.md#repo-updater-src-repoupdater-stale-repos) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100060` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_repoupdater_stale_repos)`

</details>

<br />

#### repo-updater: sched_error

<p class="subtitle">Repositories schedule error rate</p>

Refer to the [alerts reference](./alerts.md#repo-updater-sched-error) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100061` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(rate(src_repoupdater_sched_error[1m]))`

</details>

<br />

### Repo Updater: Permissions

#### repo-updater: perms_syncer_perms

<p class="subtitle">Time gap between least and most up to date permissions</p>

Refer to the [alerts reference](./alerts.md#repo-updater-perms-syncer-perms) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (type) (src_repoupdater_perms_syncer_perms_gap_seconds)`

</details>

<br />

#### repo-updater: perms_syncer_stale_perms

<p class="subtitle">Number of entities with stale permissions</p>

Refer to the [alerts reference](./alerts.md#repo-updater-perms-syncer-stale-perms) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (type) (src_repoupdater_perms_syncer_stale_perms)`

</details>

<br />

#### repo-updater: perms_syncer_no_perms

<p class="subtitle">Number of entities with no permissions</p>

Refer to the [alerts reference](./alerts.md#repo-updater-perms-syncer-no-perms) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (type) (src_repoupdater_perms_syncer_no_perms)`

</details>

<br />

#### repo-updater: perms_syncer_outdated_perms

<p class="subtitle">Number of entities with outdated permissions</p>

Refer to the [alerts reference](./alerts.md#repo-updater-perms-syncer-outdated-perms) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (type) (src_repoupdater_perms_syncer_outdated_perms)`

</details>

<br />

#### repo-updater: perms_syncer_sync_duration

<p class="subtitle">95th permissions sync duration</p>

Refer to the [alerts reference](./alerts.md#repo-updater-perms-syncer-sync-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100120` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, max by (le, type) (rate(src_repoupdater_perms_syncer_sync_duration_seconds_bucket[1m])))`

</details>

<br />

#### repo-updater: perms_syncer_queue_size

<p class="subtitle">Permissions sync queued items</p>

Refer to the [alerts reference](./alerts.md#repo-updater-perms-syncer-queue-size) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100121` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_repoupdater_perms_syncer_queue_size)`

</details>

<br />

#### repo-updater: perms_syncer_sync_errors

<p class="subtitle">Permissions sync error rate</p>

Refer to the [alerts reference](./alerts.md#repo-updater-perms-syncer-sync-errors) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100130` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (type) (ceil(rate(src_repoupdater_perms_syncer_sync_errors_total[1m])))`

</details>

<br />

#### repo-updater: perms_syncer_scheduled_repos_total

<p class="subtitle">Total number of repos scheduled for permissions sync</p>

Indicates how many repositories have been scheduled for a permissions sync.
More about repository permissions synchronization [here](https://docs.sourcegraph.com/admin/repo/permissions#permissions-sync-scheduling)

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100131` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(rate(src_repoupdater_perms_syncer_schedule_repos_total[1m]))`

</details>

<br />

### Repo Updater: External services

#### repo-updater: src_repoupdater_external_services_total

<p class="subtitle">The total number of external services</p>

Refer to the [alerts reference](./alerts.md#repo-updater-src-repoupdater-external-services-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_repoupdater_external_services_total)`

</details>

<br />

#### repo-updater: src_repoupdater_user_external_services_total

<p class="subtitle">The total number of user added external services</p>

Refer to the [alerts reference](./alerts.md#repo-updater-src-repoupdater-user-external-services-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_repoupdater_user_external_services_total)`

</details>

<br />

#### repo-updater: repoupdater_queued_sync_jobs_total

<p class="subtitle">The total number of queued sync jobs</p>

Refer to the [alerts reference](./alerts.md#repo-updater-repoupdater-queued-sync-jobs-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_repoupdater_queued_sync_jobs_total)`

</details>

<br />

#### repo-updater: repoupdater_completed_sync_jobs_total

<p class="subtitle">The total number of completed sync jobs</p>

Refer to the [alerts reference](./alerts.md#repo-updater-repoupdater-completed-sync-jobs-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_repoupdater_completed_sync_jobs_total)`

</details>

<br />

#### repo-updater: repoupdater_errored_sync_jobs_percentage

<p class="subtitle">The percentage of external services that have failed their most recent sync</p>

Refer to the [alerts reference](./alerts.md#repo-updater-repoupdater-errored-sync-jobs-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_repoupdater_errored_sync_jobs_percentage)`

</details>

<br />

#### repo-updater: github_graphql_rate_limit_remaining

<p class="subtitle">Remaining calls to GitHub graphql API before hitting the rate limit</p>

Refer to the [alerts reference](./alerts.md#repo-updater-github-graphql-rate-limit-remaining) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100220` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (src_github_rate_limit_remaining_v2{resource="graphql"})`

</details>

<br />

#### repo-updater: github_rest_rate_limit_remaining

<p class="subtitle">Remaining calls to GitHub rest API before hitting the rate limit</p>

Refer to the [alerts reference](./alerts.md#repo-updater-github-rest-rate-limit-remaining) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100221` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (src_github_rate_limit_remaining_v2{resource="rest"})`

</details>

<br />

#### repo-updater: github_search_rate_limit_remaining

<p class="subtitle">Remaining calls to GitHub search API before hitting the rate limit</p>

Refer to the [alerts reference](./alerts.md#repo-updater-github-search-rate-limit-remaining) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100222` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (src_github_rate_limit_remaining_v2{resource="search"})`

</details>

<br />

#### repo-updater: github_graphql_rate_limit_wait_duration

<p class="subtitle">Time spent waiting for the GitHub graphql API rate limiter</p>

Indicates how long we`re waiting on the rate limit once it has been exceeded

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100230` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(name) (rate(src_github_rate_limit_wait_duration_seconds{resource="graphql"}[5m]))`

</details>

<br />

#### repo-updater: github_rest_rate_limit_wait_duration

<p class="subtitle">Time spent waiting for the GitHub rest API rate limiter</p>

Indicates how long we`re waiting on the rate limit once it has been exceeded

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100231` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(name) (rate(src_github_rate_limit_wait_duration_seconds{resource="rest"}[5m]))`

</details>

<br />

#### repo-updater: github_search_rate_limit_wait_duration

<p class="subtitle">Time spent waiting for the GitHub search API rate limiter</p>

Indicates how long we`re waiting on the rate limit once it has been exceeded

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100232` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(name) (rate(src_github_rate_limit_wait_duration_seconds{resource="search"}[5m]))`

</details>

<br />

#### repo-updater: gitlab_rest_rate_limit_remaining

<p class="subtitle">Remaining calls to GitLab rest API before hitting the rate limit</p>

Refer to the [alerts reference](./alerts.md#repo-updater-gitlab-rest-rate-limit-remaining) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100240` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (src_gitlab_rate_limit_remaining{resource="rest"})`

</details>

<br />

#### repo-updater: gitlab_rest_rate_limit_wait_duration

<p class="subtitle">Time spent waiting for the GitLab rest API rate limiter</p>

Indicates how long we`re waiting on the rate limit once it has been exceeded

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100241` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (rate(src_gitlab_rate_limit_wait_duration_seconds{resource="rest"}[5m]))`

</details>

<br />

#### repo-updater: src_internal_rate_limit_wait_duration_bucket

<p class="subtitle">95th percentile time spent successfully waiting on our internal rate limiter</p>

Indicates how long we`re waiting on our internal rate limiter when communicating with a code host

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100250` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, sum(rate(src_internal_rate_limit_wait_duration_bucket{failed="false"}[5m])) by (le, urn))`

</details>

<br />

#### repo-updater: src_internal_rate_limit_wait_error_count

<p class="subtitle">Rate of failures waiting on our internal rate limiter</p>

The rate at which we fail our internal rate limiter.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100251` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (urn) (rate(src_internal_rate_limit_wait_duration_count{failed="true"}[5m]))`

</details>

<br />

### Repo Updater: Batches: dbstore stats

#### repo-updater: batches_dbstore_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_dbstore_total{job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: batches_dbstore_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_batches_dbstore_duration_seconds_bucket{job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: batches_dbstore_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_dbstore_errors_total{job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: batches_dbstore_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_dbstore_errors_total{job=~"^repo-updater.*"}[5m])) / (sum(increase(src_batches_dbstore_total{job=~"^repo-updater.*"}[5m])) + sum(increase(src_batches_dbstore_errors_total{job=~"^repo-updater.*"}[5m]))) * 100`

</details>

<br />

#### repo-updater: batches_dbstore_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_dbstore_total{job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: batches_dbstore_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_batches_dbstore_duration_seconds_bucket{job=~"^repo-updater.*"}[5m])))`

</details>

<br />

#### repo-updater: batches_dbstore_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_dbstore_errors_total{job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: batches_dbstore_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100313` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_dbstore_errors_total{job=~"^repo-updater.*"}[5m])) / (sum by (op)(increase(src_batches_dbstore_total{job=~"^repo-updater.*"}[5m])) + sum by (op)(increase(src_batches_dbstore_errors_total{job=~"^repo-updater.*"}[5m]))) * 100`

</details>

<br />

### Repo Updater: Batches: service stats

#### repo-updater: batches_service_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_service_total{job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: batches_service_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_batches_service_duration_seconds_bucket{job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: batches_service_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_service_errors_total{job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: batches_service_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100403` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_batches_service_errors_total{job=~"^repo-updater.*"}[5m])) / (sum(increase(src_batches_service_total{job=~"^repo-updater.*"}[5m])) + sum(increase(src_batches_service_errors_total{job=~"^repo-updater.*"}[5m]))) * 100`

</details>

<br />

#### repo-updater: batches_service_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_service_total{job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: batches_service_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100411` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_batches_service_duration_seconds_bucket{job=~"^repo-updater.*"}[5m])))`

</details>

<br />

#### repo-updater: batches_service_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100412` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_service_errors_total{job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: batches_service_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100413` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Batch Changes team](https://handbook.sourcegraph.com/departments/engineering/teams/batch-changes).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_batches_service_errors_total{job=~"^repo-updater.*"}[5m])) / (sum by (op)(increase(src_batches_service_total{job=~"^repo-updater.*"}[5m])) + sum by (op)(increase(src_batches_service_errors_total{job=~"^repo-updater.*"}[5m]))) * 100`

</details>

<br />

### Repo Updater: Codeintel: Coursier invocation stats

#### repo-updater: codeintel_coursier_total

<p class="subtitle">Aggregate invocations operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_coursier_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: codeintel_coursier_99th_percentile_duration

<p class="subtitle">Aggregate successful invocations operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_coursier_duration_seconds_bucket{op!="RunCommand",job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: codeintel_coursier_errors_total

<p class="subtitle">Aggregate invocations operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100502` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: codeintel_coursier_error_rate

<p class="subtitle">Aggregate invocations operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100503` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m])) / (sum(increase(src_codeintel_coursier_total{op!="RunCommand",job=~"^repo-updater.*"}[5m])) + sum(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))) * 100`

</details>

<br />

#### repo-updater: codeintel_coursier_total

<p class="subtitle">Invocations operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100510` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_coursier_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: codeintel_coursier_99th_percentile_duration

<p class="subtitle">99th percentile successful invocations operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100511` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_coursier_duration_seconds_bucket{op!="RunCommand",job=~"^repo-updater.*"}[5m])))`

</details>

<br />

#### repo-updater: codeintel_coursier_errors_total

<p class="subtitle">Invocations operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100512` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: codeintel_coursier_error_rate

<p class="subtitle">Invocations operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100513` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m])) / (sum by (op)(increase(src_codeintel_coursier_total{op!="RunCommand",job=~"^repo-updater.*"}[5m])) + sum by (op)(increase(src_codeintel_coursier_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))) * 100`

</details>

<br />

### Repo Updater: Codeintel: npm invocation stats

#### repo-updater: codeintel_npm_total

<p class="subtitle">Aggregate invocations operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_npm_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: codeintel_npm_99th_percentile_duration

<p class="subtitle">Aggregate successful invocations operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_npm_duration_seconds_bucket{op!="RunCommand",job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: codeintel_npm_errors_total

<p class="subtitle">Aggregate invocations operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100602` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: codeintel_npm_error_rate

<p class="subtitle">Aggregate invocations operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100603` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m])) / (sum(increase(src_codeintel_npm_total{op!="RunCommand",job=~"^repo-updater.*"}[5m])) + sum(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))) * 100`

</details>

<br />

#### repo-updater: codeintel_npm_total

<p class="subtitle">Invocations operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100610` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_npm_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: codeintel_npm_99th_percentile_duration

<p class="subtitle">99th percentile successful invocations operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100611` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_npm_duration_seconds_bucket{op!="RunCommand",job=~"^repo-updater.*"}[5m])))`

</details>

<br />

#### repo-updater: codeintel_npm_errors_total

<p class="subtitle">Invocations operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100612` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))`

</details>

<br />

#### repo-updater: codeintel_npm_error_rate

<p class="subtitle">Invocations operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100613` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m])) / (sum by (op)(increase(src_codeintel_npm_total{op!="RunCommand",job=~"^repo-updater.*"}[5m])) + sum by (op)(increase(src_codeintel_npm_errors_total{op!="RunCommand",job=~"^repo-updater.*"}[5m]))) * 100`

</details>

<br />

### Repo Updater: HTTP handlers

#### repo-updater: healthy_request_rate

<p class="subtitle">Requests per second, by route, when status code is 200</p>

The number of healthy HTTP requests per second to internal HTTP api

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100700` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (route) (rate(src_http_request_duration_seconds_count{app="repo-updater",code=~"2.."}[5m]))`

</details>

<br />

#### repo-updater: unhealthy_request_rate

<p class="subtitle">Requests per second, by route, when status code is not 200</p>

The number of unhealthy HTTP requests per second to internal HTTP api

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100701` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (route) (rate(src_http_request_duration_seconds_count{app="repo-updater",code!~"2.."}[5m]))`

</details>

<br />

#### repo-updater: request_rate_by_code

<p class="subtitle">Requests per second, by status code</p>

The number of HTTP requests per second by code

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100702` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (code) (rate(src_http_request_duration_seconds_count{app="repo-updater"}[5m]))`

</details>

<br />

#### repo-updater: 95th_percentile_healthy_requests

<p class="subtitle">95th percentile duration by route, when status code is 200</p>

The 95th percentile duration by route when the status code is 200 

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100710` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, sum(rate(src_http_request_duration_seconds_bucket{app="repo-updater",code=~"2.."}[5m])) by (le, route))`

</details>

<br />

#### repo-updater: 95th_percentile_unhealthy_requests

<p class="subtitle">95th percentile duration by route, when status code is not 200</p>

The 95th percentile duration by route when the status code is not 200 

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100711` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.95, sum(rate(src_http_request_duration_seconds_bucket{app="repo-updater",code!~"2.."}[5m])) by (le, route))`

</details>

<br />

### Repo Updater: Internal service requests

#### repo-updater: frontend_internal_api_error_responses

<p class="subtitle">Frontend-internal API error responses every 5m by route</p>

Refer to the [alerts reference](./alerts.md#repo-updater-frontend-internal-api-error-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100800` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (category)(increase(src_frontend_internal_request_duration_seconds_count{job="repo-updater",code!~"2.."}[5m])) / ignoring(category) group_left sum(increase(src_frontend_internal_request_duration_seconds_count{job="repo-updater"}[5m]))`

</details>

<br />

### Repo Updater: Database connections

#### repo-updater: max_open_conns

<p class="subtitle">Maximum open</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_max_open{app_name="repo-updater"})`

</details>

<br />

#### repo-updater: open_conns

<p class="subtitle">Established</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100901` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_open{app_name="repo-updater"})`

</details>

<br />

#### repo-updater: in_use

<p class="subtitle">Used</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100910` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_in_use{app_name="repo-updater"})`

</details>

<br />

#### repo-updater: idle

<p class="subtitle">Idle</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100911` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_idle{app_name="repo-updater"})`

</details>

<br />

#### repo-updater: mean_blocked_seconds_per_conn_request

<p class="subtitle">Mean blocked seconds per conn request</p>

Refer to the [alerts reference](./alerts.md#repo-updater-mean-blocked-seconds-per-conn-request) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100920` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_blocked_seconds{app_name="repo-updater"}[5m])) / sum by (app_name, db_name) (increase(src_pgsql_conns_waited_for{app_name="repo-updater"}[5m]))`

</details>

<br />

#### repo-updater: closed_max_idle

<p class="subtitle">Closed by SetMaxIdleConns</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100930` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle{app_name="repo-updater"}[5m]))`

</details>

<br />

#### repo-updater: closed_max_lifetime

<p class="subtitle">Closed by SetConnMaxLifetime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100931` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_lifetime{app_name="repo-updater"}[5m]))`

</details>

<br />

#### repo-updater: closed_max_idle_time

<p class="subtitle">Closed by SetConnMaxIdleTime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=100932` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle_time{app_name="repo-updater"}[5m]))`

</details>

<br />

### Repo Updater: Container monitoring (not available on server)

#### repo-updater: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod repo-updater` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p repo-updater`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' repo-updater` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the repo-updater container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs repo-updater` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^repo-updater.*"}) > 60)`

</details>

<br />

#### repo-updater: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#repo-updater-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^repo-updater.*"}`

</details>

<br />

#### repo-updater: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#repo-updater-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^repo-updater.*"}`

</details>

<br />

#### repo-updater: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101003` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^repo-updater.*"}[1h]) + rate(container_fs_writes_total{name=~"^repo-updater.*"}[1h]))`

</details>

<br />

### Repo Updater: Provisioning indicators (not available on server)

#### repo-updater: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#repo-updater-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^repo-updater.*"}[1d])`

</details>

<br />

#### repo-updater: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#repo-updater-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^repo-updater.*"}[1d])`

</details>

<br />

#### repo-updater: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#repo-updater-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^repo-updater.*"}[5m])`

</details>

<br />

#### repo-updater: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#repo-updater-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^repo-updater.*"}[5m])`

</details>

<br />

#### repo-updater: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#repo-updater-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^repo-updater.*"})`

</details>

<br />

### Repo Updater: Golang runtime monitoring

#### repo-updater: go_goroutines

<p class="subtitle">Maximum active goroutines</p>

A high value here indicates a possible goroutine leak.

Refer to the [alerts reference](./alerts.md#repo-updater-go-goroutines) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_goroutines{job=~".*repo-updater"})`

</details>

<br />

#### repo-updater: go_gc_duration_seconds

<p class="subtitle">Maximum go garbage collection duration</p>

Refer to the [alerts reference](./alerts.md#repo-updater-go-gc-duration-seconds) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_gc_duration_seconds{job=~".*repo-updater"})`

</details>

<br />

### Repo Updater: Kubernetes monitoring (only available on Kubernetes)

#### repo-updater: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#repo-updater-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/repo-updater/repo-updater?viewPanel=101300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Repo Management team](https://handbook.sourcegraph.com/departments/engineering/teams/repo-management).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*repo-updater"}) / count by (app) (up{app=~".*repo-updater"}) * 100`

</details>

<br />

## Searcher

<p class="subtitle">Performs unindexed searches (diff and commit search, text search for unindexed branches).</p>

To see this dashboard, visit `/-/debug/grafana/d/searcher/searcher` on your Sourcegraph instance.

#### searcher: unindexed_search_request_errors

<p class="subtitle">Unindexed search request errors every 5m by code</p>

Refer to the [alerts reference](./alerts.md#searcher-unindexed-search-request-errors) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (code)(increase(searcher_service_request_total{code!="200",code!="canceled"}[5m])) / ignoring(code) group_left sum(increase(searcher_service_request_total[5m])) * 100`

</details>

<br />

#### searcher: replica_traffic

<p class="subtitle">Requests per second over 10m</p>

Refer to the [alerts reference](./alerts.md#searcher-replica-traffic) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(instance) (rate(searcher_service_request_total[10m]))`

</details>

<br />

### Searcher: Database connections

#### searcher: max_open_conns

<p class="subtitle">Maximum open</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_max_open{app_name="searcher"})`

</details>

<br />

#### searcher: open_conns

<p class="subtitle">Established</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_open{app_name="searcher"})`

</details>

<br />

#### searcher: in_use

<p class="subtitle">Used</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_in_use{app_name="searcher"})`

</details>

<br />

#### searcher: idle

<p class="subtitle">Idle</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_idle{app_name="searcher"})`

</details>

<br />

#### searcher: mean_blocked_seconds_per_conn_request

<p class="subtitle">Mean blocked seconds per conn request</p>

Refer to the [alerts reference](./alerts.md#searcher-mean-blocked-seconds-per-conn-request) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100120` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_blocked_seconds{app_name="searcher"}[5m])) / sum by (app_name, db_name) (increase(src_pgsql_conns_waited_for{app_name="searcher"}[5m]))`

</details>

<br />

#### searcher: closed_max_idle

<p class="subtitle">Closed by SetMaxIdleConns</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100130` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle{app_name="searcher"}[5m]))`

</details>

<br />

#### searcher: closed_max_lifetime

<p class="subtitle">Closed by SetConnMaxLifetime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100131` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_lifetime{app_name="searcher"}[5m]))`

</details>

<br />

#### searcher: closed_max_idle_time

<p class="subtitle">Closed by SetConnMaxIdleTime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100132` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle_time{app_name="searcher"}[5m]))`

</details>

<br />

### Searcher: Internal service requests

#### searcher: frontend_internal_api_error_responses

<p class="subtitle">Frontend-internal API error responses every 5m by route</p>

Refer to the [alerts reference](./alerts.md#searcher-frontend-internal-api-error-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (category)(increase(src_frontend_internal_request_duration_seconds_count{job="searcher",code!~"2.."}[5m])) / ignoring(category) group_left sum(increase(src_frontend_internal_request_duration_seconds_count{job="searcher"}[5m]))`

</details>

<br />

### Searcher: Container monitoring (not available on server)

#### searcher: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod searcher` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p searcher`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' searcher` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the searcher container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs searcher` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^searcher.*"}) > 60)`

</details>

<br />

#### searcher: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#searcher-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^searcher.*"}`

</details>

<br />

#### searcher: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#searcher-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^searcher.*"}`

</details>

<br />

#### searcher: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^searcher.*"}[1h]) + rate(container_fs_writes_total{name=~"^searcher.*"}[1h]))`

</details>

<br />

### Searcher: Provisioning indicators (not available on server)

#### searcher: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#searcher-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^searcher.*"}[1d])`

</details>

<br />

#### searcher: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#searcher-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^searcher.*"}[1d])`

</details>

<br />

#### searcher: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#searcher-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^searcher.*"}[5m])`

</details>

<br />

#### searcher: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#searcher-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100411` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^searcher.*"}[5m])`

</details>

<br />

#### searcher: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#searcher-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100412` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^searcher.*"})`

</details>

<br />

### Searcher: Golang runtime monitoring

#### searcher: go_goroutines

<p class="subtitle">Maximum active goroutines</p>

A high value here indicates a possible goroutine leak.

Refer to the [alerts reference](./alerts.md#searcher-go-goroutines) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_goroutines{job=~".*searcher"})`

</details>

<br />

#### searcher: go_gc_duration_seconds

<p class="subtitle">Maximum go garbage collection duration</p>

Refer to the [alerts reference](./alerts.md#searcher-go-gc-duration-seconds) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_gc_duration_seconds{job=~".*searcher"})`

</details>

<br />

### Searcher: Kubernetes monitoring (only available on Kubernetes)

#### searcher: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#searcher-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/searcher/searcher?viewPanel=100600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*searcher"}) / count by (app) (up{app=~".*searcher"}) * 100`

</details>

<br />

## Symbols

<p class="subtitle">Handles symbol searches for unindexed branches.</p>

To see this dashboard, visit `/-/debug/grafana/d/symbols/symbols` on your Sourcegraph instance.

### Symbols: Codeintel: Symbols API

#### symbols: codeintel_symbols_api_total

<p class="subtitle">Aggregate API operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_api_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_api_99th_percentile_duration

<p class="subtitle">Aggregate successful API operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_symbols_api_duration_seconds_bucket{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_api_errors_total

<p class="subtitle">Aggregate API operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_api_errors_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_api_error_rate

<p class="subtitle">Aggregate API operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100003` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_api_errors_total{job=~"^symbols.*"}[5m])) / (sum(increase(src_codeintel_symbols_api_total{job=~"^symbols.*"}[5m])) + sum(increase(src_codeintel_symbols_api_errors_total{job=~"^symbols.*"}[5m]))) * 100`

</details>

<br />

#### symbols: codeintel_symbols_api_total

<p class="subtitle">API operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op,parseAmount)(increase(src_codeintel_symbols_api_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_api_99th_percentile_duration

<p class="subtitle">99th percentile successful API operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op,parseAmount)(rate(src_codeintel_symbols_api_duration_seconds_bucket{job=~"^symbols.*"}[5m])))`

</details>

<br />

#### symbols: codeintel_symbols_api_errors_total

<p class="subtitle">API operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op,parseAmount)(increase(src_codeintel_symbols_api_errors_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_api_error_rate

<p class="subtitle">API operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100013` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op,parseAmount)(increase(src_codeintel_symbols_api_errors_total{job=~"^symbols.*"}[5m])) / (sum by (op,parseAmount)(increase(src_codeintel_symbols_api_total{job=~"^symbols.*"}[5m])) + sum by (op,parseAmount)(increase(src_codeintel_symbols_api_errors_total{job=~"^symbols.*"}[5m]))) * 100`

</details>

<br />

### Symbols: Codeintel: Symbols parser

#### symbols: symbols

<p class="subtitle">In-flight parse jobs</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_symbols_parsing{job=~"^symbols.*"})`

</details>

<br />

#### symbols: symbols

<p class="subtitle">Parser queue size</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_symbols_parse_queue_size{job=~"^symbols.*"})`

</details>

<br />

#### symbols: symbols

<p class="subtitle">Parse queue timeouts</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_symbols_parse_queue_timeouts_total{job=~"^symbols.*"})`

</details>

<br />

#### symbols: symbols

<p class="subtitle">Parse failures every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100103` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `rate(src_codeintel_symbols_parse_failed_total{job=~"^symbols.*"}[5m])`

</details>

<br />

#### symbols: codeintel_symbols_parser_total

<p class="subtitle">Aggregate parser operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_parser_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_parser_99th_percentile_duration

<p class="subtitle">Aggregate successful parser operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_symbols_parser_duration_seconds_bucket{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_parser_errors_total

<p class="subtitle">Aggregate parser operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_parser_errors_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_parser_error_rate

<p class="subtitle">Aggregate parser operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100113` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_parser_errors_total{job=~"^symbols.*"}[5m])) / (sum(increase(src_codeintel_symbols_parser_total{job=~"^symbols.*"}[5m])) + sum(increase(src_codeintel_symbols_parser_errors_total{job=~"^symbols.*"}[5m]))) * 100`

</details>

<br />

#### symbols: codeintel_symbols_parser_total

<p class="subtitle">Parser operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100120` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_symbols_parser_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_parser_99th_percentile_duration

<p class="subtitle">99th percentile successful parser operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100121` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_symbols_parser_duration_seconds_bucket{job=~"^symbols.*"}[5m])))`

</details>

<br />

#### symbols: codeintel_symbols_parser_errors_total

<p class="subtitle">Parser operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100122` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_symbols_parser_errors_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_parser_error_rate

<p class="subtitle">Parser operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100123` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_symbols_parser_errors_total{job=~"^symbols.*"}[5m])) / (sum by (op)(increase(src_codeintel_symbols_parser_total{job=~"^symbols.*"}[5m])) + sum by (op)(increase(src_codeintel_symbols_parser_errors_total{job=~"^symbols.*"}[5m]))) * 100`

</details>

<br />

### Symbols: Codeintel: Symbols cache janitor

#### symbols: symbols

<p class="subtitle">Size in bytes of the on-disk cache</p>

no

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `src_codeintel_symbols_store_cache_size_bytes`

</details>

<br />

#### symbols: symbols

<p class="subtitle">Cache eviction operations every 5m</p>

no

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `rate(src_codeintel_symbols_store_evictions_total[5m])`

</details>

<br />

#### symbols: symbols

<p class="subtitle">Cache eviction operation errors every 5m</p>

no

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `rate(src_codeintel_symbols_store_errors_total[5m])`

</details>

<br />

### Symbols: Codeintel: Symbols repository fetcher

#### symbols: symbols

<p class="subtitle">In-flight repository fetch operations</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `src_codeintel_symbols_fetching`

</details>

<br />

#### symbols: symbols

<p class="subtitle">Repository fetch queue size</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_symbols_fetch_queue_size{job=~"^symbols.*"})`

</details>

<br />

#### symbols: codeintel_symbols_repository_fetcher_total

<p class="subtitle">Aggregate fetcher operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_repository_fetcher_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_repository_fetcher_99th_percentile_duration

<p class="subtitle">Aggregate successful fetcher operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_symbols_repository_fetcher_duration_seconds_bucket{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_repository_fetcher_errors_total

<p class="subtitle">Aggregate fetcher operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_repository_fetcher_errors_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_repository_fetcher_error_rate

<p class="subtitle">Aggregate fetcher operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100313` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_repository_fetcher_errors_total{job=~"^symbols.*"}[5m])) / (sum(increase(src_codeintel_symbols_repository_fetcher_total{job=~"^symbols.*"}[5m])) + sum(increase(src_codeintel_symbols_repository_fetcher_errors_total{job=~"^symbols.*"}[5m]))) * 100`

</details>

<br />

#### symbols: codeintel_symbols_repository_fetcher_total

<p class="subtitle">Fetcher operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100320` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_symbols_repository_fetcher_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_repository_fetcher_99th_percentile_duration

<p class="subtitle">99th percentile successful fetcher operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100321` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_symbols_repository_fetcher_duration_seconds_bucket{job=~"^symbols.*"}[5m])))`

</details>

<br />

#### symbols: codeintel_symbols_repository_fetcher_errors_total

<p class="subtitle">Fetcher operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100322` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_symbols_repository_fetcher_errors_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_repository_fetcher_error_rate

<p class="subtitle">Fetcher operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100323` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_symbols_repository_fetcher_errors_total{job=~"^symbols.*"}[5m])) / (sum by (op)(increase(src_codeintel_symbols_repository_fetcher_total{job=~"^symbols.*"}[5m])) + sum by (op)(increase(src_codeintel_symbols_repository_fetcher_errors_total{job=~"^symbols.*"}[5m]))) * 100`

</details>

<br />

### Symbols: Codeintel: Symbols gitserver client

#### symbols: codeintel_symbols_gitserver_total

<p class="subtitle">Aggregate gitserver client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_gitserver_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_gitserver_99th_percentile_duration

<p class="subtitle">Aggregate successful gitserver client operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_symbols_gitserver_duration_seconds_bucket{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_gitserver_errors_total

<p class="subtitle">Aggregate gitserver client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_gitserver_errors_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_gitserver_error_rate

<p class="subtitle">Aggregate gitserver client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100403` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_symbols_gitserver_errors_total{job=~"^symbols.*"}[5m])) / (sum(increase(src_codeintel_symbols_gitserver_total{job=~"^symbols.*"}[5m])) + sum(increase(src_codeintel_symbols_gitserver_errors_total{job=~"^symbols.*"}[5m]))) * 100`

</details>

<br />

#### symbols: codeintel_symbols_gitserver_total

<p class="subtitle">Gitserver client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_symbols_gitserver_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_gitserver_99th_percentile_duration

<p class="subtitle">99th percentile successful gitserver client operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100411` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_symbols_gitserver_duration_seconds_bucket{job=~"^symbols.*"}[5m])))`

</details>

<br />

#### symbols: codeintel_symbols_gitserver_errors_total

<p class="subtitle">Gitserver client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100412` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_symbols_gitserver_errors_total{job=~"^symbols.*"}[5m]))`

</details>

<br />

#### symbols: codeintel_symbols_gitserver_error_rate

<p class="subtitle">Gitserver client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100413` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_symbols_gitserver_errors_total{job=~"^symbols.*"}[5m])) / (sum by (op)(increase(src_codeintel_symbols_gitserver_total{job=~"^symbols.*"}[5m])) + sum by (op)(increase(src_codeintel_symbols_gitserver_errors_total{job=~"^symbols.*"}[5m]))) * 100`

</details>

<br />

### Symbols: Database connections

#### symbols: max_open_conns

<p class="subtitle">Maximum open</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_max_open{app_name="symbols"})`

</details>

<br />

#### symbols: open_conns

<p class="subtitle">Established</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_open{app_name="symbols"})`

</details>

<br />

#### symbols: in_use

<p class="subtitle">Used</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100510` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_in_use{app_name="symbols"})`

</details>

<br />

#### symbols: idle

<p class="subtitle">Idle</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100511` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (src_pgsql_conns_idle{app_name="symbols"})`

</details>

<br />

#### symbols: mean_blocked_seconds_per_conn_request

<p class="subtitle">Mean blocked seconds per conn request</p>

Refer to the [alerts reference](./alerts.md#symbols-mean-blocked-seconds-per-conn-request) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100520` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_blocked_seconds{app_name="symbols"}[5m])) / sum by (app_name, db_name) (increase(src_pgsql_conns_waited_for{app_name="symbols"}[5m]))`

</details>

<br />

#### symbols: closed_max_idle

<p class="subtitle">Closed by SetMaxIdleConns</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100530` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle{app_name="symbols"}[5m]))`

</details>

<br />

#### symbols: closed_max_lifetime

<p class="subtitle">Closed by SetConnMaxLifetime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100531` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_lifetime{app_name="symbols"}[5m]))`

</details>

<br />

#### symbols: closed_max_idle_time

<p class="subtitle">Closed by SetConnMaxIdleTime</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100532` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (app_name, db_name) (increase(src_pgsql_conns_closed_max_idle_time{app_name="symbols"}[5m]))`

</details>

<br />

### Symbols: Internal service requests

#### symbols: frontend_internal_api_error_responses

<p class="subtitle">Frontend-internal API error responses every 5m by route</p>

Refer to the [alerts reference](./alerts.md#symbols-frontend-internal-api-error-responses) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (category)(increase(src_frontend_internal_request_duration_seconds_count{job="symbols",code!~"2.."}[5m])) / ignoring(category) group_left sum(increase(src_frontend_internal_request_duration_seconds_count{job="symbols"}[5m]))`

</details>

<br />

### Symbols: Container monitoring (not available on server)

#### symbols: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod symbols` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p symbols`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' symbols` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the symbols container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs symbols` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100700` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^symbols.*"}) > 60)`

</details>

<br />

#### symbols: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#symbols-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100701` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^symbols.*"}`

</details>

<br />

#### symbols: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#symbols-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100702` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^symbols.*"}`

</details>

<br />

#### symbols: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100703` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^symbols.*"}[1h]) + rate(container_fs_writes_total{name=~"^symbols.*"}[1h]))`

</details>

<br />

### Symbols: Provisioning indicators (not available on server)

#### symbols: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#symbols-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100800` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^symbols.*"}[1d])`

</details>

<br />

#### symbols: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#symbols-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100801` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^symbols.*"}[1d])`

</details>

<br />

#### symbols: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#symbols-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100810` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^symbols.*"}[5m])`

</details>

<br />

#### symbols: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#symbols-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100811` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^symbols.*"}[5m])`

</details>

<br />

#### symbols: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#symbols-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100812` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^symbols.*"})`

</details>

<br />

### Symbols: Golang runtime monitoring

#### symbols: go_goroutines

<p class="subtitle">Maximum active goroutines</p>

A high value here indicates a possible goroutine leak.

Refer to the [alerts reference](./alerts.md#symbols-go-goroutines) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_goroutines{job=~".*symbols"})`

</details>

<br />

#### symbols: go_gc_duration_seconds

<p class="subtitle">Maximum go garbage collection duration</p>

Refer to the [alerts reference](./alerts.md#symbols-go-gc-duration-seconds) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=100901` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(instance) (go_gc_duration_seconds{job=~".*symbols"})`

</details>

<br />

### Symbols: Kubernetes monitoring (only available on Kubernetes)

#### symbols: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#symbols-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/symbols/symbols?viewPanel=101000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*symbols"}) / count by (app) (up{app=~".*symbols"}) * 100`

</details>

<br />

## Syntect Server

<p class="subtitle">Handles syntax highlighting for code files.</p>

To see this dashboard, visit `/-/debug/grafana/d/syntect-server/syntect-server` on your Sourcegraph instance.

#### syntect-server: syntax_highlighting_errors

<p class="subtitle">Syntax highlighting errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_syntax_highlighting_requests{status="error"}[5m])) / sum(increase(src_syntax_highlighting_requests[5m])) * 100`

</details>

<br />

#### syntect-server: syntax_highlighting_timeouts

<p class="subtitle">Syntax highlighting timeouts every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_syntax_highlighting_requests{status="timeout"}[5m])) / sum(increase(src_syntax_highlighting_requests[5m])) * 100`

</details>

<br />

#### syntect-server: syntax_highlighting_panics

<p class="subtitle">Syntax highlighting panics every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_syntax_highlighting_requests{status="panic"}[5m]))`

</details>

<br />

#### syntect-server: syntax_highlighting_worker_deaths

<p class="subtitle">Syntax highlighter worker deaths every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_syntax_highlighting_requests{status="hss_worker_timeout"}[5m]))`

</details>

<br />

### Syntect Server: Container monitoring (not available on server)

#### syntect-server: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod syntect-server` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p syntect-server`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' syntect-server` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the syntect-server container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs syntect-server` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^syntect-server.*"}) > 60)`

</details>

<br />

#### syntect-server: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#syntect-server-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^syntect-server.*"}`

</details>

<br />

#### syntect-server: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#syntect-server-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^syntect-server.*"}`

</details>

<br />

#### syntect-server: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100103` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^syntect-server.*"}[1h]) + rate(container_fs_writes_total{name=~"^syntect-server.*"}[1h]))`

</details>

<br />

### Syntect Server: Provisioning indicators (not available on server)

#### syntect-server: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#syntect-server-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^syntect-server.*"}[1d])`

</details>

<br />

#### syntect-server: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#syntect-server-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^syntect-server.*"}[1d])`

</details>

<br />

#### syntect-server: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#syntect-server-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^syntect-server.*"}[5m])`

</details>

<br />

#### syntect-server: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#syntect-server-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^syntect-server.*"}[5m])`

</details>

<br />

#### syntect-server: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#syntect-server-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^syntect-server.*"})`

</details>

<br />

### Syntect Server: Kubernetes monitoring (only available on Kubernetes)

#### syntect-server: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#syntect-server-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/syntect-server/syntect-server?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*syntect-server"}) / count by (app) (up{app=~".*syntect-server"}) * 100`

</details>

<br />

## Zoekt

<p class="subtitle">Indexes repositories, populates the search index, and responds to indexed search queries.</p>

To see this dashboard, visit `/-/debug/grafana/d/zoekt/zoekt` on your Sourcegraph instance.

#### zoekt: total_repos_aggregate

<p class="subtitle">Total number of repos (aggregate)</p>

Sudden changes can be caused by indexing configuration changes.

Additionally, a discrepancy between "assigned" and "tracked" could indicate a bug.

Legend:
- assigned: # of repos assigned to Zoekt
- indexed: # of repos Zoekt has indexed
- tracked: # of repos Zoekt is aware of, including those that it has finished indexing

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(index_num_assigned)`

</details>

<br />

#### zoekt: total_repos_per_instance

<p class="subtitle">Total number of repos (per instance)</p>

Sudden changes can be caused by indexing configuration changes.

Additionally, a discrepancy between "assigned" and "tracked" could indicate a bug.

Legend:
- assigned: # of repos assigned to Zoekt
- indexed: # of repos Zoekt has indexed
- tracked: # of repos Zoekt is aware of, including those that it has finished processing

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (instance) (index_num_assigned{instance=~`${instance:regex}`})`

</details>

<br />

#### zoekt: repos_stopped_tracking_total_aggregate

<p class="subtitle">The number of repositories we stopped tracking over 5m (aggregate)</p>

Repositories we stop tracking are soft-deleted during the next cleanup job.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(index_num_stopped_tracking_total[5m]))`

</details>

<br />

#### zoekt: repos_stopped_tracking_total_per_instance

<p class="subtitle">The number of repositories we stopped tracking over 5m (per instance)</p>

Repositories we stop tracking are soft-deleted during the next cleanup job.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (instance) (increase(index_num_stopped_tracking_total{instance=~`${instance:regex}`}[5m]))`

</details>

<br />

#### zoekt: average_resolve_revision_duration

<p class="subtitle">Average resolve revision duration over 5m</p>

Refer to the [alerts reference](./alerts.md#zoekt-average-resolve-revision-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100020` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(resolve_revision_seconds_sum[5m])) / sum(rate(resolve_revision_seconds_count[5m]))`

</details>

<br />

#### zoekt: get_index_options_error_increase

<p class="subtitle">The number of repositories we failed to get indexing options over 5m</p>

When considering indexing a repository we ask for the index configuration
from frontend per repository. The most likely reason this would fail is
failing to resolve branch names to git SHAs.

This value can spike up during deployments/etc. Only if you encounter
sustained periods of errors is there an underlying issue. When sustained
this indicates repositories will not get updated indexes.

Refer to the [alerts reference](./alerts.md#zoekt-get-index-options-error-increase) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100021` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(get_index_options_error_total[5m]))`

</details>

<br />

### Zoekt: Search requests

#### zoekt: indexed_search_request_errors

<p class="subtitle">Indexed search request errors every 5m by code</p>

Refer to the [alerts reference](./alerts.md#zoekt-indexed-search-request-errors) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (code)(increase(src_zoekt_request_duration_seconds_count{code!~"2.."}[5m])) / ignoring(code) group_left sum(increase(src_zoekt_request_duration_seconds_count[5m])) * 100`

</details>

<br />

#### zoekt: zoekt_shards_sched

<p class="subtitle">Current number of zoekt scheduler processes in a state</p>

Each ongoing search request starts its life as an interactive query. If it
takes too long it becomes a batch query. Between state transitions it can be queued.

If you have a high number of batch queries it is a sign there is a large load
of slow queries. Alternatively your systems are underprovisioned and normal
search queries are taking too long.

For a full explanation of the states see https://github.com/sourcegraph/zoekt/blob/930cd1c28917e64c87f0ce354a0fd040877cbba1/shards/sched.go#L311-L340

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (type, state) (zoekt_shards_sched)`

</details>

<br />

#### zoekt: zoekt_shards_sched_total

<p class="subtitle">Rate of zoekt scheduler process state transitions in the last 5m</p>

Each ongoing search request starts its life as an interactive query. If it
takes too long it becomes a batch query. Between state transitions it can be queued.

If you have a high number of batch queries it is a sign there is a large load
of slow queries. Alternatively your systems are underprovisioned and normal
search queries are taking too long.

For a full explanation of the states see https://github.com/sourcegraph/zoekt/blob/930cd1c28917e64c87f0ce354a0fd040877cbba1/shards/sched.go#L311-L340

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (type, state) (rate(zoekt_shards_sched[5m]))`

</details>

<br />

### Zoekt: Git fetch durations

#### zoekt: 90th_percentile_successful_git_fetch_durations_5m

<p class="subtitle">90th percentile successful git fetch durations over 5m</p>

Long git fetch times can be a leading indicator of saturation.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le, name)(rate(index_fetch_seconds_bucket{success="true"}[5m])))`

</details>

<br />

#### zoekt: 90th_percentile_failed_git_fetch_durations_5m

<p class="subtitle">90th percentile failed git fetch durations over 5m</p>

Long git fetch times can be a leading indicator of saturation.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le, name)(rate(index_fetch_seconds_bucket{success="false"}[5m])))`

</details>

<br />

### Zoekt: Indexing results

#### zoekt: repo_index_state_aggregate

<p class="subtitle">Index results state count over 5m (aggregate)</p>

This dashboard shows the outcomes of recently completed indexing jobs across all index-server instances.

A persistent failing state indicates some repositories cannot be indexed, perhaps due to size and timeouts.

Legend:
- fail -> the indexing jobs failed
- success -> the indexing job succeeded and the index was updated
- success_meta -> the indexing job succeeded, but only metadata was updated
- noop -> the indexing job succeed, but we didn`t need to update anything
- empty -> the indexing job succeeded, but the index was empty (i.e. the repository is empty)

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (state) (increase(index_repo_seconds_count[5m]))`

</details>

<br />

#### zoekt: repo_index_state_per_instance

<p class="subtitle">Index results state count over 5m (per instance)</p>

This dashboard shows the outcomes of recently completed indexing jobs, split out across each index-server instance.

(You can use the "instance" filter at the top of the page to select a particular instance.)

A persistent failing state indicates some repositories cannot be indexed, perhaps due to size and timeouts.

Legend:
- fail -> the indexing jobs failed
- success -> the indexing job succeeded and the index was updated
- success_meta -> the indexing job succeeded, but only metadata was updated
- noop -> the indexing job succeed, but we didn`t need to update anything
- empty -> the indexing job succeeded, but the index was empty (i.e. the repository is empty)

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (instance, state) (increase(index_repo_seconds_count{instance=~`${instance:regex}`}[5m]))`

</details>

<br />

#### zoekt: repo_index_success_speed_heatmap

<p class="subtitle">Successful indexing durations</p>

Latency increases can indicate bottlenecks in the indexserver.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (le, state) (increase(index_repo_seconds_bucket{state="success"}[$__rate_interval]))`

</details>

<br />

#### zoekt: repo_index_fail_speed_heatmap

<p class="subtitle">Failed indexing durations</p>

Failures happening after a long time indicates timeouts.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (le, state) (increase(index_repo_seconds_bucket{state="fail"}[$__rate_interval]))`

</details>

<br />

#### zoekt: repo_index_success_speed_p99

<p class="subtitle">99th percentile successful indexing durations over 5m (aggregate)</p>

This dashboard shows the p99 duration of successful indexing jobs aggregated across all Zoekt instances.

Latency increases can indicate bottlenecks in the indexserver.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100320` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum by (le, name)(rate(index_repo_seconds_bucket{state="success"}[5m])))`

</details>

<br />

#### zoekt: repo_index_success_speed_p90

<p class="subtitle">90th percentile successful indexing durations over 5m (aggregate)</p>

This dashboard shows the p90 duration of successful indexing jobs aggregated across all Zoekt instances.

Latency increases can indicate bottlenecks in the indexserver.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100321` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le, name)(rate(index_repo_seconds_bucket{state="success"}[5m])))`

</details>

<br />

#### zoekt: repo_index_success_speed_p75

<p class="subtitle">75th percentile successful indexing durations over 5m (aggregate)</p>

This dashboard shows the p75 duration of successful indexing jobs aggregated across all Zoekt instances.

Latency increases can indicate bottlenecks in the indexserver.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100322` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.75, sum by (le, name)(rate(index_repo_seconds_bucket{state="success"}[5m])))`

</details>

<br />

#### zoekt: repo_index_success_speed_p99_per_instance

<p class="subtitle">99th percentile successful indexing durations over 5m (per instance)</p>

This dashboard shows the p99 duration of successful indexing jobs broken out per Zoekt instance.

Latency increases can indicate bottlenecks in the indexserver.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100330` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum by (le, instance)(rate(index_repo_seconds_bucket{state="success",instance=~`${instance:regex}`}[5m])))`

</details>

<br />

#### zoekt: repo_index_success_speed_p90_per_instance

<p class="subtitle">90th percentile successful indexing durations over 5m (per instance)</p>

This dashboard shows the p90 duration of successful indexing jobs broken out per Zoekt instance.

Latency increases can indicate bottlenecks in the indexserver.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100331` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le, instance)(rate(index_repo_seconds_bucket{state="success",instance=~`${instance:regex}`}[5m])))`

</details>

<br />

#### zoekt: repo_index_success_speed_p75_per_instance

<p class="subtitle">75th percentile successful indexing durations over 5m (per instance)</p>

This dashboard shows the p75 duration of successful indexing jobs broken out per Zoekt instance.

Latency increases can indicate bottlenecks in the indexserver.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100332` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.75, sum by (le, instance)(rate(index_repo_seconds_bucket{state="success",instance=~`${instance:regex}`}[5m])))`

</details>

<br />

#### zoekt: repo_index_failed_speed_p99

<p class="subtitle">99th percentile failed indexing durations over 5m (aggregate)</p>

This dashboard shows the p99 duration of failed indexing jobs aggregated across all Zoekt instances.

Failures happening after a long time indicates timeouts.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100340` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum by (le, name)(rate(index_repo_seconds_bucket{state="fail"}[5m])))`

</details>

<br />

#### zoekt: repo_index_failed_speed_p90

<p class="subtitle">90th percentile failed indexing durations over 5m (aggregate)</p>

This dashboard shows the p90 duration of failed indexing jobs aggregated across all Zoekt instances.

Failures happening after a long time indicates timeouts.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100341` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le, name)(rate(index_repo_seconds_bucket{state="fail"}[5m])))`

</details>

<br />

#### zoekt: repo_index_failed_speed_p75

<p class="subtitle">75th percentile failed indexing durations over 5m (aggregate)</p>

This dashboard shows the p75 duration of failed indexing jobs aggregated across all Zoekt instances.

Failures happening after a long time indicates timeouts.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100342` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.75, sum by (le, name)(rate(index_repo_seconds_bucket{state="fail"}[5m])))`

</details>

<br />

#### zoekt: repo_index_failed_speed_p99_per_instance

<p class="subtitle">99th percentile failed indexing durations over 5m (per instance)</p>

This dashboard shows the p99 duration of failed indexing jobs broken out per Zoekt instance.

Failures happening after a long time indicates timeouts.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100350` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum by (le, instance)(rate(index_repo_seconds_bucket{state="fail",instance=~`${instance:regex}`}[5m])))`

</details>

<br />

#### zoekt: repo_index_failed_speed_p90_per_instance

<p class="subtitle">90th percentile failed indexing durations over 5m (per instance)</p>

This dashboard shows the p90 duration of failed indexing jobs broken out per Zoekt instance.

Failures happening after a long time indicates timeouts.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100351` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le, instance)(rate(index_repo_seconds_bucket{state="fail",instance=~`${instance:regex}`}[5m])))`

</details>

<br />

#### zoekt: repo_index_failed_speed_p75_per_instance

<p class="subtitle">75th percentile failed indexing durations over 5m (per instance)</p>

This dashboard shows the p75 duration of failed indexing jobs broken out per Zoekt instance.

Failures happening after a long time indicates timeouts.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100352` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.75, sum by (le, instance)(rate(index_repo_seconds_bucket{state="fail",instance=~`${instance:regex}`}[5m])))`

</details>

<br />

### Zoekt: Indexing queue statistics

#### zoekt: indexed_num_scheduled_jobs_aggregate

<p class="subtitle"># scheduled index jobs (aggregate)</p>

A queue that is constantly growing could be a leading indicator of a bottleneck or under-provisioning

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(index_queue_len)`

</details>

<br />

#### zoekt: indexed_num_scheduled_jobs_per_instance

<p class="subtitle"># scheduled index jobs (per instance)</p>

A queue that is constantly growing could be a leading indicator of a bottleneck or under-provisioning

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `index_queue_len{instance=~`${instance:regex}`}`

</details>

<br />

#### zoekt: indexed_queueing_delay_heatmap

<p class="subtitle">Job queuing delay heatmap</p>

The queueing delay represents the amount of time an indexing job spent in the queue before it was processed.

Large queueing delays can be an indicator of:
	- resource saturation
	- each Zoekt replica has too many jobs for it to be able to process all of them promptly. In this scenario, consider adding additional Zoekt replicas to distribute the work better .

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (le) (increase(index_queue_age_seconds_bucket[$__rate_interval]))`

</details>

<br />

#### zoekt: indexed_queueing_delay_p99_9_aggregate

<p class="subtitle">99.9th percentile job queuing delay over 5m (aggregate)</p>

This dashboard shows the p99.9 job queueing delay aggregated across all Zoekt instances.

The queueing delay represents the amount of time an indexing job spent in the queue before it was processed.

Large queueing delays can be an indicator of:
	- resource saturation
	- each Zoekt replica has too many jobs for it to be able to process all of them promptly. In this scenario, consider adding additional Zoekt replicas to distribute the work better.

The 99.9 percentile dashboard is useful for capturing the long tail of queueing delays (on the order of 24+ hours, etc.).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100420` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.999, sum by (le, name)(rate(index_queue_age_seconds_bucket[5m])))`

</details>

<br />

#### zoekt: indexed_queueing_delay_p90_aggregate

<p class="subtitle">90th percentile job queueing delay over 5m (aggregate)</p>

This dashboard shows the p90 job queueing delay aggregated across all Zoekt instances.

The queueing delay represents the amount of time an indexing job spent in the queue before it was processed.

Large queueing delays can be an indicator of:
	- resource saturation
	- each Zoekt replica has too many jobs for it to be able to process all of them promptly. In this scenario, consider adding additional Zoekt replicas to distribute the work better.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100421` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le, name)(rate(index_queue_age_seconds_bucket[5m])))`

</details>

<br />

#### zoekt: indexed_queueing_delay_p75_aggregate

<p class="subtitle">75th percentile job queueing delay over 5m (aggregate)</p>

This dashboard shows the p75 job queueing delay aggregated across all Zoekt instances.

The queueing delay represents the amount of time an indexing job spent in the queue before it was processed.

Large queueing delays can be an indicator of:
	- resource saturation
	- each Zoekt replica has too many jobs for it to be able to process all of them promptly. In this scenario, consider adding additional Zoekt replicas to distribute the work better.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100422` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.75, sum by (le, name)(rate(index_queue_age_seconds_bucket[5m])))`

</details>

<br />

#### zoekt: indexed_queueing_delay_p99_9_per_instance

<p class="subtitle">99.9th percentile job queuing delay over 5m (per instance)</p>

This dashboard shows the p99.9 job queueing delay, broken out per Zoekt instance.

The queueing delay represents the amount of time an indexing job spent in the queue before it was processed.

Large queueing delays can be an indicator of:
	- resource saturation
	- each Zoekt replica has too many jobs for it to be able to process all of them promptly. In this scenario, consider adding additional Zoekt replicas to distribute the work better.

The 99.9 percentile dashboard is useful for capturing the long tail of queueing delays (on the order of 24+ hours, etc.).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100430` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.999, sum by (le, instance)(rate(index_queue_age_seconds_bucket{instance=~`${instance:regex}`}[5m])))`

</details>

<br />

#### zoekt: indexed_queueing_delay_p90_per_instance

<p class="subtitle">90th percentile job queueing delay over 5m (per instance)</p>

This dashboard shows the p90 job queueing delay, broken out per Zoekt instance.

The queueing delay represents the amount of time an indexing job spent in the queue before it was processed.

Large queueing delays can be an indicator of:
	- resource saturation
	- each Zoekt replica has too many jobs for it to be able to process all of them promptly. In this scenario, consider adding additional Zoekt replicas to distribute the work better.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100431` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.90, sum by (le, instance)(rate(index_queue_age_seconds_bucket{instance=~`${instance:regex}`}[5m])))`

</details>

<br />

#### zoekt: indexed_queueing_delay_p75_per_instance

<p class="subtitle">75th percentile job queueing delay over 5m (per instance)</p>

This dashboard shows the p75 job queueing delay, broken out per Zoekt instance.

The queueing delay represents the amount of time an indexing job spent in the queue before it was processed.

Large queueing delays can be an indicator of:
	- resource saturation
	- each Zoekt replica has too many jobs for it to be able to process all of them promptly. In this scenario, consider adding additional Zoekt replicas to distribute the work better.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100432` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.75, sum by (le, instance)(rate(index_queue_age_seconds_bucket{instance=~`${instance:regex}`}[5m])))`

</details>

<br />

### Zoekt: Virtual Memory Statistics

#### zoekt: memory_map_areas_percentage_used

<p class="subtitle">Process memory map areas percentage used (per instance)</p>

Processes have a limited about of memory map areas that they can use. In Zoekt, memory map areas
are mainly used for loading shards into memory for queries (via mmap). However, memory map areas
are also used for loading shared libraries, etc.

_See https://en.wikipedia.org/wiki/Memory-mapped_file and the related articles for more information about memory maps._

Once the memory map limit is reached, the Linux kernel will prevent the process from creating any
additional memory map areas. This could cause the process to crash.

Refer to the [alerts reference](./alerts.md#zoekt-memory-map-areas-percentage-used) for 2 alerts related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `(proc_metrics_memory_map_current_count{instance=~`${instance:regex}`} / proc_metrics_memory_map_max_limit{instance=~`${instance:regex}`}) * 100`

</details>

<br />

### Zoekt: Compound shards (experimental)

#### zoekt: compound_shards_aggregate

<p class="subtitle"># of compound shards (aggregate)</p>

The total number of compound shards aggregated over all instances.

This number should be consistent if the number of indexed repositories doesn`t change.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(index_number_compound_shards) by (app)`

</details>

<br />

#### zoekt: compound_shards_per_instance

<p class="subtitle"># of compound shards (per instance)</p>

The total number of compound shards per instance.

This number should be consistent if the number of indexed repositories doesn`t change.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(index_number_compound_shards{instance=~`${instance:regex}`}) by (instance)`

</details>

<br />

#### zoekt: average_shard_merging_duration_success

<p class="subtitle">Average successful shard merging duration over 1 hour</p>

Average duration of a successful merge over the last hour.

The duration depends on the target compound shard size. The larger the compound shard the longer a merge will take.
Since the target compound shard size is set on start of zoekt-indexserver, the average duration should be consistent.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100610` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(index_shard_merging_duration_seconds_sum{error="false"}[1h])) / sum(rate(index_shard_merging_duration_seconds_count{error="false"}[1h]))`

</details>

<br />

#### zoekt: average_shard_merging_duration_error

<p class="subtitle">Average failed shard merging duration over 1 hour</p>

Average duration of a failed merge over the last hour.

This curve should be flat. Any deviation should be investigated.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100611` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(index_shard_merging_duration_seconds_sum{error="true"}[1h])) / sum(rate(index_shard_merging_duration_seconds_count{error="true"}[1h]))`

</details>

<br />

#### zoekt: shard_merging_errors_aggregate

<p class="subtitle">Number of errors during shard merging (aggregate)</p>

Number of errors during shard merging aggregated over all instances.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100620` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(index_shard_merging_duration_seconds_count{error="true"}) by (app)`

</details>

<br />

#### zoekt: shard_merging_errors_per_instance

<p class="subtitle">Number of errors during shard merging (per instance)</p>

Number of errors during shard merging per instance.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100621` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(index_shard_merging_duration_seconds_count{instance=~`${instance:regex}`, error="true"}) by (instance)`

</details>

<br />

#### zoekt: shard_merging_merge_running_per_instance

<p class="subtitle">If shard merging is running (per instance)</p>

Set to 1 if shard merging is running.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100630` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (instance) (index_shard_merging_running{instance=~`${instance:regex}`})`

</details>

<br />

#### zoekt: shard_merging_vacuum_running_per_instance

<p class="subtitle">If vacuum is running (per instance)</p>

Set to 1 if vacuum is running.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100631` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (instance) (index_vacuum_running{instance=~`${instance:regex}`})`

</details>

<br />

### Zoekt: Network I/O pod metrics (only available on Kubernetes)

#### zoekt: network_sent_bytes_aggregate

<p class="subtitle">Transmission rate over 5m (aggregate)</p>

The rate of bytes sent over the network across all Zoekt pods

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100700` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(container_network_transmit_bytes_total{container_label_io_kubernetes_pod_name=~`.*indexed-search.*`}[5m]))`

</details>

<br />

#### zoekt: network_received_packets_per_instance

<p class="subtitle">Transmission rate over 5m (per instance)</p>

The amount of bytes sent over the network by individual Zoekt pods

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100701` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (rate(container_network_transmit_bytes_total{container_label_io_kubernetes_pod_name=~`${instance:regex}`}[5m]))`

</details>

<br />

#### zoekt: network_received_bytes_aggregate

<p class="subtitle">Receive rate over 5m (aggregate)</p>

The amount of bytes received from the network across Zoekt pods

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100710` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(rate(container_network_receive_bytes_total{container_label_io_kubernetes_pod_name=~`.*indexed-search.*`}[5m]))`

</details>

<br />

#### zoekt: network_received_bytes_per_instance

<p class="subtitle">Receive rate over 5m (per instance)</p>

The amount of bytes received from the network by individual Zoekt pods

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100711` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (rate(container_network_receive_bytes_total{container_label_io_kubernetes_pod_name=~`${instance:regex}`}[5m]))`

</details>

<br />

#### zoekt: network_transmitted_packets_dropped_by_instance

<p class="subtitle">Transmit packet drop rate over 5m (by instance)</p>

An increase in dropped packets could be a leading indicator of network saturation.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100720` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (rate(container_network_transmit_packets_dropped_total{container_label_io_kubernetes_pod_name=~`${instance:regex}`}[5m]))`

</details>

<br />

#### zoekt: network_transmitted_packets_errors_per_instance

<p class="subtitle">Errors encountered while transmitting over 5m (per instance)</p>

An increase in transmission errors could indicate a networking issue

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100721` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (rate(container_network_transmit_errors_total{container_label_io_kubernetes_pod_name=~`${instance:regex}`}[5m]))`

</details>

<br />

#### zoekt: network_received_packets_dropped_by_instance

<p class="subtitle">Receive packet drop rate over 5m (by instance)</p>

An increase in dropped packets could be a leading indicator of network saturation.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100722` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (rate(container_network_receive_packets_dropped_total{container_label_io_kubernetes_pod_name=~`${instance:regex}`}[5m]))`

</details>

<br />

#### zoekt: network_transmitted_packets_errors_by_instance

<p class="subtitle">Errors encountered while receiving over 5m (per instance)</p>

An increase in errors while receiving could indicate a networking issue.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100723` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (container_label_io_kubernetes_pod_name) (rate(container_network_receive_errors_total{container_label_io_kubernetes_pod_name=~`${instance:regex}`}[5m]))`

</details>

<br />

### Zoekt: [zoekt-indexserver] Container monitoring (not available on server)

#### zoekt: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod zoekt-indexserver` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p zoekt-indexserver`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' zoekt-indexserver` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the zoekt-indexserver container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs zoekt-indexserver` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100800` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^zoekt-indexserver.*"}) > 60)`

</details>

<br />

#### zoekt: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100801` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^zoekt-indexserver.*"}`

</details>

<br />

#### zoekt: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100802` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^zoekt-indexserver.*"}`

</details>

<br />

#### zoekt: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100803` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^zoekt-indexserver.*"}[1h]) + rate(container_fs_writes_total{name=~"^zoekt-indexserver.*"}[1h]))`

</details>

<br />

### Zoekt: [zoekt-webserver] Container monitoring (not available on server)

#### zoekt: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod zoekt-webserver` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p zoekt-webserver`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' zoekt-webserver` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the zoekt-webserver container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs zoekt-webserver` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^zoekt-webserver.*"}) > 60)`

</details>

<br />

#### zoekt: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100901` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^zoekt-webserver.*"}`

</details>

<br />

#### zoekt: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100902` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^zoekt-webserver.*"}`

</details>

<br />

#### zoekt: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=100903` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^zoekt-webserver.*"}[1h]) + rate(container_fs_writes_total{name=~"^zoekt-webserver.*"}[1h]))`

</details>

<br />

### Zoekt: [zoekt-indexserver] Provisioning indicators (not available on server)

#### zoekt: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=101000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^zoekt-indexserver.*"}[1d])`

</details>

<br />

#### zoekt: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=101001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^zoekt-indexserver.*"}[1d])`

</details>

<br />

#### zoekt: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=101010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^zoekt-indexserver.*"}[5m])`

</details>

<br />

#### zoekt: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=101011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^zoekt-indexserver.*"}[5m])`

</details>

<br />

#### zoekt: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#zoekt-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=101012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^zoekt-indexserver.*"})`

</details>

<br />

### Zoekt: [zoekt-webserver] Provisioning indicators (not available on server)

#### zoekt: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=101100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^zoekt-webserver.*"}[1d])`

</details>

<br />

#### zoekt: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=101101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^zoekt-webserver.*"}[1d])`

</details>

<br />

#### zoekt: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=101110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^zoekt-webserver.*"}[5m])`

</details>

<br />

#### zoekt: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#zoekt-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=101111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^zoekt-webserver.*"}[5m])`

</details>

<br />

#### zoekt: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#zoekt-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=101112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^zoekt-webserver.*"})`

</details>

<br />

### Zoekt: Kubernetes monitoring (only available on Kubernetes)

#### zoekt: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#zoekt-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/zoekt/zoekt?viewPanel=101200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Search Core team](https://handbook.sourcegraph.com/departments/engineering/teams/search/core).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*indexed-search"}) / count by (app) (up{app=~".*indexed-search"}) * 100`

</details>

<br />

## Prometheus

<p class="subtitle">Sourcegraph's all-in-one Prometheus and Alertmanager service.</p>

To see this dashboard, visit `/-/debug/grafana/d/prometheus/prometheus` on your Sourcegraph instance.

### Prometheus: Metrics

#### prometheus: prometheus_rule_eval_duration

<p class="subtitle">Average prometheus rule group evaluation duration over 10m by rule group</p>

A high value here indicates Prometheus rule evaluation is taking longer than expected.
It might indicate that certain rule groups are taking too long to evaluate, or Prometheus is underprovisioned.

Rules that Sourcegraph ships with are grouped under `/sg_config_prometheus`. [Custom rules are grouped under `/sg_prometheus_addons`](https://docs.sourcegraph.com/admin/observability/metrics#prometheus-configuration).

Refer to the [alerts reference](./alerts.md#prometheus-prometheus-rule-eval-duration) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(rule_group) (avg_over_time(prometheus_rule_group_last_duration_seconds[10m]))`

</details>

<br />

#### prometheus: prometheus_rule_eval_failures

<p class="subtitle">Failed prometheus rule evaluations over 5m by rule group</p>

Rules that Sourcegraph ships with are grouped under `/sg_config_prometheus`. [Custom rules are grouped under `/sg_prometheus_addons`](https://docs.sourcegraph.com/admin/observability/metrics#prometheus-configuration).

Refer to the [alerts reference](./alerts.md#prometheus-prometheus-rule-eval-failures) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(rule_group) (rate(prometheus_rule_evaluation_failures_total[5m]))`

</details>

<br />

### Prometheus: Alerts

#### prometheus: alertmanager_notification_latency

<p class="subtitle">Alertmanager notification latency over 1m by integration</p>

Refer to the [alerts reference](./alerts.md#prometheus-alertmanager-notification-latency) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(integration) (rate(alertmanager_notification_latency_seconds_sum[1m]))`

</details>

<br />

#### prometheus: alertmanager_notification_failures

<p class="subtitle">Failed alertmanager notifications over 1m by integration</p>

Refer to the [alerts reference](./alerts.md#prometheus-alertmanager-notification-failures) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(integration) (rate(alertmanager_notifications_failed_total[1m]))`

</details>

<br />

### Prometheus: Internals

#### prometheus: prometheus_config_status

<p class="subtitle">Prometheus configuration reload status</p>

A `1` indicates Prometheus reloaded its configuration successfully.

Refer to the [alerts reference](./alerts.md#prometheus-prometheus-config-status) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `prometheus_config_last_reload_successful`

</details>

<br />

#### prometheus: alertmanager_config_status

<p class="subtitle">Alertmanager configuration reload status</p>

A `1` indicates Alertmanager reloaded its configuration successfully.

Refer to the [alerts reference](./alerts.md#prometheus-alertmanager-config-status) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `alertmanager_config_last_reload_successful`

</details>

<br />

#### prometheus: prometheus_tsdb_op_failure

<p class="subtitle">Prometheus tsdb failures by operation over 1m by operation</p>

Refer to the [alerts reference](./alerts.md#prometheus-prometheus-tsdb-op-failure) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `increase(label_replace({__name__=~"prometheus_tsdb_(.*)_failed_total"}, "operation", "$1", "__name__", "(.+)s_failed_total")[5m:1m])`

</details>

<br />

#### prometheus: prometheus_target_sample_exceeded

<p class="subtitle">Prometheus scrapes that exceed the sample limit over 10m</p>

Refer to the [alerts reference](./alerts.md#prometheus-prometheus-target-sample-exceeded) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `increase(prometheus_target_scrapes_exceeded_sample_limit_total[10m])`

</details>

<br />

#### prometheus: prometheus_target_sample_duplicate

<p class="subtitle">Prometheus scrapes rejected due to duplicate timestamps over 10m</p>

Refer to the [alerts reference](./alerts.md#prometheus-prometheus-target-sample-duplicate) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `increase(prometheus_target_scrapes_sample_duplicate_timestamp_total[10m])`

</details>

<br />

### Prometheus: Container monitoring (not available on server)

#### prometheus: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

- **Kubernetes:**
	- Determine if the pod was OOM killed using `kubectl describe pod prometheus` (look for `OOMKilled: true`) and, if so, consider increasing the memory limit in the relevant `Deployment.yaml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `kubectl logs -p prometheus`.
- **Docker Compose:**
	- Determine if the pod was OOM killed using `docker inspect -f '{{json .State}}' prometheus` (look for `"OOMKilled":true`) and, if so, consider increasing the memory limit of the prometheus container in `docker-compose.yml`.
	- Check the logs before the container restarted to see if there are `panic:` messages or similar using `docker logs prometheus` (note this will include logs from the previous and currently running container).

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^prometheus.*"}) > 60)`

</details>

<br />

#### prometheus: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#prometheus-container-cpu-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^prometheus.*"}`

</details>

<br />

#### prometheus: container_memory_usage

<p class="subtitle">Container memory usage by instance</p>

Refer to the [alerts reference](./alerts.md#prometheus-container-memory-usage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^prometheus.*"}`

</details>

<br />

#### prometheus: fs_io_operations

<p class="subtitle">Filesystem reads and writes rate by instance over 1h</p>

This value indicates the number of filesystem read and write operations by containers of this service.
When extremely high, this can indicate a resource usage problem, or can cause problems with the service itself, especially if high values or spikes correlate with {{CONTAINER_NAME}} issues.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(name) (rate(container_fs_reads_total{name=~"^prometheus.*"}[1h]) + rate(container_fs_writes_total{name=~"^prometheus.*"}[1h]))`

</details>

<br />

### Prometheus: Provisioning indicators (not available on server)

#### prometheus: provisioning_container_cpu_usage_long_term

<p class="subtitle">Container cpu usage total (90th percentile over 1d) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#prometheus-provisioning-container-cpu-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `quantile_over_time(0.9, cadvisor_container_cpu_usage_percentage_total{name=~"^prometheus.*"}[1d])`

</details>

<br />

#### prometheus: provisioning_container_memory_usage_long_term

<p class="subtitle">Container memory usage (1d maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#prometheus-provisioning-container-memory-usage-long-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^prometheus.*"}[1d])`

</details>

<br />

#### prometheus: provisioning_container_cpu_usage_short_term

<p class="subtitle">Container cpu usage total (5m maximum) across all cores by instance</p>

Refer to the [alerts reference](./alerts.md#prometheus-provisioning-container-cpu-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^prometheus.*"}[5m])`

</details>

<br />

#### prometheus: provisioning_container_memory_usage_short_term

<p class="subtitle">Container memory usage (5m maximum) by instance</p>

Refer to the [alerts reference](./alerts.md#prometheus-provisioning-container-memory-usage-short-term) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100411` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^prometheus.*"}[5m])`

</details>

<br />

#### prometheus: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total by instance</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

Refer to the [alerts reference](./alerts.md#prometheus-container-oomkill-events-total) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100412` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^prometheus.*"})`

</details>

<br />

### Prometheus: Kubernetes monitoring (only available on Kubernetes)

#### prometheus: pods_available_percentage

<p class="subtitle">Percentage pods available</p>

Refer to the [alerts reference](./alerts.md#prometheus-pods-available-percentage) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/prometheus/prometheus?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by(app) (up{app=~".*prometheus"}) / count by (app) (up{app=~".*prometheus"}) * 100`

</details>

<br />

## Executor

<p class="subtitle">Executes jobs in an isolated environment.</p>

To see this dashboard, visit `/-/debug/grafana/d/executor/executor` on your Sourcegraph instance.

### Executor: Executor: Executor jobs

#### executor: executor_queue_size

<p class="subtitle">Unprocessed executor job queue size</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (queue)(src_executor_total{queue=~"$queue",job=~"^(executor|sourcegraph-code-intel-indexers|executor-batches|frontend|sourcegraph-frontend|worker|sourcegraph-executors).*"})`

</details>

<br />

#### executor: executor_queue_growth_rate

<p class="subtitle">Unprocessed executor job queue growth rate over 30m</p>

This value compares the rate of enqueues against the rate of finished jobs for the selected queue.

	- A value < than 1 indicates that process rate > enqueue rate
	- A value = than 1 indicates that process rate = enqueue rate
	- A value > than 1 indicates that process rate < enqueue rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (queue)(increase(src_executor_total{queue=~"$queue",job=~"^(executor|sourcegraph-code-intel-indexers|executor-batches|frontend|sourcegraph-frontend|worker|sourcegraph-executors).*"}[30m])) / sum by (queue)(increase(src_executor_processor_total{queue=~"$queue",job=~"^(executor|sourcegraph-code-intel-indexers|executor-batches|frontend|sourcegraph-frontend|worker|sourcegraph-executors).*"}[30m]))`

</details>

<br />

#### executor: executor_queued_max_age

<p class="subtitle">Unprocessed executor job queue longest time in queue</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (queue)(src_executor_queued_duration_seconds_total{queue=~"$queue",job=~"^(executor|sourcegraph-code-intel-indexers|executor-batches|frontend|sourcegraph-frontend|worker|sourcegraph-executors).*"})`

</details>

<br />

### Executor: Executor: Executor jobs

#### executor: executor_handlers

<p class="subtitle">Executor active handlers</p>

Refer to the [alerts reference](./alerts.md#executor-executor-handlers) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(src_executor_processor_handlers{queue=~"${queue:regex}",sg_job=~"^sourcegraph-executors.*"})`

</details>

<br />

#### executor: executor_processor_total

<p class="subtitle">Executor operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_executor_processor_total{queue=~"${queue:regex}",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: executor_processor_99th_percentile_duration

<p class="subtitle">Aggregate successful executor operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_executor_processor_duration_seconds_bucket{queue=~"${queue:regex}",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: executor_processor_errors_total

<p class="subtitle">Executor operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_executor_processor_errors_total{queue=~"${queue:regex}",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: executor_processor_error_rate

<p class="subtitle">Executor operation error rate over 5m</p>

Refer to the [alerts reference](./alerts.md#executor-executor-processor-error-rate) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100113` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_executor_processor_errors_total{queue=~"${queue:regex}",sg_job=~"^sourcegraph-executors.*"}[5m])) / (sum(increase(src_executor_processor_total{queue=~"${queue:regex}",sg_job=~"^sourcegraph-executors.*"}[5m])) + sum(increase(src_executor_processor_errors_total{queue=~"${queue:regex}",sg_job=~"^sourcegraph-executors.*"}[5m]))) * 100`

</details>

<br />

### Executor: Executor: Queue API client

#### executor: apiworker_apiclient_queue_total

<p class="subtitle">Aggregate client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_apiclient_queue_total{sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_apiclient_queue_99th_percentile_duration

<p class="subtitle">Aggregate successful client operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_apiworker_apiclient_queue_duration_seconds_bucket{sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_apiclient_queue_errors_total

<p class="subtitle">Aggregate client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_apiclient_queue_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_apiclient_queue_error_rate

<p class="subtitle">Aggregate client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100203` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_apiclient_queue_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m])) / (sum(increase(src_apiworker_apiclient_queue_total{sg_job=~"^sourcegraph-executors.*"}[5m])) + sum(increase(src_apiworker_apiclient_queue_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m]))) * 100`

</details>

<br />

#### executor: apiworker_apiclient_queue_total

<p class="subtitle">Client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_apiclient_queue_total{sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_apiclient_queue_99th_percentile_duration

<p class="subtitle">99th percentile successful client operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_apiworker_apiclient_queue_duration_seconds_bucket{sg_job=~"^sourcegraph-executors.*"}[5m])))`

</details>

<br />

#### executor: apiworker_apiclient_queue_errors_total

<p class="subtitle">Client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_apiclient_queue_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_apiclient_queue_error_rate

<p class="subtitle">Client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100213` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_apiclient_queue_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m])) / (sum by (op)(increase(src_apiworker_apiclient_queue_total{sg_job=~"^sourcegraph-executors.*"}[5m])) + sum by (op)(increase(src_apiworker_apiclient_queue_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m]))) * 100`

</details>

<br />

### Executor: Executor: Files API client

#### executor: apiworker_apiclient_files_total

<p class="subtitle">Aggregate client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_apiclient_files_total{sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_apiclient_files_99th_percentile_duration

<p class="subtitle">Aggregate successful client operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_apiworker_apiclient_files_duration_seconds_bucket{sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_apiclient_files_errors_total

<p class="subtitle">Aggregate client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_apiclient_files_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_apiclient_files_error_rate

<p class="subtitle">Aggregate client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_apiclient_files_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m])) / (sum(increase(src_apiworker_apiclient_files_total{sg_job=~"^sourcegraph-executors.*"}[5m])) + sum(increase(src_apiworker_apiclient_files_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m]))) * 100`

</details>

<br />

#### executor: apiworker_apiclient_files_total

<p class="subtitle">Client operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_apiclient_files_total{sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_apiclient_files_99th_percentile_duration

<p class="subtitle">99th percentile successful client operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_apiworker_apiclient_files_duration_seconds_bucket{sg_job=~"^sourcegraph-executors.*"}[5m])))`

</details>

<br />

#### executor: apiworker_apiclient_files_errors_total

<p class="subtitle">Client operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_apiclient_files_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_apiclient_files_error_rate

<p class="subtitle">Client operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100313` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_apiclient_files_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m])) / (sum by (op)(increase(src_apiworker_apiclient_files_total{sg_job=~"^sourcegraph-executors.*"}[5m])) + sum by (op)(increase(src_apiworker_apiclient_files_errors_total{sg_job=~"^sourcegraph-executors.*"}[5m]))) * 100`

</details>

<br />

### Executor: Executor: Job setup

#### executor: apiworker_command_total

<p class="subtitle">Aggregate command operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_command_total{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_99th_percentile_duration

<p class="subtitle">Aggregate successful command operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_apiworker_command_duration_seconds_bucket{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_errors_total

<p class="subtitle">Aggregate command operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_command_errors_total{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_error_rate

<p class="subtitle">Aggregate command operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100403` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_command_errors_total{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m])) / (sum(increase(src_apiworker_command_total{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m])) + sum(increase(src_apiworker_command_errors_total{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m]))) * 100`

</details>

<br />

#### executor: apiworker_command_total

<p class="subtitle">Command operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_command_total{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_99th_percentile_duration

<p class="subtitle">99th percentile successful command operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100411` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_apiworker_command_duration_seconds_bucket{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m])))`

</details>

<br />

#### executor: apiworker_command_errors_total

<p class="subtitle">Command operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100412` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_command_errors_total{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_error_rate

<p class="subtitle">Command operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100413` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_command_errors_total{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m])) / (sum by (op)(increase(src_apiworker_command_total{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m])) + sum by (op)(increase(src_apiworker_command_errors_total{op=~"setup.*",sg_job=~"^sourcegraph-executors.*"}[5m]))) * 100`

</details>

<br />

### Executor: Executor: Job execution

#### executor: apiworker_command_total

<p class="subtitle">Aggregate command operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_command_total{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_99th_percentile_duration

<p class="subtitle">Aggregate successful command operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_apiworker_command_duration_seconds_bucket{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_errors_total

<p class="subtitle">Aggregate command operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100502` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_command_errors_total{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_error_rate

<p class="subtitle">Aggregate command operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100503` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_command_errors_total{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m])) / (sum(increase(src_apiworker_command_total{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m])) + sum(increase(src_apiworker_command_errors_total{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m]))) * 100`

</details>

<br />

#### executor: apiworker_command_total

<p class="subtitle">Command operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100510` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_command_total{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_99th_percentile_duration

<p class="subtitle">99th percentile successful command operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100511` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_apiworker_command_duration_seconds_bucket{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m])))`

</details>

<br />

#### executor: apiworker_command_errors_total

<p class="subtitle">Command operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100512` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_command_errors_total{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_error_rate

<p class="subtitle">Command operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100513` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_command_errors_total{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m])) / (sum by (op)(increase(src_apiworker_command_total{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m])) + sum by (op)(increase(src_apiworker_command_errors_total{op=~"exec.*",sg_job=~"^sourcegraph-executors.*"}[5m]))) * 100`

</details>

<br />

### Executor: Executor: Job teardown

#### executor: apiworker_command_total

<p class="subtitle">Aggregate command operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_command_total{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_99th_percentile_duration

<p class="subtitle">Aggregate successful command operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_apiworker_command_duration_seconds_bucket{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_errors_total

<p class="subtitle">Aggregate command operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100602` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_command_errors_total{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_error_rate

<p class="subtitle">Aggregate command operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100603` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_apiworker_command_errors_total{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m])) / (sum(increase(src_apiworker_command_total{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m])) + sum(increase(src_apiworker_command_errors_total{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m]))) * 100`

</details>

<br />

#### executor: apiworker_command_total

<p class="subtitle">Command operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100610` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_command_total{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_99th_percentile_duration

<p class="subtitle">99th percentile successful command operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100611` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_apiworker_command_duration_seconds_bucket{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m])))`

</details>

<br />

#### executor: apiworker_command_errors_total

<p class="subtitle">Command operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100612` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_command_errors_total{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m]))`

</details>

<br />

#### executor: apiworker_command_error_rate

<p class="subtitle">Command operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100613` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_apiworker_command_errors_total{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m])) / (sum by (op)(increase(src_apiworker_command_total{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m])) + sum by (op)(increase(src_apiworker_command_errors_total{op=~"teardown.*",sg_job=~"^sourcegraph-executors.*"}[5m]))) * 100`

</details>

<br />

### Executor: Executor: Compute instance metrics

#### executor: node_cpu_utilization

<p class="subtitle">CPU utilization (minus idle/iowait)</p>

Indicates the amount of CPU time excluding idle and iowait time, divided by the number of cores, as a percentage.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100700` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_cpu_seconds_total{sg_job=~"sourcegraph-executors",mode!~"(idle|iowait)",sg_instance=~"$instance"}[$__rate_interval])) by(sg_instance) / count(node_cpu_seconds_total{sg_job=~"sourcegraph-executors",mode="system",sg_instance=~"$instance"}) by (sg_instance) * 100`

</details>

<br />

#### executor: node_cpu_saturation_cpu_wait

<p class="subtitle">CPU saturation (time waiting)</p>

Indicates the average summed time a number of (but strictly not all) non-idle processes spent waiting for CPU time. If this is higher than normal, then the CPU is underpowered for the workload and more powerful machines should be provisioned. This only represents a "less-than-all processes" time, because for processes to be waiting for CPU time there must be other process(es) consuming CPU time.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100701` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `rate(node_pressure_cpu_waiting_seconds_total{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval])`

</details>

<br />

#### executor: node_memory_utilization

<p class="subtitle">Memory utilization</p>

Indicates the amount of available memory (including cache and buffers) as a percentage. Consistently high numbers are generally fine so long memory saturation figures are within acceptable ranges, these figures may be more useful for informing executor provisioning decisions, such as increasing worker parallelism, down-sizing machines etc.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100710` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `(1 - sum(node_memory_MemAvailable_bytes{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}) by (sg_instance) / sum(node_memory_MemTotal_bytes{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}) by (sg_instance)) * 100`

</details>

<br />

#### executor: node_memory_saturation_vmeff

<p class="subtitle">Memory saturation (vmem efficiency)</p>

Indicates the efficiency of page reclaim, calculated as pgsteal/pgscan. Optimal figures are short spikes of near 100% and above, indicating that a high ratio of scanned pages are actually being freed, or exactly 0%, indicating that pages arent being scanned as there is no memory pressure. Sustained numbers >~100% may be sign of imminent memory exhaustion, while sustained 0% < x < ~100% figures are very serious.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100711` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `(rate(node_vmstat_pgsteal_anon{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval]) + rate(node_vmstat_pgsteal_direct{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval]) + rate(node_vmstat_pgsteal_file{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval]) + rate(node_vmstat_pgsteal_kswapd{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval])) / (rate(node_vmstat_pgscan_anon{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval]) + rate(node_vmstat_pgscan_direct{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval]) + rate(node_vmstat_pgscan_file{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval]) + rate(node_vmstat_pgscan_kswapd{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval])) * 100`

</details>

<br />

#### executor: node_memory_saturation_pressure_stalled

<p class="subtitle">Memory saturation (fully stalled)</p>

Indicates the amount of time all non-idle processes were stalled waiting on memory operations to complete. This is often correlated with vmem efficiency ratio when pressure on available memory is high. If they`re not correlated, this could indicate issues with the machine hardware and/or configuration.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100712` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `rate(node_pressure_memory_stalled_seconds_total{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval])`

</details>

<br />

#### executor: node_io_disk_utilization

<p class="subtitle">Disk IO utilization (percentage time spent in IO)</p>

Indicates the percentage of time a disk was busy. If this is less than 100%, then the disk has spare utilization capacity. However, a value of 100% does not necesarily indicate the disk is at max capacity. For single, serial request-serving devices, 100% may indicate maximum saturation, but for SSDs and RAID arrays this is less likely to be the case, as they are capable of serving multiple requests in parallel, other metrics such as throughput and request queue size should be factored in.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100720` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(label_replace(label_replace(rate(node_disk_io_time_seconds_total{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval]), "disk", "$1", "device", "^([^d].+)"), "disk", "ignite", "device", "dm-.*")) by(sg_instance,disk) * 100`

</details>

<br />

#### executor: node_io_disk_saturation

<p class="subtitle">Disk IO saturation (avg IO queue size)</p>

Indicates the number of outstanding/queued IO requests. High but short-lived queue sizes may not present an issue, but if theyre consistently/often high and/or monotonically increasing, the disk may be failing or simply too slow for the amount of activity required. Consider replacing the drive(s) with SSDs if they are not already and/or replacing the faulty drive(s), if any.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100721` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(label_replace(label_replace(rate(node_disk_io_time_weighted_seconds_total{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval]), "disk", "$1", "device", "^([^d].+)"), "disk", "ignite", "device", "dm-.*")) by(sg_instance,disk)`

</details>

<br />

#### executor: node_io_disk_saturation_pressure_full

<p class="subtitle">Disk IO saturation (avg time of all processes stalled)</p>

Indicates the averaged amount of time for which all non-idle processes were stalled waiting for IO to complete simultaneously aka where no processes could make progress.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100722` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `rate(node_pressure_io_stalled_seconds_total{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval])`

</details>

<br />

#### executor: node_io_network_utilization

<p class="subtitle">Network IO utilization (Rx)</p>

Indicates the average summed receiving throughput of all network interfaces. This is often predominantly composed of the WAN/internet-connected interface, and knowing normal/good figures depends on knowing the bandwidth of the underlying hardware and the workloads.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100730` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_receive_bytes_total{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval])) by(sg_instance) * 8`

</details>

<br />

#### executor: node_io_network_saturation

<p class="subtitle">Network IO saturation (Rx packets dropped)</p>

Number of dropped received packets. This can happen if the receive queues/buffers become full due to slow packet processing throughput. The queues/buffers could be configured to be larger as a stop-gap but the processing application should be investigated as soon as possible. https://www.kernel.org/doc/html/latest/networking/statistics.html#:~:text=not%20otherwise%20counted.-,rx_dropped,-Number%20of%20packets

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100731` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_receive_drop_total{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval])) by(sg_instance)`

</details>

<br />

#### executor: node_io_network_saturation

<p class="subtitle">Network IO errors (Rx)</p>

Number of bad/malformed packets received. https://www.kernel.org/doc/html/latest/networking/statistics.html#:~:text=excluding%20the%20FCS.-,rx_errors,-Total%20number%20of

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100732` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_receive_errs_total{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval])) by(sg_instance)`

</details>

<br />

#### executor: node_io_network_utilization

<p class="subtitle">Network IO utilization (Tx)</p>

Indicates the average summed transmitted throughput of all network interfaces. This is often predominantly composed of the WAN/internet-connected interface, and knowing normal/good figures depends on knowing the bandwidth of the underlying hardware and the workloads.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100740` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_transmit_bytes_total{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval])) by(sg_instance) * 8`

</details>

<br />

#### executor: node_io_network_saturation

<p class="subtitle">Network IO saturation (Tx packets dropped)</p>

Number of dropped transmitted packets. This can happen if the receiving side`s receive queues/buffers become full due to slow packet processing throughput, the network link is congested etc.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100741` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_transmit_drop_total{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval])) by(sg_instance)`

</details>

<br />

#### executor: node_io_network_saturation

<p class="subtitle">Network IO errors (Tx)</p>

Number of packet transmission errors. This is distinct from tx packet dropping, and can indicate a failing NIC, improperly configured network options anywhere along the line, signal noise etc.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100742` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_transmit_errs_total{sg_job=~"sourcegraph-executors",sg_instance=~"$instance"}[$__rate_interval])) by(sg_instance)`

</details>

<br />

### Executor: Executor: Docker Registry Mirror instance metrics

#### executor: node_cpu_utilization

<p class="subtitle">CPU utilization (minus idle/iowait)</p>

Indicates the amount of CPU time excluding idle and iowait time, divided by the number of cores, as a percentage.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100800` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_cpu_seconds_total{sg_job=~"sourcegraph-executors-registry",mode!~"(idle|iowait)",sg_instance=~"docker-registry"}[$__rate_interval])) by(sg_instance) / count(node_cpu_seconds_total{sg_job=~"sourcegraph-executors-registry",mode="system",sg_instance=~"docker-registry"}) by (sg_instance) * 100`

</details>

<br />

#### executor: node_cpu_saturation_cpu_wait

<p class="subtitle">CPU saturation (time waiting)</p>

Indicates the average summed time a number of (but strictly not all) non-idle processes spent waiting for CPU time. If this is higher than normal, then the CPU is underpowered for the workload and more powerful machines should be provisioned. This only represents a "less-than-all processes" time, because for processes to be waiting for CPU time there must be other process(es) consuming CPU time.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100801` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `rate(node_pressure_cpu_waiting_seconds_total{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval])`

</details>

<br />

#### executor: node_memory_utilization

<p class="subtitle">Memory utilization</p>

Indicates the amount of available memory (including cache and buffers) as a percentage. Consistently high numbers are generally fine so long memory saturation figures are within acceptable ranges, these figures may be more useful for informing executor provisioning decisions, such as increasing worker parallelism, down-sizing machines etc.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100810` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `(1 - sum(node_memory_MemAvailable_bytes{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}) by (sg_instance) / sum(node_memory_MemTotal_bytes{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}) by (sg_instance)) * 100`

</details>

<br />

#### executor: node_memory_saturation_vmeff

<p class="subtitle">Memory saturation (vmem efficiency)</p>

Indicates the efficiency of page reclaim, calculated as pgsteal/pgscan. Optimal figures are short spikes of near 100% and above, indicating that a high ratio of scanned pages are actually being freed, or exactly 0%, indicating that pages arent being scanned as there is no memory pressure. Sustained numbers >~100% may be sign of imminent memory exhaustion, while sustained 0% < x < ~100% figures are very serious.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100811` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `(rate(node_vmstat_pgsteal_anon{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval]) + rate(node_vmstat_pgsteal_direct{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval]) + rate(node_vmstat_pgsteal_file{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval]) + rate(node_vmstat_pgsteal_kswapd{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval])) / (rate(node_vmstat_pgscan_anon{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval]) + rate(node_vmstat_pgscan_direct{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval]) + rate(node_vmstat_pgscan_file{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval]) + rate(node_vmstat_pgscan_kswapd{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval])) * 100`

</details>

<br />

#### executor: node_memory_saturation_pressure_stalled

<p class="subtitle">Memory saturation (fully stalled)</p>

Indicates the amount of time all non-idle processes were stalled waiting on memory operations to complete. This is often correlated with vmem efficiency ratio when pressure on available memory is high. If they`re not correlated, this could indicate issues with the machine hardware and/or configuration.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100812` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `rate(node_pressure_memory_stalled_seconds_total{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval])`

</details>

<br />

#### executor: node_io_disk_utilization

<p class="subtitle">Disk IO utilization (percentage time spent in IO)</p>

Indicates the percentage of time a disk was busy. If this is less than 100%, then the disk has spare utilization capacity. However, a value of 100% does not necesarily indicate the disk is at max capacity. For single, serial request-serving devices, 100% may indicate maximum saturation, but for SSDs and RAID arrays this is less likely to be the case, as they are capable of serving multiple requests in parallel, other metrics such as throughput and request queue size should be factored in.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100820` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(label_replace(label_replace(rate(node_disk_io_time_seconds_total{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval]), "disk", "$1", "device", "^([^d].+)"), "disk", "ignite", "device", "dm-.*")) by(sg_instance,disk) * 100`

</details>

<br />

#### executor: node_io_disk_saturation

<p class="subtitle">Disk IO saturation (avg IO queue size)</p>

Indicates the number of outstanding/queued IO requests. High but short-lived queue sizes may not present an issue, but if theyre consistently/often high and/or monotonically increasing, the disk may be failing or simply too slow for the amount of activity required. Consider replacing the drive(s) with SSDs if they are not already and/or replacing the faulty drive(s), if any.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100821` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(label_replace(label_replace(rate(node_disk_io_time_weighted_seconds_total{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval]), "disk", "$1", "device", "^([^d].+)"), "disk", "ignite", "device", "dm-.*")) by(sg_instance,disk)`

</details>

<br />

#### executor: node_io_disk_saturation_pressure_full

<p class="subtitle">Disk IO saturation (avg time of all processes stalled)</p>

Indicates the averaged amount of time for which all non-idle processes were stalled waiting for IO to complete simultaneously aka where no processes could make progress.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100822` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `rate(node_pressure_io_stalled_seconds_total{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval])`

</details>

<br />

#### executor: node_io_network_utilization

<p class="subtitle">Network IO utilization (Rx)</p>

Indicates the average summed receiving throughput of all network interfaces. This is often predominantly composed of the WAN/internet-connected interface, and knowing normal/good figures depends on knowing the bandwidth of the underlying hardware and the workloads.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100830` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_receive_bytes_total{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval])) by(sg_instance) * 8`

</details>

<br />

#### executor: node_io_network_saturation

<p class="subtitle">Network IO saturation (Rx packets dropped)</p>

Number of dropped received packets. This can happen if the receive queues/buffers become full due to slow packet processing throughput. The queues/buffers could be configured to be larger as a stop-gap but the processing application should be investigated as soon as possible. https://www.kernel.org/doc/html/latest/networking/statistics.html#:~:text=not%20otherwise%20counted.-,rx_dropped,-Number%20of%20packets

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100831` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_receive_drop_total{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval])) by(sg_instance)`

</details>

<br />

#### executor: node_io_network_saturation

<p class="subtitle">Network IO errors (Rx)</p>

Number of bad/malformed packets received. https://www.kernel.org/doc/html/latest/networking/statistics.html#:~:text=excluding%20the%20FCS.-,rx_errors,-Total%20number%20of

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100832` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_receive_errs_total{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval])) by(sg_instance)`

</details>

<br />

#### executor: node_io_network_utilization

<p class="subtitle">Network IO utilization (Tx)</p>

Indicates the average summed transmitted throughput of all network interfaces. This is often predominantly composed of the WAN/internet-connected interface, and knowing normal/good figures depends on knowing the bandwidth of the underlying hardware and the workloads.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100840` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_transmit_bytes_total{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval])) by(sg_instance) * 8`

</details>

<br />

#### executor: node_io_network_saturation

<p class="subtitle">Network IO saturation (Tx packets dropped)</p>

Number of dropped transmitted packets. This can happen if the receiving side`s receive queues/buffers become full due to slow packet processing throughput, the network link is congested etc.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100841` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_transmit_drop_total{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval])) by(sg_instance)`

</details>

<br />

#### executor: node_io_network_saturation

<p class="subtitle">Network IO errors (Tx)</p>

Number of packet transmission errors. This is distinct from tx packet dropping, and can indicate a failing NIC, improperly configured network options anywhere along the line, signal noise etc.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100842` on your Sourcegraph instance.


<details>
<summary>Technical details</summary>

Query: `sum(rate(node_network_transmit_errs_total{sg_job=~"sourcegraph-executors-registry",sg_instance=~"docker-registry"}[$__rate_interval])) by(sg_instance)`

</details>

<br />

### Executor: Golang runtime monitoring

#### executor: go_goroutines

<p class="subtitle">Maximum active goroutines</p>

A high value here indicates a possible goroutine leak.

Refer to the [alerts reference](./alerts.md#executor-go-goroutines) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100900` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(sg_instance) (go_goroutines{sg_job=~".*sourcegraph-executors"})`

</details>

<br />

#### executor: go_gc_duration_seconds

<p class="subtitle">Maximum go garbage collection duration</p>

Refer to the [alerts reference](./alerts.md#executor-go-gc-duration-seconds) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/executor/executor?viewPanel=100901` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by(sg_instance) (go_gc_duration_seconds{sg_job=~".*sourcegraph-executors"})`

</details>

<br />

## Global Containers Resource Usage

<p class="subtitle">Container usage and provisioning indicators of all services.</p>

To see this dashboard, visit `/-/debug/grafana/d/containers/containers` on your Sourcegraph instance.

### Global Containers Resource Usage: Containers (not available on server)

#### containers: container_memory_usage

<p class="subtitle">Container memory usage of all services</p>

This value indicates the memory usage of all containers.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/containers/containers?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_memory_usage_percentage_total{name=~"^(frontend|sourcegraph-frontend|gitserver|github-proxy|pgsql|codeintel-db|codeinsights|precise-code-intel-worker|prometheus|redis-cache|redis-store|redis-exporter|repo-updater|searcher|symbols|syntect-server|worker|zoekt-indexserver|zoekt-webserver|indexed-search|grafana|minio|jaeger).*"}`

</details>

<br />

#### containers: container_cpu_usage

<p class="subtitle">Container cpu usage total (1m average) across all cores by instance</p>

This value indicates the CPU usage of all containers.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/containers/containers?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `cadvisor_container_cpu_usage_percentage_total{name=~"^(frontend|sourcegraph-frontend|gitserver|github-proxy|pgsql|codeintel-db|codeinsights|precise-code-intel-worker|prometheus|redis-cache|redis-store|redis-exporter|repo-updater|searcher|symbols|syntect-server|worker|zoekt-indexserver|zoekt-webserver|indexed-search|grafana|minio|jaeger).*"}`

</details>

<br />

### Global Containers Resource Usage: Containers: Provisioning Indicators (not available on server)

#### containers: container_memory_usage_provisioning

<p class="subtitle">Container memory usage (5m maximum) of services that exceed 80% memory limit</p>

Containers that exceed 80% memory limit. The value indicates potential underprovisioned resources.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/containers/containers?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_memory_usage_percentage_total{name=~"^(frontend|sourcegraph-frontend|gitserver|github-proxy|pgsql|codeintel-db|codeinsights|precise-code-intel-worker|prometheus|redis-cache|redis-store|redis-exporter|repo-updater|searcher|symbols|syntect-server|worker|zoekt-indexserver|zoekt-webserver|indexed-search|grafana|minio|jaeger).*"}[5m]) >= 80`

</details>

<br />

#### containers: container_cpu_usage_provisioning

<p class="subtitle">Container cpu usage total (5m maximum) across all cores of services that exceed 80% cpu limit</p>

Containers that exceed 80% CPU limit. The value indicates potential underprovisioned resources.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/containers/containers?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max_over_time(cadvisor_container_cpu_usage_percentage_total{name=~"^(frontend|sourcegraph-frontend|gitserver|github-proxy|pgsql|codeintel-db|codeinsights|precise-code-intel-worker|prometheus|redis-cache|redis-store|redis-exporter|repo-updater|searcher|symbols|syntect-server|worker|zoekt-indexserver|zoekt-webserver|indexed-search|grafana|minio|jaeger).*"}[5m]) >= 80`

</details>

<br />

#### containers: container_oomkill_events_total

<p class="subtitle">Container OOMKILL events total</p>

This value indicates the total number of times the container main process or child processes were terminated by OOM killer.
When it occurs frequently, it is an indicator of underprovisioning.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/containers/containers?viewPanel=100120` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (name) (container_oom_events_total{name=~"^(frontend|sourcegraph-frontend|gitserver|github-proxy|pgsql|codeintel-db|codeinsights|precise-code-intel-worker|prometheus|redis-cache|redis-store|redis-exporter|repo-updater|searcher|symbols|syntect-server|worker|zoekt-indexserver|zoekt-webserver|indexed-search|grafana|minio|jaeger).*"}) >= 1`

</details>

<br />

#### containers: container_missing

<p class="subtitle">Container missing</p>

This value is the number of times a container has not been seen for more than one minute. If you observe this
value change independent of deployment events (such as an upgrade), it could indicate pods are being OOM killed or terminated for some other reasons.

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/containers/containers?viewPanel=100130` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Cloud DevOps team](https://handbook.sourcegraph.com/departments/engineering/teams/devops).*</sub>

<details>
<summary>Technical details</summary>

Query: `count by(name) ((time() - container_last_seen{name=~"^(frontend|sourcegraph-frontend|gitserver|github-proxy|pgsql|codeintel-db|codeinsights|precise-code-intel-worker|prometheus|redis-cache|redis-store|redis-exporter|repo-updater|searcher|symbols|syntect-server|worker|zoekt-indexserver|zoekt-webserver|indexed-search|grafana|minio|jaeger).*"}) > 60)`

</details>

<br />

## Code Intelligence > Autoindexing

<p class="subtitle">The service at `internal/codeintel/autoindexing`.</p>

To see this dashboard, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing` on your Sourcegraph instance.

### Code Intelligence > Autoindexing: Codeintel: Autoindexing > Summary

#### codeintel-autoindexing: 

<p class="subtitle">Auto-index jobs inserted over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_dbstore_indexes_inserted[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_error_rate

<p class="subtitle">Auto-indexing job scheduler operation error rate over 10m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_errors_total{op='HandleIndexSchedule',job=~"^.*"}[10m])) / (sum(increase(src_codeintel_autoindexing_total{op='HandleIndexSchedule',job=~"^.*"}[10m])) + sum(increase(src_codeintel_autoindexing_errors_total{op='HandleIndexSchedule',job=~"^.*"}[10m]))) * 100`

</details>

<br />

#### codeintel-autoindexing: executor_queue_size

<p class="subtitle">Unprocessed executor job queue size</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (queue)(src_executor_total{queue=~"codeintel",job=~"^(executor|sourcegraph-code-intel-indexers|executor-batches|frontend|sourcegraph-frontend|worker|sourcegraph-executors).*"})`

</details>

<br />

#### codeintel-autoindexing: executor_queue_growth_rate

<p class="subtitle">Unprocessed executor job queue growth rate over 30m</p>

This value compares the rate of enqueues against the rate of finished jobs for the selected queue.

	- A value < than 1 indicates that process rate > enqueue rate
	- A value = than 1 indicates that process rate = enqueue rate
	- A value > than 1 indicates that process rate < enqueue rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (queue)(increase(src_executor_total{queue=~"codeintel",job=~"^(executor|sourcegraph-code-intel-indexers|executor-batches|frontend|sourcegraph-frontend|worker|sourcegraph-executors).*"}[30m])) / sum by (queue)(increase(src_executor_processor_total{queue=~"codeintel",job=~"^(executor|sourcegraph-code-intel-indexers|executor-batches|frontend|sourcegraph-frontend|worker|sourcegraph-executors).*"}[30m]))`

</details>

<br />

#### codeintel-autoindexing: executor_queued_max_age

<p class="subtitle">Unprocessed executor job queue longest time in queue</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max by (queue)(src_executor_queued_duration_seconds_total{queue=~"codeintel",job=~"^(executor|sourcegraph-code-intel-indexers|executor-batches|frontend|sourcegraph-frontend|worker|sourcegraph-executors).*"})`

</details>

<br />

### Code Intelligence > Autoindexing: Codeintel: Autoindexing > Service

#### codeintel-autoindexing: codeintel_autoindexing_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_autoindexing_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100103` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_autoindexing_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_autoindexing_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_autoindexing_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100113` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_autoindexing_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_autoindexing_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Autoindexing: Codeintel: Autoindexing > GQL transport

#### codeintel-autoindexing: codeintel_autoindexing_transport_graphql_total

<p class="subtitle">Aggregate resolver operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_transport_graphql_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_transport_graphql_99th_percentile_duration

<p class="subtitle">Aggregate successful resolver operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_autoindexing_transport_graphql_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_transport_graphql_errors_total

<p class="subtitle">Aggregate resolver operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_transport_graphql_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_transport_graphql_error_rate

<p class="subtitle">Aggregate resolver operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100203` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_transport_graphql_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_autoindexing_transport_graphql_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_autoindexing_transport_graphql_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_transport_graphql_total

<p class="subtitle">Resolver operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_transport_graphql_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_transport_graphql_99th_percentile_duration

<p class="subtitle">99th percentile successful resolver operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_autoindexing_transport_graphql_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_transport_graphql_errors_total

<p class="subtitle">Resolver operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_transport_graphql_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_transport_graphql_error_rate

<p class="subtitle">Resolver operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100213` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_transport_graphql_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_autoindexing_transport_graphql_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_autoindexing_transport_graphql_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Autoindexing: Codeintel: Autoindexing > Store (internal)

#### codeintel-autoindexing: codeintel_autoindexing_store_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_store_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_store_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_autoindexing_store_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_store_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_store_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_store_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_store_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_autoindexing_store_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_autoindexing_store_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_store_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_autoindexing_store_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_store_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100313` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_store_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_autoindexing_store_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_autoindexing_store_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Autoindexing: Codeintel: Autoindexing > Background jobs (internal)

#### codeintel-autoindexing: codeintel_autoindexing_background_total

<p class="subtitle">Aggregate background operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_background_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_background_99th_percentile_duration

<p class="subtitle">Aggregate successful background operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_autoindexing_background_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_background_errors_total

<p class="subtitle">Aggregate background operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_background_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_background_error_rate

<p class="subtitle">Aggregate background operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100403` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_background_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_autoindexing_background_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_autoindexing_background_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_background_total

<p class="subtitle">Background operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_background_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_background_99th_percentile_duration

<p class="subtitle">99th percentile successful background operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100411` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_autoindexing_background_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_background_errors_total

<p class="subtitle">Background operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100412` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_background_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_background_error_rate

<p class="subtitle">Background operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100413` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_background_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_autoindexing_background_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_autoindexing_background_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Autoindexing: Codeintel: Autoindexing > Inference service (internal)

#### codeintel-autoindexing: codeintel_autoindexing_inference_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_inference_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_inference_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_autoindexing_inference_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_inference_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100502` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_inference_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_inference_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100503` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_inference_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_autoindexing_inference_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_autoindexing_inference_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_inference_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100510` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_inference_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_inference_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100511` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_autoindexing_inference_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_inference_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100512` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_inference_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: codeintel_autoindexing_inference_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100513` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_autoindexing_inference_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_autoindexing_inference_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_autoindexing_inference_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Autoindexing: Codeintel: Luasandbox service

#### codeintel-autoindexing: luasandbox_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_luasandbox_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: luasandbox_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_luasandbox_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: luasandbox_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100602` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_luasandbox_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: luasandbox_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100603` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_luasandbox_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_luasandbox_total{job=~"^.*"}[5m])) + sum(increase(src_luasandbox_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-autoindexing: luasandbox_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100610` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_luasandbox_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: luasandbox_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100611` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_luasandbox_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-autoindexing: luasandbox_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100612` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_luasandbox_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-autoindexing: luasandbox_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-autoindexing/codeintel-autoindexing?viewPanel=100613` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_luasandbox_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_luasandbox_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_luasandbox_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

## Code Intelligence > Uploads

<p class="subtitle">The service at `internal/codeintel/uploads`.</p>

To see this dashboard, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads` on your Sourcegraph instance.

### Code Intelligence > Uploads: Codeintel: Uploads > Service

#### codeintel-uploads: codeintel_uploads_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploads_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100003` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_uploads_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_uploads_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploads_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100013` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_uploads_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_uploads_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Uploads: Codeintel: Uploads > Store

#### codeintel-uploads: codeintel_uploads_store_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_store_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploads_store_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_store_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_store_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100103` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_store_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_uploads_store_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_uploads_store_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploads_store_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100113` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_uploads_store_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_uploads_store_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Uploads: Codeintel: Uploads > GQL Transport

#### codeintel-uploads: codeintel_uploads_transport_graphql_total

<p class="subtitle">Aggregate resolver operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_transport_graphql_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_graphql_99th_percentile_duration

<p class="subtitle">Aggregate successful resolver operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploads_transport_graphql_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_graphql_errors_total

<p class="subtitle">Aggregate resolver operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_transport_graphql_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_graphql_error_rate

<p class="subtitle">Aggregate resolver operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100203` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_transport_graphql_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_uploads_transport_graphql_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_uploads_transport_graphql_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_graphql_total

<p class="subtitle">Resolver operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_transport_graphql_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_graphql_99th_percentile_duration

<p class="subtitle">99th percentile successful resolver operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploads_transport_graphql_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_graphql_errors_total

<p class="subtitle">Resolver operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_transport_graphql_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_graphql_error_rate

<p class="subtitle">Resolver operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100213` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_transport_graphql_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_uploads_transport_graphql_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_uploads_transport_graphql_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Uploads: Codeintel: Uploads > HTTP Transport

#### codeintel-uploads: codeintel_uploads_transport_http_total

<p class="subtitle">Aggregate http handler operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_transport_http_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_http_99th_percentile_duration

<p class="subtitle">Aggregate successful http handler operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_uploads_transport_http_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_http_errors_total

<p class="subtitle">Aggregate http handler operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_transport_http_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_http_error_rate

<p class="subtitle">Aggregate http handler operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_transport_http_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_uploads_transport_http_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_uploads_transport_http_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_http_total

<p class="subtitle">Http handler operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_transport_http_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_http_99th_percentile_duration

<p class="subtitle">99th percentile successful http handler operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_uploads_transport_http_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_http_errors_total

<p class="subtitle">Http handler operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_transport_http_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_transport_http_error_rate

<p class="subtitle">Http handler operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100313` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_uploads_transport_http_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_uploads_transport_http_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_uploads_transport_http_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Uploads: Codeintel: Uploads > Cleanup task

#### codeintel-uploads: codeintel_background_upload_records_removed_total

<p class="subtitle">Lsif upload records deleted every 5m</p>

Number of LSIF upload records deleted due to expiration or unreachability every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100400` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_upload_records_removed_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_background_index_records_removed_total

<p class="subtitle">Lsif index records deleted every 5m</p>

Number of LSIF index records deleted due to expiration or unreachability every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100401` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_index_records_removed_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_background_uploads_purged_total

<p class="subtitle">Lsif upload data bundles deleted every 5m</p>

Number of LSIF upload data bundles purged from the codeintel-db database every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100402` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_uploads_purged_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_background_audit_log_records_expired_total

<p class="subtitle">Lsif upload audit log records deleted every 5m</p>

Number of LSIF upload audit log records deleted due to expiration every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100403` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_audit_log_records_expired_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_uploads_background_cleanup_errors_total

<p class="subtitle">Cleanup task operation errors every 5m</p>

Number of code intelligence uploads cleanup task errors every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100410` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_uploads_background_cleanup_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_autoindexing_background_cleanup_errors_total

<p class="subtitle">Cleanup task operation errors every 5m</p>

Number of code intelligence autoindexing cleanup task errors every 5m

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100411` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_autoindexing_background_cleanup_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

### Code Intelligence > Uploads: Codeintel: Repository with stale commit graph

#### codeintel-uploads: codeintel_commit_graph_queue_size

<p class="subtitle">Repository queue size</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100500` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_commit_graph_total{job=~"^.*"})`

</details>

<br />

#### codeintel-uploads: codeintel_commit_graph_queue_growth_rate

<p class="subtitle">Repository queue growth rate over 30m</p>

This value compares the rate of enqueues against the rate of finished jobs.

	- A value < than 1 indicates that process rate > enqueue rate
	- A value = than 1 indicates that process rate = enqueue rate
	- A value > than 1 indicates that process rate < enqueue rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100501` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_commit_graph_total{job=~"^.*"}[30m])) / sum(increase(src_codeintel_commit_graph_processor_total{job=~"^.*"}[30m]))`

</details>

<br />

#### codeintel-uploads: codeintel_commit_graph_queued_max_age

<p class="subtitle">Repository queue longest time in queue</p>

Refer to the [alerts reference](./alerts.md#codeintel-uploads-codeintel-commit-graph-queued-max-age) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100502` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_codeintel_commit_graph_queued_duration_seconds_total{job=~"^.*"})`

</details>

<br />

### Code Intelligence > Uploads: Codeintel: Uploads > Expiration task

#### codeintel-uploads: codeintel_background_repositories_scanned_total_total

<p class="subtitle">Lsif upload repository scan repositories scanned every 5m</p>

Number of repositories scanned for data retention

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100600` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_repositories_scanned_total_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_background_upload_records_scanned_total_total

<p class="subtitle">Lsif upload records scan records scanned every 5m</p>

Number of codeintel upload records scanned for data retention

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100601` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_upload_records_scanned_total_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_background_commits_scanned_total_total

<p class="subtitle">Lsif upload commits scanned commits scanned every 5m</p>

Number of commits reachable from a codeintel upload record scanned for data retention

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100602` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_commits_scanned_total_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-uploads: codeintel_background_upload_records_expired_total_total

<p class="subtitle">Lsif upload records expired uploads scanned every 5m</p>

Number of codeintel upload records marked as expired

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-uploads/codeintel-uploads?viewPanel=100603` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_upload_records_expired_total_total{job=~"^.*"}[5m]))`

</details>

<br />

## Code Intelligence > Policies

<p class="subtitle">The service at `internal/codeintel/policies`.</p>

To see this dashboard, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies` on your Sourcegraph instance.

### Code Intelligence > Policies: Codeintel: Policies > Service

#### codeintel-policies: codeintel_policies_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_policies_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_policies_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_policies_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100003` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_policies_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_policies_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_policies_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-policies: codeintel_policies_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_policies_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_policies_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-policies: codeintel_policies_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_policies_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100013` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_policies_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_policies_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_policies_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Policies: Codeintel: Policies > Store

#### codeintel-policies: codeintel_policies_store_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_policies_store_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_store_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_policies_store_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_store_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_policies_store_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_store_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100103` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_policies_store_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_policies_store_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_policies_store_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-policies: codeintel_policies_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_policies_store_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_policies_store_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-policies: codeintel_policies_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_policies_store_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100113` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_policies_store_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_policies_store_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_policies_store_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Policies: Codeintel: Policies > GQL Transport

#### codeintel-policies: codeintel_policies_transport_graphql_total

<p class="subtitle">Aggregate resolver operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_policies_transport_graphql_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_transport_graphql_99th_percentile_duration

<p class="subtitle">Aggregate successful resolver operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_policies_transport_graphql_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_transport_graphql_errors_total

<p class="subtitle">Aggregate resolver operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_policies_transport_graphql_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_transport_graphql_error_rate

<p class="subtitle">Aggregate resolver operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100203` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_policies_transport_graphql_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_policies_transport_graphql_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_policies_transport_graphql_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-policies: codeintel_policies_transport_graphql_total

<p class="subtitle">Resolver operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_policies_transport_graphql_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_transport_graphql_99th_percentile_duration

<p class="subtitle">99th percentile successful resolver operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_policies_transport_graphql_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-policies: codeintel_policies_transport_graphql_errors_total

<p class="subtitle">Resolver operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_policies_transport_graphql_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-policies: codeintel_policies_transport_graphql_error_rate

<p class="subtitle">Resolver operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100213` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_policies_transport_graphql_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_policies_transport_graphql_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_policies_transport_graphql_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Policies: Codeintel: Policies > Repository Pattern Matcher task

#### codeintel-policies: codeintel_background_policies_updated_total_total

<p class="subtitle">Lsif repository pattern matcher repositories pattern matcher every 5m</p>

Number of configuration policies whose repository membership list was updated

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-policies/codeintel-policies?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_background_policies_updated_total_total{job=~"^.*"}[5m]))`

</details>

<br />

## Code Intelligence > Code Nav

<p class="subtitle">The service at `internal/codeintel/codenav`.</p>

To see this dashboard, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav` on your Sourcegraph instance.

### Code Intelligence > Code Nav: Codeintel: CodeNav > Service

#### codeintel-codenav: codeintel_codenav_total

<p class="subtitle">Aggregate service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_99th_percentile_duration

<p class="subtitle">Aggregate successful service operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_codenav_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_errors_total

<p class="subtitle">Aggregate service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_error_rate

<p class="subtitle">Aggregate service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100003` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_codenav_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_codenav_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_total

<p class="subtitle">Service operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_99th_percentile_duration

<p class="subtitle">99th percentile successful service operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_codenav_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_errors_total

<p class="subtitle">Service operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_error_rate

<p class="subtitle">Service operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100013` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_codenav_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_codenav_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Code Nav: Codeintel: CodeNav > LSIF store

#### codeintel-codenav: codeintel_codenav_lsifstore_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_lsifstore_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_lsifstore_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_codenav_lsifstore_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_lsifstore_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100102` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_lsifstore_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_lsifstore_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100103` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_lsifstore_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_codenav_lsifstore_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_codenav_lsifstore_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_lsifstore_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100110` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_lsifstore_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_lsifstore_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100111` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_codenav_lsifstore_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_lsifstore_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100112` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_lsifstore_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_lsifstore_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100113` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_lsifstore_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_codenav_lsifstore_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_codenav_lsifstore_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Code Nav: Codeintel: CodeNav > GQL Transport

#### codeintel-codenav: codeintel_codenav_transport_graphql_total

<p class="subtitle">Aggregate resolver operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_transport_graphql_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_transport_graphql_99th_percentile_duration

<p class="subtitle">Aggregate successful resolver operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100201` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_codenav_transport_graphql_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_transport_graphql_errors_total

<p class="subtitle">Aggregate resolver operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100202` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_transport_graphql_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_transport_graphql_error_rate

<p class="subtitle">Aggregate resolver operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100203` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_transport_graphql_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_codenav_transport_graphql_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_codenav_transport_graphql_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_transport_graphql_total

<p class="subtitle">Resolver operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100210` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_transport_graphql_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_transport_graphql_99th_percentile_duration

<p class="subtitle">99th percentile successful resolver operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100211` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_codenav_transport_graphql_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_transport_graphql_errors_total

<p class="subtitle">Resolver operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100212` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_transport_graphql_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_transport_graphql_error_rate

<p class="subtitle">Resolver operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100213` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_transport_graphql_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_codenav_transport_graphql_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_codenav_transport_graphql_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

### Code Intelligence > Code Nav: Codeintel: CodeNav > Store

#### codeintel-codenav: codeintel_codenav_store_total

<p class="subtitle">Aggregate store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100300` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_store_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_store_99th_percentile_duration

<p class="subtitle">Aggregate successful store operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100301` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_codeintel_codenav_store_duration_seconds_bucket{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_store_errors_total

<p class="subtitle">Aggregate store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100302` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_store_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_store_error_rate

<p class="subtitle">Aggregate store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100303` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_codeintel_codenav_store_errors_total{job=~"^.*"}[5m])) / (sum(increase(src_codeintel_codenav_store_total{job=~"^.*"}[5m])) + sum(increase(src_codeintel_codenav_store_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_store_total

<p class="subtitle">Store operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100310` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_store_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_store_99th_percentile_duration

<p class="subtitle">99th percentile successful store operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100311` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_codeintel_codenav_store_duration_seconds_bucket{job=~"^.*"}[5m])))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_store_errors_total

<p class="subtitle">Store operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100312` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_store_errors_total{job=~"^.*"}[5m]))`

</details>

<br />

#### codeintel-codenav: codeintel_codenav_store_error_rate

<p class="subtitle">Store operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/codeintel-codenav/codeintel-codenav?viewPanel=100313` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code intelligence team](https://handbook.sourcegraph.com/departments/engineering/teams/code-intelligence).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_codeintel_codenav_store_errors_total{job=~"^.*"}[5m])) / (sum by (op)(increase(src_codeintel_codenav_store_total{job=~"^.*"}[5m])) + sum by (op)(increase(src_codeintel_codenav_store_errors_total{job=~"^.*"}[5m]))) * 100`

</details>

<br />

## Telemetry

<p class="subtitle">Monitoring telemetry services in Sourcegraph.</p>

To see this dashboard, visit `/-/debug/grafana/d/telemetry/telemetry` on your Sourcegraph instance.

### Telemetry: Usage data exporter: Job operations

#### telemetry: telemetry_job_total

<p class="subtitle">Aggregate usage data exporter operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/telemetry/telemetry?viewPanel=100000` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Data & Analytics team](https://handbook.sourcegraph.com/departments/engineering/teams/data-analytics).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_telemetry_job_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### telemetry: telemetry_job_99th_percentile_duration

<p class="subtitle">Aggregate successful usage data exporter operation duration distribution over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/telemetry/telemetry?viewPanel=100001` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Data & Analytics team](https://handbook.sourcegraph.com/departments/engineering/teams/data-analytics).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum  by (le)(rate(src_telemetry_job_duration_seconds_bucket{job=~"^worker.*"}[5m]))`

</details>

<br />

#### telemetry: telemetry_job_errors_total

<p class="subtitle">Aggregate usage data exporter operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/telemetry/telemetry?viewPanel=100002` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Data & Analytics team](https://handbook.sourcegraph.com/departments/engineering/teams/data-analytics).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_telemetry_job_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### telemetry: telemetry_job_error_rate

<p class="subtitle">Aggregate usage data exporter operation error rate over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/telemetry/telemetry?viewPanel=100003` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Data & Analytics team](https://handbook.sourcegraph.com/departments/engineering/teams/data-analytics).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_telemetry_job_errors_total{job=~"^worker.*"}[5m])) / (sum(increase(src_telemetry_job_total{job=~"^worker.*"}[5m])) + sum(increase(src_telemetry_job_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

#### telemetry: telemetry_job_total

<p class="subtitle">Usage data exporter operations every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/telemetry/telemetry?viewPanel=100010` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Data & Analytics team](https://handbook.sourcegraph.com/departments/engineering/teams/data-analytics).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_telemetry_job_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### telemetry: telemetry_job_99th_percentile_duration

<p class="subtitle">99th percentile successful usage data exporter operation duration over 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/telemetry/telemetry?viewPanel=100011` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Data & Analytics team](https://handbook.sourcegraph.com/departments/engineering/teams/data-analytics).*</sub>

<details>
<summary>Technical details</summary>

Query: `histogram_quantile(0.99, sum  by (le,op)(rate(src_telemetry_job_duration_seconds_bucket{job=~"^worker.*"}[5m])))`

</details>

<br />

#### telemetry: telemetry_job_errors_total

<p class="subtitle">Usage data exporter operation errors every 5m</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/telemetry/telemetry?viewPanel=100012` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Data & Analytics team](https://handbook.sourcegraph.com/departments/engineering/teams/data-analytics).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_telemetry_job_errors_total{job=~"^worker.*"}[5m]))`

</details>

<br />

#### telemetry: telemetry_job_error_rate

<p class="subtitle">Usage data exporter operation error rate over 5m</p>

Refer to the [alerts reference](./alerts.md#telemetry-telemetry-job-error-rate) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/telemetry/telemetry?viewPanel=100013` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Data & Analytics team](https://handbook.sourcegraph.com/departments/engineering/teams/data-analytics).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum by (op)(increase(src_telemetry_job_errors_total{job=~"^worker.*"}[5m])) / (sum by (op)(increase(src_telemetry_job_total{job=~"^worker.*"}[5m])) + sum by (op)(increase(src_telemetry_job_errors_total{job=~"^worker.*"}[5m]))) * 100`

</details>

<br />

### Telemetry: Usage data exporter: Queue size

#### telemetry: telemetry_job_queue_size_queue_size

<p class="subtitle">Event level usage data queue size</p>

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/telemetry/telemetry?viewPanel=100100` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `max(src_telemetry_job_queue_size_total{job=~"^worker.*"})`

</details>

<br />

#### telemetry: telemetry_job_queue_size_queue_growth_rate

<p class="subtitle">Event level usage data queue growth rate over 30m</p>

This value compares the rate of enqueues against the rate of finished jobs.

	- A value < than 1 indicates that process rate > enqueue rate
	- A value = than 1 indicates that process rate = enqueue rate
	- A value > than 1 indicates that process rate < enqueue rate

This panel has no related alerts.

To see this panel, visit `/-/debug/grafana/d/telemetry/telemetry?viewPanel=100101` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Code Insights team](https://handbook.sourcegraph.com/departments/engineering/teams/code-insights).*</sub>

<details>
<summary>Technical details</summary>

Query: `sum(increase(src_telemetry_job_queue_size_total{job=~"^worker.*"}[30m])) / sum(increase(src_telemetry_job_queue_size_processor_total{job=~"^worker.*"}[30m]))`

</details>

<br />

### Telemetry: Usage data exporter: Utilization

#### telemetry: telemetry_job_utilized_throughput

<p class="subtitle">Utilized percentage of maximum throughput</p>

Refer to the [alerts reference](./alerts.md#telemetry-telemetry-job-utilized-throughput) for 1 alert related to this panel.

To see this panel, visit `/-/debug/grafana/d/telemetry/telemetry?viewPanel=100200` on your Sourcegraph instance.

<sub>*Managed by the [Sourcegraph Data & Analytics team](https://handbook.sourcegraph.com/departments/engineering/teams/data-analytics).*</sub>

<details>
<summary>Technical details</summary>

Query: `rate(src_telemetry_job_total{op="SendEvents"}[1h]) / on() group_right() src_telemetry_job_max_throughput * 100`

</details>

<br />

