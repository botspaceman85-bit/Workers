#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:?ROOT wajib diberikan}"

if [[ -f "$ROOT/pubspec.yaml" ]]; then
    echo "Flutter project: $ROOT"
    exit 0
fi

PROJECT="$(
    find "$ROOT" \
        -maxdepth 7 \
        -type f \
        -name "pubspec.yaml" \
        -print -quit |
    xargs -r dirname
)"

if [[ -z "$PROJECT" ]]; then
    echo "Flutter project tidak ditemukan"
    exit 1
fi

echo "Flutter project: $PROJECT"
