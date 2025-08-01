#!/bin/bash -ex

GITDATE="`git show -s --date=short --format='%ad' | sed 's/-//g'`"
GITREV="`git show -s --format='%h'`"
REV_NAME="citra-${OS}-${TARGET}-${GITDATE}-${GITREV}"
RELEASE_NAME=head


mkdir -p artifacts
ls D:/a/citra-nightly/citra-nightly/build/bin/Release/x64/*
find D:/a/citra-nightly/citra-nightly/build/bin/Release/x64/* -name "*.mv" ! -name "*.pdb" ! -name "tests.exe" -exec mv {} "$RELEASE_NAME" \;
7z a "$REV_NAME.7z" $RELEASE_NAME
mv "$REV_NAME.7z" artifacts/