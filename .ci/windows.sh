#!/bin/sh -ex

call "C:\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64
mkdir build && cd build
cmake .. -G "Visual Studio 17 2022" -A x64 -T v141 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCITRA_USE_BUNDLED_QT=1 \
    -DCITRA_USE_BUNDLED_SDL2=1 \
    -DENABLE_QT_TRANSLATION=ON \
    -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF \
    -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF \
    -DUSE_DISCORD_PRESENCE=OFF \
    -DENABLE_FFMPEG_VIDEO_DUMPER=ON \
    -DENABLE_MF=ON
cd ..
msbuild build/citra.sln -property:Configuration=Release,Platform=x64 -maxCpuCount -target:Rebuild
ctest -VV -C Release || echo "::error ::Test error occurred on Windows build"