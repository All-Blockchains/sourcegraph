package ci

import "github.com/sourcegraph/sourcegraph/enterprise/dev/ci/internal/buildkite"

func withYarnCache() buildkite.StepOpt {
	return buildkite.Cache(&buildkite.CacheOptions{
		ID:          "node_modules_yarn_v3",
		Key:         "cache-node_modules-yarn_v3-{{ checksum 'yarn.lock' }}",
		RestoreKeys: []string{"cache-node_modules-yarn_v3-{{ checksum 'yarn.lock' }}"},
		Paths:       []string{"node_modules", ".yarn/cache"},
		// Compressing really slows down the process, as the node modules folder is huge. It's faster to just DL it.
		Compress: false,
	})
}

func withBundleSizeCache(commit string) buildkite.StepOpt {
	return buildkite.Cache(&buildkite.CacheOptions{
		ID:          "bundle_size_cache",
		Key:         "bundle_size_cache-{{ git.commit }}",
		RestoreKeys: []string{"bundle_size_cache-{{ git.commit }}"},
		Paths:       []string{"ui/assets/stats-" + commit + ".json"},
		Compress:    true,
	})
}
