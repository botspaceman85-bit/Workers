#!/usr/bin/env bash
set -euo pipefail

PROJECT="${1:?Project wajib diberikan}"

APK="$(
    find "$PROJECT/build/app/outputs/apk" \
        -type f \
        -name "*.apk" \
        -print |
    head -n 1
)"

if [[ -z "$APK" ]]; then
    echo "APK tidak ditemukan" >&2
    exit 1
fi

if [[ ! -s "$APK" ]]; then
    echo "APK kosong" >&2
    exit 1
fi

echo "$APK"
