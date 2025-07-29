#!/bin/sh -ex

mkdir build && cd build
cmake .. -Wno-dev -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER_LAUNCHER=ccache \
    -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
    -DCITRA_USE_BUNDLED_QT=1 \
    -DCITRA_USE_BUNDLED_SDL2=1 \
    -DENABLE_QT_TRANSLATION=ON \
    -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF \
    -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=ON \
    -DUSE_DISCORD_PRESENCE=ON \
    -DENABLE_FFMPEG_VIDEO_DUMPER=ON \
    -DENABLE_MF=ON
ninja
ninja bundle
ccache -s -v
ctest -VV -C Release || echo "::error ::Test error occurred on Windows build"