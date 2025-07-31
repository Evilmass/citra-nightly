#!/bin/sh -ex

# "C:\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64
# mkdir build && cd build
# cmake .. -G "Visual Studio 17 2022" -A x64 -T v141 \
#     -DCMAKE_BUILD_TYPE=Release \
#     -DCITRA_USE_BUNDLED_QT=1 \
#     -DCITRA_USE_BUNDLED_SDL2=1 \
#     -DENABLE_QT_TRANSLATION=ON \
#     -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF \
#     -DUSE_DISCORD_PRESENCE=OFF \
#     -DENABLE_FFMPEG_VIDEO_DUMPER=ON \
#     -DENABLE_MF=ON\
# cd ..
# msbuild build/citra.sln -property:Configuration=Release,Platform=x64 -maxCpuCount -target:Rebuild

mkdir build && cd build

cmake .. -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER="C:\BuildTools\VC\Tools\MSVC\14.16.27023\bin\HostX86\x64\cl.exe" \
    -DCMAKE_CXX_COMPILER="C:\BuildTools\VC\Tools\MSVC\14.16.27023\bin\HostX86\x64\cl.exe" \
    -DCITRA_USE_BUNDLED_QT=1 \
    -DCITRA_USE_BUNDLED_SDL2=1 \
    -DENABLE_QT_TRANSLATION=ON \
    -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF \
    -DUSE_DISCORD_PRESENCE=OFF \
    -DENABLE_FFMPEG_VIDEO_DUMPER=ON \
    -DENABLE_MF=ON
ninja
ninja bundle
strip -s bundle/*.exe

ccache -s -v

ctest -VV -C Release || echo "::error ::Test error occurred on Windows build"