package codygateway

import (
	"context"
	"fmt"
	"net/http"
	"net/url"
	"strings"

	"github.com/sourcegraph/sourcegraph/enterprise/internal/codygateway"
	"github.com/sourcegraph/sourcegraph/enterprise/internal/completions/client/anthropic"
	"github.com/sourcegraph/sourcegraph/enterprise/internal/completions/client/openai"
	"github.com/sourcegraph/sourcegraph/enterprise/internal/completions/types"
	"github.com/sourcegraph/sourcegraph/internal/httpcli"
	"github.com/sourcegraph/sourcegraph/lib/errors"
)

const (
	// ProviderName is 'sourcegraph', since this is a Sourcegraph-provided service,
	// backed by Cody Gateway. This is the value accepted in site configuration.
	ProviderName    = "sourcegraph"
	DefaultEndpoint = "https://cody-gateway.sourcegraph.com"
)

// NewClient instantiates a completions provider backed by Sourcegraph's managed
// Cody Gateway service.
func NewClient(cli httpcli.Doer, endpoint, accessToken string) (types.CompletionsClient, error) {
	gatewayURL, err := url.Parse(endpoint)
	if err != nil {
		return nil, err
	}
	return &codyGatewayClient{
		upstream:    cli,
		gatewayURL:  gatewayURL,
		accessToken: accessToken,
	}, nil
}

type codyGatewayClient struct {
	upstream    httpcli.Doer
	gatewayURL  *url.URL
	accessToken string
}

func (c *codyGatewayClient) Stream(ctx context.Context, feature types.CompletionsFeature, requestParams types.CompletionRequestParameters, sendEvent types.SendCompletionEvent) error {
	cc, err := c.clientForParams(feature, &requestParams)
	if err != nil {
		return err
	}
	return cc.Stream(ctx, feature, requestParams, sendEvent)
}

func (c *codyGatewayClient) Complete(ctx context.Context, feature types.CompletionsFeature, requestParams types.CompletionRequestParameters) (*types.CompletionResponse, error) {
	cc, err := c.clientForParams(feature, &requestParams)
	if err != nil {
		return nil, err
	}
	// Passthrough error directly, ErrStatusNotOK should be implemented by the
	// underlying client.
	return cc.Complete(ctx, feature, requestParams)
}

func (c *codyGatewayClient) clientForParams(feature types.CompletionsFeature, requestParams *types.CompletionRequestParameters) (types.CompletionsClient, error) {
	gatewayModel := strings.ToLower(requestParams.Model)

	// Extract provider and model from the Cody Gateway model format and override
	// the request parameter's model.
	provider, model := getProviderFromGatewayModel(gatewayModel)
	requestParams.Model = model

	// Based on the provider, instantiate the appropriate client backed by a
	// gatewayDoer that authenticates against the Gateway's API.
	switch provider {
	case anthropic.ProviderName:
		return anthropic.NewClient(gatewayDoer(c.upstream, feature, c.gatewayURL, c.accessToken, "/v1/completions/anthropic"), "", ""), nil
	case openai.ProviderName:
		return openai.NewClient(gatewayDoer(c.upstream, feature, c.gatewayURL, c.accessToken, "/v1/completions/openai"), "", ""), nil
	default:
		return nil, errors.Newf("no client known for upstream model %s", gatewayModel)
	}
}

// getProviderFromGatewayModel extracts the model provider from Cody Gateway
// configuration's expected model naming format, "$PROVIDER/$MODEL_NAME".
func getProviderFromGatewayModel(gatewayModel string) (provider string, model string) {
	parts := strings.SplitN(gatewayModel, "/", 2)
	if len(parts) < 2 {
		return parts[0], ""
	}
	return parts[0], parts[1]
}

// gatewayDoer redirects requests to Cody Gateway with all prerequisite headers.
func gatewayDoer(upstream httpcli.Doer, feature types.CompletionsFeature, gatewayURL *url.URL, accessToken, path string) httpcli.Doer {
	return httpcli.DoerFunc(func(req *http.Request) (*http.Response, error) {
		req.Host = gatewayURL.Host
		req.URL = gatewayURL
		req.URL.Path = path
		req.Header.Set("Authorization", fmt.Sprintf("Bearer %s", accessToken))
		req.Header.Set(codygateway.FeatureHeaderName, string(feature))
		return upstream.Do(req)
	})
}