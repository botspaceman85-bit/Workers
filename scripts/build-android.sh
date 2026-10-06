#!/usr/bin/env bash
set -euo pipefail

PROJECT="${1:?Project wajib diberikan}"
TYPE="${2:-release}"

cd "$PROJECT"

test -f pubspec.yaml

echo "Getting dependencies..."

flutter pub get --no-example

echo "Building Android..."

if [[ "$TYPE" == "debug" ]]; then

    flutter build apk \
        --debug \
        --no-pub

else

    flutter build apk \
        --release \
        --no-pub \
        --no-tree-shake-icons
fi

echo "BUILD FINISHED"
