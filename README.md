# Original Repo README

See [ORIGINAL_REPO_README](./ORIGINAL_REPO_README.md)

---

## citra-mhxx

Custom-built emulator based on [nightly 1543](https://web.archive.org/web/20220908222930/https://github.com/citra-emu/citra-nightly/releases/tag/nightly-1543) → [last build before the core timing rewrite](https://web.archive.org/web/20230603005840/https://citra-emu.org/wiki/citra-legacy-builds/#last-build-before-the-core-timing-rewrite), optimized for Monster Hunter Double Cross

- **Fix lag:** Periodic slowdowns with frame drops
- **Port functions:** Touch-mapping, fix SaveStates hotkeys

Inspired by
- [Lurpigi/Lime3DS](https://github.com/Lurpigi/lime3ds-dqmj3p)
- [Slashaim/citra-dqmj3pro](https://github.com/Slashaim/citra-dqmj3pro)

**Warning**
- Do not cherry-pick this commit: [Update FPS to roughly match the actual 3DS rate](https://github.com/Evilmass/citra-nightly/commit/5e95b35900bb8c840169c4446634ff67982aa842), It will cause the frame rate to randomly drop to 56.
- also keep `src\core\hw\gpu.h -> SCREEN_REFRESH_RATE = 60`

---

## TODO

- [ ] [QT: Add Custom Layout Menu Option](https://github.com/Lurpigi/lime3ds-dqmj3p/commit/0313178d32c70445a85580c67dcaf1fc69ac19d4)
- [ ] Restore all hotkeys
- [ ] [citra_qt: Improvements to hotkeys and UI state management (#6224)](https://github.com/Evilmass/citra-nightly/commit/f66d03dd48ac81ce0cc0f1d0616d2f07093a59a3)
- [ ] [Automatic Controller Binding (#5100)](https://github.com/Evilmass/citra-nightly/commit/ce16653cc81a1298a34741a7af4808da988a190f)
  → `git log --all --regexp-ignore-case --grep="auto mapping"`

---

## Changelog

### v1.0.0

1. Reset --hard from [nightly1543](d11d600b61e44599a3b7379727263396e51b6ef4)
2. Fix submodules: `dynarmic`, `soundtouch`
3. Fix CMakeLists.txt: `ffmpeg-4.2.1-win64`, `qt-5.10.0-msvc2017_64` (add qttools), `clang-format-15`
4. Update default.ini: `web_api_url`, disable telemetry
5. Add submodule `dist/compatibility_list`
6. Fix appveyor.yml: only build MSVC

### v1.1.0

1. Cherry-pick [Avoid leaking the cubeb input stream](https://github.com/Evilmass/citra-nightly/commit/81a1e5680f93189d6029f579b4b261b2aa552818)
2. Cherry-pick [Actually save the input when clearing/resetting to default](https://github.com/Evilmass/citra-nightly/commit/8d19e144cb46c258107d90d77fb8258a945031d9)
3. Merge [input-touch-mapping](https://github.com/Evilmass/citra-nightly/commit/81a1e5680f93189d6029f579b4b261b2aa552818)
4. Merge [save_default_controls](https://github.com/Evilmass/citra-nightly/commit/76253063a37e70733ac3ede712cd18cfcdff5bd6)
5. Cherry-pick [Minor frontend fixes to savestates (#5430)](https://github.com/Evilmass/citra-nightly/commit/6a77547bdee43ee67e3199354dd3de22f3b4a232)

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
mkdir build && cd build
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -A x64 -T v141 -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_SYSTEM_VERSION=10.0.19041.0 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCITRA_USE_BUNDLED_QT=1 -DCITRA_USE_BUNDLED_SDL2=1 -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ONcd ..

# If you did not modify CMakeLists.txt, skip CMake configuration and recompile directly
# rm -rf ./CMakeFiles/ && rm -f ./CMakeCache.txt

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