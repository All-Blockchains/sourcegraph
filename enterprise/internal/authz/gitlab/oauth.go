package gitlab

import (
	"context"
	"net/url"

	"github.com/sourcegraph/sourcegraph/internal/authz"
	"github.com/sourcegraph/sourcegraph/internal/database"
	"github.com/sourcegraph/sourcegraph/internal/extsvc"
	"github.com/sourcegraph/sourcegraph/internal/extsvc/auth"
	"github.com/sourcegraph/sourcegraph/internal/extsvc/gitlab"
	"github.com/sourcegraph/sourcegraph/internal/httpcli"
	"github.com/sourcegraph/sourcegraph/internal/oauthutil"
	"github.com/sourcegraph/sourcegraph/internal/types"
	"github.com/sourcegraph/sourcegraph/lib/errors"
)

var _ authz.Provider = (*OAuthProvider)(nil)

type OAuthProvider struct {
	// The token is the access token used for syncing repositories from the code host,
	// but it may or may not be a sudo-scoped.
	token     string
	tokenType gitlab.TokenType

	urn            string
	clientProvider *gitlab.ClientProvider
	clientURL      *url.URL
	codeHost       *extsvc.CodeHost
	db             database.DB
}

type OAuthProviderOp struct {
	// The unique resource identifier of the external service where the provider is defined.
	URN string

	// BaseURL is the URL of the GitLab instance.
	BaseURL *url.URL

	// Token is an access token with api scope, it may or may not have sudo scope.
	//
	// 🚨 SECURITY: This value contains secret information that must not be shown to non-site-admins.
	Token string

	// TokenType is the type of the access token. Default is gitlab.TokenTypePAT.
	TokenType gitlab.TokenType

	DB database.DB
}

func newOAuthProvider(op OAuthProviderOp, cli httpcli.Doer, tokenRefresher oauthutil.TokenRefresher) *OAuthProvider {
	return &OAuthProvider{
		token:     op.Token,
		tokenType: op.TokenType,

		urn:            op.URN,
		clientProvider: gitlab.NewClientProvider(op.URN, op.BaseURL, cli, tokenRefresher),
		clientURL:      op.BaseURL,
		codeHost:       extsvc.NewCodeHost(op.BaseURL, extsvc.TypeGitLab),
		db:             op.DB,
	}
}

func (p *OAuthProvider) ValidateConnection(context.Context) (problems []string) {
	return nil
}

func (p *OAuthProvider) URN() string {
	return p.urn
}

func (p *OAuthProvider) ServiceID() string {
	return p.codeHost.ServiceID
}

func (p *OAuthProvider) ServiceType() string {
	return p.codeHost.ServiceType
}

func (p *OAuthProvider) FetchAccount(context.Context, *types.User, []*extsvc.Account, []string) (mine *extsvc.Account, err error) {
	return nil, nil
}

// FetchUserPerms returns a list of private project IDs (on code host) that the given account
// has read access to. The project ID has the same value as it would be
// used as api.ExternalRepoSpec.ID. The returned list only includes private project IDs.
//
// The client used by this method will be in charge of updating the OAuth token
// if it has expired and retrying the request.
//
// This method may return partial but valid results in case of error, and it is up to
// callers to decide whether to discard.
//
// API docs: https://docs.gitlab.com/ee/api/projects.html#list-all-projects
func (p *OAuthProvider) FetchUserPerms(ctx context.Context, account *extsvc.Account, opts authz.FetchPermsOptions) (*authz.ExternalUserPermissions, error) {
	if account == nil {
		return nil, errors.New("no account provided")
	} else if !extsvc.IsHostOfAccount(p.codeHost, account) {
		return nil, errors.Errorf("not a code host of the account: want %q but have %q",
			account.AccountSpec.ServiceID, p.codeHost.ServiceID)
	}

	_, tok, err := gitlab.GetExternalAccountData(ctx, &account.AccountData)
	if err != nil {
		return nil, errors.Wrap(err, "get external account data")
	} else if tok == nil {
		return nil, errors.New("no token found in the external account data")
	}

	tokenRefresher := database.ExternalAccountTokenRefresher(p.db, account.ID, tok.RefreshToken)
	client := p.clientProvider.NewClientWithTokenRefresher(&auth.OAuthBearerToken{Token: tok.AccessToken}, tokenRefresher)
	return listProjects(ctx, client)
}

// FetchRepoPerms returns a list of user IDs (on code host) who have read access to
// the given project on the code host. The user ID has the same value as it would
// be used as extsvc.Account.AccountID. The returned list includes both direct access
// and inherited from the group membership.
//
// This method may return partial but valid results in case of error, and it is up to
// callers to decide whether to discard.
//
// API docs: https://docs.gitlab.com/ee/api/members.html#list-all-members-of-a-group-or-project-including-inherited-members
func (p *OAuthProvider) FetchRepoPerms(ctx context.Context, repo *extsvc.Repository, opts authz.FetchPermsOptions) ([]extsvc.AccountID, error) {
	if repo == nil {
		return nil, errors.New("no repository provided")
	} else if !extsvc.IsHostOfRepo(p.codeHost, &repo.ExternalRepoSpec) {
		return nil, errors.Errorf("not a code host of the repository: want %q but have %q",
			repo.ServiceID, p.codeHost.ServiceID)
	}

	var client *gitlab.Client
	switch p.tokenType {
	case gitlab.TokenTypeOAuth:
		client = p.clientProvider.GetOAuthClient(p.token)
	default:
		client = p.clientProvider.GetPATClient(p.token, "")
	}

	return listMembers(ctx, client, repo.ID)
}
