#!/bin/bash -ex

GITDATE="`git show -s --date=short --format='%ad' | sed 's/-//g'`"
GITREV="`git show -s --format='%h'`"
REV_NAME="citra-${OS}-${TARGET}-${GITDATE}-${GITREV}"

# Find out what release we are building
if [[ "$GITHUB_REF_NAME" =~ ^canary- ]] || [[ "$GITHUB_REF_NAME" =~ ^nightly- ]]; then
    RELEASE_NAME=$(echo $GITHUB_REF_NAME | cut -d- -f1)
else
    RELEASE_NAME=head
fi

mkdir -p artifacts

if [ -z "${UPLOAD_RAW}" ]; then
    if [ "$OS" = "windows" ]; then
        ARCHIVE_NAME="${REV_NAME}.7z"
        7z a "$ARCHIVE_NAME" bundle/*
    else
        ARCHIVE_NAME="${REV_NAME}.tar.gz"
        tar czvf "$ARCHIVE_NAME" -C bundle .
    fi
    mv "$ARCHIVE_NAME" artifacts/
else
    # 直接上传原始文件（按需修改）
    for ARTIFACT in bundle/*; do
        FILENAME=$(basename "$ARTIFACT")
        EXTENSION="${FILENAME##*.}"
        mv "$ARTIFACT" "artifacts/$REV_NAME.$EXTENSION"
    done
fi