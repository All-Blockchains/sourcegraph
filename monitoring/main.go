//go:generate go build -o /tmp/monitoring-generator
//go:generate /tmp/monitoring-generator
package main

import (
	"os"

	"github.com/sourcegraph/log"
	"github.com/urfave/cli/v2"

	"github.com/sourcegraph/sourcegraph/internal/hostname"
	"github.com/sourcegraph/sourcegraph/internal/version"
	"github.com/sourcegraph/sourcegraph/monitoring/command"
)

func main() {
	// Configure logger
	if _, set := os.LookupEnv(log.EnvDevelopment); !set {
		os.Setenv(log.EnvDevelopment, "true")
	}
	if _, set := os.LookupEnv(log.EnvLogFormat); !set {
		os.Setenv(log.EnvLogFormat, "console")
	}

	liblog := log.Init(log.Resource{
		Name:       "monitoring-generator",
		Version:    version.Version(),
		InstanceID: hostname.Get(),
	})
	defer liblog.Sync()
	logger := log.Scoped("monitoring", "main Sourcegraph monitoring entrypoint")

	// Create an app that only runs the generate command
	app := &cli.App{
		Name: "monitoring-generator",
		Commands: []*cli.Command{
			command.Generate("", "../"),
		},
		DefaultCommand: "generate",
	}
	if err := app.Run([]string{""}); err != nil {
		// Render in plain text for human readability
		println(err.Error())
		logger.Fatal("error encountered")
	}
}
