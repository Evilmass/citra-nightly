#!/bin/sh -ex

mkdir build && cd build
# cmake .. -G "Visual Studio 15 2017 Win64" -A x64 \
cmake .. -G "Visual Studio 17 2022" -A x64 \
    -DCMAKE_C_COMPILER="C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\cl.exe" \
    -DCMAKE_CXX_COMPILER="C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Tools\MSVC\14.44.35207\bin\HostX64\x64\cl.exe" \
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
cd ..
msbuild build/citra.sln \
    -property:Configuration=Release,Platform=x64 \
    -maxCpuCount \
    -target:Rebuild
ctest -VV -C Release || echo "::error ::Test error occurred on Windows build"