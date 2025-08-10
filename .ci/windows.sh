#!/usr/bin/env bash
set -e

mkdir -p build
cmake -S . -B build -G "Visual Studio 17 2022" -A x64 -T v142 \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCITRA_USE_BUNDLED_QT=1 \
    -DENABLE_QT_TRANSLATION=ON \
    -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF \
    -DUSE_DISCORD_PRESENCE=OFF \
    -DENABLE_FFMPEG_VIDEO_DUMPER=ON \
    -DENABLE_MF=ON
"C:/BuildTools/MSBuild/Current/Bin/MSBuild.exe" build/citra.sln \
  -property:Configuration=Release,Platform=x64 \
  -maxCpuCount \
  -target:Rebuild

dir build/bin/Release