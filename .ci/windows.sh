#!/bin/sh -ex

mkdir build && cd build
cmake .. -G "Visual Studio 17 2022" -A x64 \
    -DCMAKE_GENERATOR_TOOLSET=v141 \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCITRA_USE_BUNDLED_QT=1 \
    -DCITRA_USE_BUNDLED_SDL2=1 \
    -DENABLE_QT_TRANSLATION=ON \
    -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF \
    -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=ON \
    -DUSE_DISCORD_PRESENCE=ON \
    -DENABLE_FFMPEG_VIDEO_DUMPER=ON \
    -DENABLE_MF=ON
msbuild build/citra.sln /m /p:Configuration=Release,Platform=x64 /t:Rebuild
ctest -VV -C Release || echo "::error ::Test error occurred on Windows build"