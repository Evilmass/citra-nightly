Revert 1543
==============
d11d600b61e44599a3b7379727263396e51b6ef4

cherry-pick
==============
[commit since=2020-05-11&until=2020-11-13](https://github.com/Evilmass/citra-nightly/commits/master?since=2020-05-11&until=2020-11-13&after=a061457cda396b8dd6a989f1f22987acee9e4441+139)

[Avoid leaking the cubeb input stream](https://github.com/Evilmass/citra-nightly/commit/81a1e5680f93189d6029f579b4b261b2aa552818)

[Actually save the input when clearing/resetting to default](https://github.com/Evilmass/citra-nightly/commit/8d19e144cb46c258107d90d77fb8258a945031d9)

[Don't translate hotkey text](https://github.com/Evilmass/citra-nightly/commit/1d5d278f8d87acf2688b36e157c8b053e71cdd1f)

[Minor frontend fixes to savestates (#5430)](https://github.com/Evilmass/citra-nightly/commit/6a77547bdee43ee67e3199354dd3de22f3b4a232)

[Update translations (2020-07-01)](https://github.com/Evilmass/citra-nightly/commit/add0deb3c5399dbc2dc935cba70d1bf074c3a38f)

[Merge pull request #5163 from z87/input-touch-mapping](https://github.com/Evilmass/citra-nightly/commit/81a1e5680f93189d6029f579b4b261b2aa552818)
 -> `git cherry-pick 81a1e56 -m 1`

<!-- [citra_qt: Improvements to hotkeys and ui state management (#6224)](https://github.com/Evilmass/citra-nightly/commit/f66d03dd48ac81ce0cc0f1d0616d2f07093a59a3)
 -> `Double-click on a binding to change it -> src\citra_qt\configuration\configure_hotkeys.ui -> commit history` -->

<!--
[Automatic Controller Binding (#5100)](https://github.com/Evilmass/citra-nightly/commit/ce16653cc81a1298a34741a7af4808da988a190f) -> `git log --all --regexp-ignore-case --grep="auto mapping"` -->

fix
=============
v1.0.0 Changelog
1. base [nightly1543](d11d600b61e44599a3b7379727263396e51b6ef4)
2. fix submodules: `dynarmic, soundtouch`
3. fix CMakeLists.txt: `ffmpeg-4.2.1-win64, qt-5.10.0-msvc2017_64(add qttools), clang-format-15`
4. update default.ini: `web_api_url, disable telemetry`
5. add submodule `dist/compatibility_list`
6. fix appveyor.yml: `only build msvc`


mscv build only
==============
[Visual Studio 2017 Buildtools](https://aka.ms/vs/15/release/vs_buildtools.exe)

[winsdk](https://download.microsoft.com/download/696beb13-858a-4361-bd85-196f22394c93/KIT_BUNDLE_WINDOWSSDK_MEDIACREATION/winsdksetup.exe)
- only select `Debugging Tools For Windows` -> pdbstr.exe

[Git For Windows](https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe)

[Cmake](https://github.com/Kitware/CMake/releases/download/v4.0.3/cmake-4.0.3-windows-x86_64.msi)

[7z](https://www.7-zip.org/a/7z2500-x64.exe)

<!-- https://www.doxygen.nl/files/doxygen-1.14.0.windows.x64.bin.zip -->

```shell
# git bash
git clone -b 1543 --recursive https://github.com/Evilmass/citra-nightly.git

# cmake
mkdir msvc_build && cd msvc_build
cmake .. -G "Visual Studio 15 2017 Win64" -DCITRA_USE_BUNDLED_QT=1 -DCITRA_USE_BUNDLED_SDL2=1 -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ON
cd ..

## 若你仅修改了源代码，而没有改变 CMakeLists.txt 文件，可以跳过 CMake 配置步骤，直接重新编译。
rm -rf ./CMakeFiles/ && rm -f ./CMakeCache.txt

# build
msbuild msvc_build/citra.sln /p:Configuration=Release /p:Platform=x64 /t:Rebuild /m:8

# pack
bash pack.sh
```

Translation
==============
```shell
# Error:
Could not find a package configuration file provided by "Qt5LinguistTools"
# Fix: add qttools
aqt.exe install-qt --outputdir ./qt-5.10.0-msvc2017_64 windows desktop 5.10.0 win64_msvc2017_64 --archives qtbase qtm ultimedia qttools qttranslations
```

## custom info
CMakeModules\GenerateSCMRev.cmake -> -DBUILD_TAG=MHXX

AppVeyor
==============
[citra-nightly-AppVeyor](https://ci.appveyor.com/project/Evilmass/citra-nightly)

**BEFORE FILING AN ISSUE, READ THE RELEVANT SECTION IN THE [CONTRIBUTING](https://github.com/citra-emu/citra/wiki/Contributing#reporting-issues) FILE!!!**

Citra
==============
[![Travis CI Build Status](https://travis-ci.com/citra-emu/citra.svg?branch=master)](https://travis-ci.com/citra-emu/citra)
[![AppVeyor CI Build Status](https://ci.appveyor.com/api/projects/status/sdf1o4kh3g1e68m9?svg=true)](https://ci.appveyor.com/project/bunnei/citra)
[![Bitrise CI Build Status](https://app.bitrise.io/app/4ccd8e5720f0d13b/status.svg?token=H32TmbCwxb3OQ-M66KbAyw&branch=master)](https://app.bitrise.io/app/4ccd8e5720f0d13b)
[![Discord](https://img.shields.io/discord/220740965957107713?color=%237289DA&label=Citra&logo=discord&logoColor=white)](https://discord.gg/FAXfZV9)

Citra is an experimental open-source Nintendo 3DS emulator/debugger written in C++. It is written with portability in mind, with builds actively maintained for Windows, Linux and macOS.

Citra emulates a subset of 3DS hardware and therefore is useful for running/debugging homebrew applications, and it is also able to run many commercial games! Some of these do not run at a playable state, but we are working every day to advance the project forward. (Playable here means compatibility of at least "Okay" on our [game compatibility list](https://citra-emu.org/game).)

Citra is licensed under the GPLv2 (or any later version). Refer to the license.txt file included. Please read the [FAQ](https://citra-emu.org/wiki/faq/) before getting started with the project.

Check out our [website](https://citra-emu.org/)!

Need help? Check out our [asking for help](https://citra-emu.org/help/reference/asking/) guide.

For development discussion, please join us on our [Discord server](https://citra-emu.org/discord/) or at #citra-dev on freenode.

### Development

Most of the development happens on GitHub. It's also where [our central repository](https://github.com/citra-emu/citra) is hosted.

If you want to contribute please take a look at the [Contributor's Guide](https://github.com/citra-emu/citra/wiki/Contributing) and [Developer Information](https://github.com/citra-emu/citra/wiki/Developer-Information). You should also contact any of the developers in the forum in order to know about the current state of the emulator because the [TODO list](https://docs.google.com/document/d/1SWIop0uBI9IW8VGg97TAtoT_CHNoP42FzYmvG1F4QDA) isn't maintained anymore.

If you want to contribute to the user interface translation, please checkout [citra project on transifex](https://www.transifex.com/citra/citra). We centralize the translation work there, and periodically upstream translation.

### Building

* __Windows__: [Windows Build](https://github.com/citra-emu/citra/wiki/Building-For-Windows)
* __Linux__: [Linux Build](https://github.com/citra-emu/citra/wiki/Building-For-Linux)
* __macOS__: [macOS Build](https://github.com/citra-emu/citra/wiki/Building-for-macOS)


### Support
We happily accept monetary donations or donated games and hardware. Please see our [donations page](https://citra-emu.org/donate/) for more information on how you can contribute to Citra. Any donations received will go towards things like:
* 3DS consoles for developers to explore the hardware
* 3DS games for testing
* Any equipment required for homebrew
* Infrastructure setup

We also more than gladly accept used 3DS consoles! If you would like to give yours away, don't hesitate to join our [Discord server](https://citra-emu.org/discord/) and talk to bunnei.
