#!/bin/sh -ex

mkdir build && cd build
cmake .. -G "Visual Studio 17 2022" -A x64 -DCITRA_USE_BUNDLED_QT=1 -DCITRA_USE_BUNDLED_SDL2=1 -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ON
cd ..
msbuild build/citra.sln -t:rebuild -verbosity:diag -property:Configuration=Release -property:Platform=x64
ctest -VV -C Release || echo "::error ::Test error occurred on Windows MSVC build"
