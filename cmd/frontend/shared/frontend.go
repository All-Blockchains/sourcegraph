// Package shared contains the frontend command implementation shared
package shared

import (
	"fmt"
	"os"

	"github.com/sourcegraph/sourcegraph/cmd/frontend/enterprise"
	"github.com/sourcegraph/sourcegraph/cmd/frontend/internal/cli"
	"github.com/sourcegraph/sourcegraph/internal/codeintel"
	"github.com/sourcegraph/sourcegraph/internal/conf/conftypes"
	"github.com/sourcegraph/sourcegraph/internal/database"
	"github.com/sourcegraph/sourcegraph/internal/env"

	_ "github.com/sourcegraph/sourcegraph/cmd/frontend/registry/api"
)

// Main is the main function that runs the frontend process.
//
// It is exposed as function in a package so that it can be called by other
// main package implementations such as Sourcegraph Enterprise, which import
// proprietary/private code.
func Main(enterpriseSetupHook func(db database.DB, codeIntelServices codeintel.Services, conf conftypes.UnifiedWatchable) enterprise.Services) {
	env.Lock()
	err := cli.Main(enterpriseSetupHook)
	if err != nil {
		fmt.Fprintln(os.Stderr, "fatal:", err)
		os.Exit(1)
	}
}
