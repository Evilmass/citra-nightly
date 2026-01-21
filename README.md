1671 auto mapping button revert core timing
==============

Custom-built emulator optimized for Monster Hunter Double Cross
- **Fix lag:** Periodic slowdowns with frame drops
- **Port functions:** Touch-mapping, fix SaveStates hotkeys

Inspired by
- [Lurpigi/Lime3DS](https://github.com/Lurpigi/lime3ds-dqmj3p)
- [Slashaim/citra-dqmj3pro](https://github.com/Slashaim/citra-dqmj3pro)


## buildtools
- **[VS2022_BuildTools](https://aka.ms/vs/17/release/vs_buildtools.exe)**
- **[Vulkan SDK 1.4.304.1](https://sdk.lunarg.com/sdk/download/1.4.304.1/windows/VulkanSDK-1.4.304.1-Installer.exe)**
- **[Cmake](https://github.com/Kitware/CMake/releases/download/v4.0.3/cmake-4.0.3-windows-x86_64.msi)**
- **[Git](https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe)**
- **[7z](https://www.7-zip.org/a/7z2500-x64.exe)**


## build

```shell
git clone -b 1671 --recursive https://github.com/Evilmass/citra-nightly

# msvc 2017
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -A x64 -T v142 -DCMAKE_SYSTEM_VERSION=10.0.19041.0 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DENABLE_QT_TRANSLATION=OFF -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF -DUSE_DISCORD_PRESENCE=OFF
rm -rf build/bin && msbuild build/citra.sln -m -p:Configuration=Release,Platform=x64 -t:Rebuild

# pack
bash pack.sh build/
```

## Note
```shell
# aqtinstall
aqt.exe install-qt windows desktop 5.10.0 win64_msvc2017_64 -m qtmultimedia --outputdir ./qt-5.10.0-msvc2017_64 # qttranslations

# github actions shell permission denied
git update-index --chmod=+x .ci\source.sh
git update-index --chmod=+x .ci\windows.sh
git commit -m "Fix: Add execute permission to source.sh and windows.sh"
git push
```

## Docker
```sh
sudo apt install libqt5multimedia5-plugins
# docker pull evi1docker/build-environments:linux-appimage
git clone -b 1671 --recursive https://github.com/Evilmass/citra-nightly/ app
docker run --rm -v ./app:/app -w /app \
 evi1docker/build-environments:linux-appimage \
 /bin/sh -c "git config --global --add safe.directory /app && ./.ci/linux.sh"
```

[ORIGINAL_README](./ORIGINAL_README.md)