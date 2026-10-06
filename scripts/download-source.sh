#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-zip}"
TAG="${2:-}"
URL="${3:-}"

SOURCE="$RUNNER_TEMP/source"
PROJECT="$RUNNER_TEMP/project"

rm -rf "$SOURCE" "$PROJECT"
mkdir -p "$SOURCE" "$PROJECT"

if [[ "$MODE" == "zip" ]]; then

    test -n "$TAG" || {
        echo "Source tag kosong"
        exit 1
    }

    gh release download "$TAG" \
        --repo "$GITHUB_REPOSITORY" \
        --pattern "*.zip" \
        --dir "$SOURCE"

else

    test -n "$URL" || {
        echo "Source URL kosong"
        exit 1
    }

    curl -fL \
        --retry 4 \
        --retry-delay 1 \
        --connect-timeout 15 \
        --max-time 300 \
        "$URL" \
        -o "$SOURCE/source.zip"
fi

ZIP="$(find "$SOURCE" \
    -maxdepth 1 \
    -type f \
    -name "*.zip" \
    -print -quit)"

test -n "$ZIP" || {
    echo "ZIP source tidak ditemukan"
    exit 1
}

unzip -q "$ZIP" -d "$PROJECT"

echo "Source ready"
