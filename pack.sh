#!/bin/bash -ex

RELEASE_DIST="head"
GITDATE=$(git show -s --date=format:%Y%m%d --format='%ad')
GITREV=$(git show -s --format='%h')
MSVC_SEVENZIP="citra-windows-msvc-${GITDATE}-${GITREV}.7z"
echo "output: $MSVC_SEVENZIP"

mkdir -p $RELEASE_DIST/user
cp -r ./msvc_build/bin/Release/* ./license.txt ./README.md $RELEASE_DIST/
find "$RELEASE_DIST" -type f -iname '*.pdb' -print -delete
find "$RELEASE_DIST" -type f -iname 'tests.exe' -print -delete
7z a $MSVC_SEVENZIP $RELEASE_DIST