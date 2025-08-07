#!/usr/bin/env bash
set -e

mkdir -p build
cmake -S . -B build -G "Visual Studio 17 2022" -A x64 -T v141 \
    -DCMAKE_SYSTEM_VERSION=10.0.19041.0 \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DUSE_CCACHE=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE="$(pwd)/../CMakeModules/MSVCCache.cmake" \
    -DCITRA_USE_BUNDLED_QT=1 \
    -DCITRA_USE_BUNDLED_SDL2=1 \
    -DENABLE_QT_TRANSLATION=OFF \
    -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF \
    -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF \
    -DUSE_DISCORD_PRESENCE=OFF \
    -DENABLE_FFMPEG_VIDEO_DUMPER=ON \
    -DENABLE_MF=ON
"C:/BuildTools/MSBuild/Current/Bin/MSBuild.exe" build/citra.sln \
  -property:Configuration=Release,Platform=x64 \
  -maxCpuCount \
  -target:Rebuild

ctest -VV -C Release || echo "::error ::Test error occurred on Windows MSVC build"

dir build/bin/Release