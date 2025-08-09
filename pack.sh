#!/bin/bash -euxo pipefail

[ -z "$1" ] && { echo "Usage: $0 <build_dir>"; exit 1; }

RELEASE_DIST="head"
BUILD_DIR="$(pwd)/$1"
GITDATE=$(git show -s --date=format:%Y%m%d --format='%ad')
GITREV=$(git show -s --format='%h')
MSVC_SEVENZIP="citra-windows-msvc-${GITDATE}-${GITREV}.7z"

# 清理旧目录
[ -d "$RELEASE_DIST" ] && rm -rf "$RELEASE_DIST"
mkdir -p "$RELEASE_DIST/user"

# 先复制 license 和 README
cp ./license.txt ./README.md "$RELEASE_DIST"/

# 判断复制源
if [ -d "$BUILD_DIR/bundle" ]; then
    cp -r "$BUILD_DIR/bundle"/* "$RELEASE_DIST"/
elif [ -d "$BUILD_DIR/bin/Release" ]; then
    cp -r "$BUILD_DIR/bin/Release"/* "$RELEASE_DIST"/
else
    cp -r "$BUILD_DIR"/* "$RELEASE_DIST"/
fi

# 删除不需要的文件
find "$RELEASE_DIST" -type f \( -iname '*.pdb' -o -iname 'tests.exe' \) -delete

# 打包
echo "output: $MSVC_SEVENZIP"
[ -f "$MSVC_SEVENZIP" ] && rm -f "$MSVC_SEVENZIP"
7z a "$MSVC_SEVENZIP" "$RELEASE_DIST"
