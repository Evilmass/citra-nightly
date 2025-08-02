#!/usr/bin/env bash
set -e

GITDATE="$(git show -s --date=short --format='%ad' | sed 's/-//g')"
GITREV="$(git show -s --format='%h')"
REV_NAME="citra-windows-msvc-${GITDATE}-${GITREV}"
RELEASE_NAME=head
mkdir -p "$RELEASE_NAME"/user
shopt -s extglob
mv build/bin/Release/!(tests.exe|*.pdb) "$RELEASE_NAME"
7z a "$REV_NAME.7z" $RELEASE_NAME
mkdir -p artifacts
mv "$REV_NAME.7z" artifacts/
