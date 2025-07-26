ORIGINAL README
========
[ORIGINAL_README](./ORIGINAL_README.md)

# citra-mhxx

custom-built emulator based [nightly 1543](https://web.archive.org/web/20220908222930/https://github.com/citra-emu/citra-nightly/releases/tag/nightly-1543) -> [the last build before the core timing rewrite](https://web.archive.org/web/20230603005840/https://citra-emu.org/wiki/citra-legacy-builds/#last-build-before-the-core-timing-rewrite), optimized for monster hunter double cross
- fix lag: `periodic slowdowns with frame drops`
- port some functions: `touch-mapping, fix SaveStaes key`

This fork was inspired by Lurpigi's fork

- [Lurpigi/Lime3DS](https://github.com/Lurpigi/lime3ds-dqmj3p)

## buildtools

- [Visual Studio 2017](https://aka.ms/vs/15/release/vs_buildtools.exe)
- [Git](https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe)
- [Cmake](https://github.com/Kitware/CMake/releases/download/v4.0.3/cmake-4.0.3-windows-x86_64.msi)
- [7z](https://www.7-zip.org/a/7z2500-x64.exe)


## mscv build
```shell
# git bash
git clone -b mhxx --recursive https://github.com/Evilmass/citra-nightly.git

# cmake
mkdir msvc_build && cd msvc_build
cmake .. -G "Visual Studio 15 2017 Win64" -DCITRA_USE_BUNDLED_QT=1 -DCITRA_USE_BUNDLED_SDL2=1 -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ON
cd ..

# if u not modified CMakeLists.txt file, skip the CMake configuration step and recompile directly
# rm -rf ./CMakeFiles/ && rm -f ./CMakeCache.txt

# build
rm -rf msvc_build/bin
msbuild msvc_build/citra.sln /p:Configuration=Release /p:Platform=x64 /t:Rebuild /m:8

# pack
bash pack.sh
```


## appveyor

check build logs: [https://ci.appveyor.com/project/Evilmass/citra-nightly](https://ci.appveyor.com/project/Evilmass/citra-nightly)


## changelog

### v1.0.0

1. reset --hard from [nightly1543](d11d600b61e44599a3b7379727263396e51b6ef4)
2. fix submodules: `dynarmic, soundtouch`
3. fix CMakeLists.txt: `ffmpeg-4.2.1-win64, qt-5.10.0-msvc2017_64(add qttools), clang-format-15`
4. update default.ini: `web_api_url, disable telemetry`
5. add submodule `dist/compatibility_list`
6. fix appveyor.yml: `only build msvc`
7. rename main title: `citra-mhxx`


## cherry-pick

- [ ] [Avoid leaking the cubeb input stream](https://github.com/Evilmass/citra-nightly/commit/81a1e5680f93189d6029f579b4b261b2aa552818)
- [ ] [Actually save the input when clearing/resetting to default](https://github.com/Evilmass/citra-nightly/commit/8d19e144cb46c258107d90d77fb8258a945031d9)
- [ ] [Don't translate hotkey text](https://github.com/Evilmass/citra-nightly/commit/1d5d278f8d87acf2688b36e157c8b053e71cdd1f)
- [ ] [Minor frontend fixes to savestates (#5430)](https://github.com/Evilmass/citra-nightly/commit/6a77547bdee43ee67e3199354dd3de22f3b4a232)
- [ ] [Update translations (2020-07-01)](https://github.com/Evilmass/citra-nightly/commit/add0deb3c5399dbc2dc935cba70d1bf074c3a38f)
- [ ] [Merge pull request #5163 from z87/input-touch-mapping](https://github.com/Evilmass/citra-nightly/commit/81a1e5680f93189d6029f579b4b261b2aa552818)
  -> `git cherry-pick 81a1e56 -m 1`
- [ ] [citra_qt: Improvements to hotkeys and ui state management (#6224)](https://github.com/Evilmass/citra-nightly/commit/f66d03dd48ac81ce0cc0f1d0616d2f07093a59a3)
- [ ] [Automatic Controller Binding (#5100)](https://github.com/Evilmass/citra-nightly/commit/ce16653cc81a1298a34741a7af4808da988a190f)
  -> `git log --all --regexp-ignore-case --grep="auto mapping"`