# 设置环境变量
& "C:\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64

# 创建并进入构建目录
mkdir build
cd build

# 运行 CMake
cmake .. -G "Visual Studio 17 2022" -A x64 -T v141 `
    -DCMAKE_BUILD_TYPE=Release `
    -DCITRA_USE_BUNDLED_QT=1 `
    -DCITRA_USE_BUNDLED_SDL2=1 `
    -DENABLE_QT_TRANSLATION=ON `
    -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF `
    -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF `
    -DUSE_DISCORD_PRESENCE=OFF `
    -DENABLE_FFMPEG_VIDEO_DUMPER=ON `
    -DENABLE_MF=ON

cd ..
# 运行 MSBuild
msbuild build/citra.sln -property:Configuration=Release,Platform=x64 -maxCpuCount -target:Rebuild

# 运行测试
ctest -VV -C Release
if ($LASTEXITCODE -ne 0) {
    Write-Error "Test error occurred on Windows build"
    exit 1
}