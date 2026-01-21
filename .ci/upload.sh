#!/bin/bash -ex

# ci/cd
git config --global --add safe.directory /__w/citra-nightly/citra-nightly

# preupload
GITDATE="`git show -s --date=short --format='%ad' | sed 's/-//g'`"
GITREV="`git show -s --format='%h'`"

mkdir -p artifacts

# pack
REV_NAME="citra-linux-${GITDATE}-${GITREV}"
ARCHIVE_NAME="${REV_NAME}.tar.xz"
COMPRESSION_FLAGS="-cJvf"

mkdir "$REV_NAME"

cp build/bin/Release/citra "$REV_NAME"
cp build/bin/Release/citra-room "$REV_NAME"
cp build/bin/Release/citra-qt "$REV_NAME"

# We need icons on Linux for .desktop entries
mkdir "$REV_NAME/dist"
cp dist/icon.png "$REV_NAME/dist/citra.png"

# upload
# Copy documentation
cp license.txt "$REV_NAME"
cp README.md "$REV_NAME"

# Copy cross-platform scripting support
cp -r dist/scripting "$REV_NAME"

tar $COMPRESSION_FLAGS "$ARCHIVE_NAME" "$REV_NAME"

# Find out what release we are building
if [ -z $GIT_TAG_NAME ]; then
    RELEASE_NAME=head
else
    RELEASE_NAME=$(echo $GIT_TAG_NAME | cut -d- -f1)
    if [ "$NAME" = "linux-mingw" ]; then
        RELEASE_NAME="${RELEASE_NAME}-mingw"
    fi
fi

mv "$REV_NAME" $RELEASE_NAME

7z a "$REV_NAME.7z" $RELEASE_NAME

# move the compiled archive into the artifacts directory to be uploaded by travis releases
mv "$ARCHIVE_NAME" artifacts/
mv "$REV_NAME.7z" artifacts/