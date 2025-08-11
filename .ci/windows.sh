#!/bin/sh -ex

mkdir build && cd build
cmake .. -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER_LAUNCHER=ccache \
    -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
    -DENABLE_QT_TRANSLATION=ON \
    -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF \
    -DUSE_DISCORD_PRESENCE=OFF
ninja
ninja bundle

ccache -s

ctest -VV -C Release || echo "::error ::Test error occurred on Windows build"
