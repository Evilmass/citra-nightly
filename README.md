## citra-mhxx

Custom-built emulator based on [nightly 1543](https://web.archive.org/web/20220908222930/https://github.com/citra-emu/citra-nightly/releases/tag/nightly-1543) → [last build before the core timing rewrite](https://web.archive.org/web/20230603005840/https://citra-emu.org/wiki/citra-legacy-builds/#last-build-before-the-core-timing-rewrite), optimized for Monster Hunter Double Cross

- **Fix lag:** Periodic slowdowns with frame drops
- **Port functions:** Touch-mapping, fix SaveStates hotkeys

Inspired by
- [Lurpigi/Lime3DS](https://github.com/Lurpigi/lime3ds-dqmj3p)
- [Slashaim/citra-dqmj3pro](https://github.com/Slashaim/citra-dqmj3pro)

---

## Build Tools

- [VS2022 Build Tools](https://aka.ms/vs/17/release/vs_buildtools.exe)

  `Windows 10 SDK (10.0.19041.0) + MSVC v141 VS2017 C++ x64-86 BuildTools (v14.16.27023)`
- [Git](https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe)
- [CMake](https://github.com/Kitware/CMake/releases/download/v4.0.3/cmake-4.0.3-windows-x86_64.msi)
- [ccache](https://github.com/ccache/ccache/releases/download/v4.11.3/ccache-4.11.3-windows-x86_64.zip)
- [7-Zip](https://www.7-zip.org/a/7z2500-x64.exe)

---

## MSVC Build

```sh
# git-bash --login -i
git clone -b 1543 --recursive https://github.com/Evilmass/citra-nightly.git

# cmake
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -A x64 -T v141 -DCMAKE_SYSTEM_VERSION=10.0.19041.0 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCITRA_USE_BUNDLED_QT=1 -DCITRA_USE_BUNDLED_SDL2=1 -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ON

# clear
rm -rf build/bin

# build
msbuild build/citra.sln -property:Configuration=Release,Platform=x64 -maxCpuCount -target:Rebuild

# pack
bash pack.sh build/
```

---

## AppVeyor

Full build logs: [https://ci.appveyor.com/project/Evilmass/citra-nightly](https://ci.appveyor.com/project/Evilmass/citra-nightly)


## Note
```shell
# aqtinstall
aqt.exe install-qt windows desktop 5.10.0 win64_msvc2017_64 -m qtmultimedia --outputdir ./qt-5.10.0-msvc2017_64 # qttranslations

# github actions shell permission denied
git update-index --chmod=+x ./.ci/source.sh
git update-index --chmod=+x ./.ci/pack.sh
git update-index --chmod=+x ./.ci/windows.sh
git commit -m "Fix: Add execute permission to source.sh and windows.sh"
git push
```

## Original README

See [ORIGINAL_README](./ORIGINAL_README.md)

---