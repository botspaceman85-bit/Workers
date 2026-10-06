#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-}"

if [[ -n "$TAG" ]]; then
    gh release delete "$TAG" \
        --repo "$GITHUB_REPOSITORY" \
        --yes 2>/dev/null || true
fi

rm -rf \
    "$RUNNER_TEMP/source" \
    "$RUNNER_TEMP/project"

echo "Cleanup complete"
