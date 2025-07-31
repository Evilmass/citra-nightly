# Run the Visual Studio environment setup
& "C:\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64

# Create and enter build directory
New-Item -ItemType Directory -Path "build" -Force | Out-Null
Set-Location -Path "build"

# Run CMake with all the parameters
cmake .. -G "Visual Studio 17 2022" -A "x64" -T "v141" `
    -DCMAKE_BUILD_TYPE="Release" `
    -DCITRA_USE_BUNDLED_QT="1" `
    -DCITRA_USE_BUNDLED_SDL2="1" `
    -DENABLE_QT_TRANSLATION="ON" `
    -DCITRA_ENABLE_COMPATIBILITY_REPORTING="OFF" `
    -DUSE_DISCORD_PRESENCE="OFF" `
    -DENABLE_FFMPEG_VIDEO_DUMPER="ON" `
    -DENABLE_MF="ON"

# Return to parent directory
Set-Location -Path ".."

# Build the solution
& "C:\BuildTools\MSBuild\Current\Bin\MSBuild.exe" "build/citra.sln" "-property:Configuration=Release,Platform=x64" "-maxCpuCount" "-target:Rebuild"