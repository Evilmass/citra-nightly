#!/bin/sh -ex

mkdir build && cd build
cmake .. -Wno-dev -G "Visual Studio 15 2017 Win64" -DCITRA_USE_BUNDLED_QT=1 -DCITRA_USE_BUNDLED_SDL2=1 -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ON
cd ..
msbuild build/citra.sln /p:Configuration=Release /m /p:Platform=x64 /t:Rebuild
ctest -VV -C Release || echo "::error ::Test error occurred on Windows MSVC build"
