#!/bin/bash -euxo pipefail

[ -z "$1" ] && { echo "Usage: $0 <build_dir>"; exit 1; }

RELEASE_DIST="head"
BUILD_DIR=$(pwd)/$1
GITDATE=$(git show -s --date=format:%Y%m%d --format='%ad')
GITREV=$(git show -s --format='%h')
MSVC_SEVENZIP="citra-windows-msvc-${GITDATE}-${GITREV}.7z"
echo "output: $MSVC_SEVENZIP"

[ -d "$RELEASE_DIST" ] && rm -rf "$RELEASE_DIST"
mkdir -p "$RELEASE_DIST/user"
cp -r "$BUILD_DIR/bin/Release"/* ./license.txt ./README.md "$RELEASE_DIST/"
find "$RELEASE_DIST" -type f \( -iname '*.pdb' -o -iname 'tests.exe' \) -delete

[ -f "$MSVC_SEVENZIP" ] && rm -f "$MSVC_SEVENZIP"
# 7z a "$MSVC_SEVENZIP" "$RELEASE_DIST"