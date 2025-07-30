1671

- auto mapping button
- revert core timing
- revert roughly match the actual 3DS rate (also need fix `src\core\hw\gpu.cpp` -> `const u64 frame_ticks = static_cast<u64>(BASE_CLOCK_RATE_ARM11 / SCREEN_REFRESH_RATE);`)


mscv build
==============
<!-- [Visual Studio 2017 BuildTools](https://aka.ms/vs/15/release/vs_buildtools.exe) -->
[Visual Studio 2022 BuildTools](https://aka.ms/vs/17/release/vs_buildtools.exe)
<!-- [winsdk](https://download.microsoft.com/download/696beb13-858a-4361-bd85-196f22394c93/KIT_BUNDLE_WINDOWSSDK_MEDIACREATION/winsdksetup.exe)
- only select `Debugging Tools For Windows` -> pdbstr.exe -->
[Git For Windows](https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe)
[Cmake](https://github.com/Kitware/CMake/releases/download/v4.0.3/cmake-4.0.3-windows-x86_64.msi)
[7z](https://www.7-zip.org/a/7z2500-x64.exe)
<!-- https://www.doxygen.nl/files/doxygen-1.14.0.windows.x64.bin.zip -->

```shell
# git bash
git clone -b 1671 --recursive https://github.com/Evilmass/citra-nightly.git

# cmake
mkdir msvc_build && cd msvc_build
# VS2017
# cmake .. -G "Visual Studio 15 2017 Win64"
cmake .. -G "Visual Studio 17 2022" -A x64 -DCMAKE_GENERATOR_TOOLSET=v141 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCITRA_USE_BUNDLED_QT=1 -DCITRA_USE_BUNDLED_SDL2=1 -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ON
cd ..

## 若你仅修改了源代码，而没有改变 CMakeLists.txt 文件，可以跳过 CMake 配置步骤，直接重新编译。
# rm -rf ./CMakeFiles/ && rm -f ./CMakeCache.txt

# build
"C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\amd64\MSBuild.exe"
msbuild msvc_build/citra.sln /m /p:Configuration=Release,Platform=x64 /t:Rebuild

# pack
bash pack.sh
```

**BEFORE FILING AN ISSUE, READ THE RELEVANT SECTION IN THE [CONTRIBUTING](https://github.com/citra-emu/citra/wiki/Contributing#reporting-issues) FILE!!!**

Citra
==============
[![GitHub Actions Build Status](https://github.com/citra-emu/citra/workflows/citra-ci/badge.svg)](https://github.com/citra-emu/citra/actions)
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

If you want to contribute to the user interface translation, please check out the [citra project on transifex](https://www.transifex.com/citra/citra). We centralize the translation work there, and periodically upstream translations.

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
