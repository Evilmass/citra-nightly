dev

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
git clone -b dev --recursive https://github.com/Evilmass/citra-nightly.git

# cmake
mkdir msvc_build && cd msvc_build
# VS 2017
# cmake .. -G "Visual Studio 15 2017 Win64"

# toolset
# https://cmake.org/cmake/help/latest/variable/CMAKE_GENERATOR_TOOLSET.html#visual-studio-toolset-selection
# https://cmake.org/cmake/help/latest/variable/CMAKE_VS_PLATFORM_TOOLSET.html#variable:CMAKE_VS_PLATFORM_TOOLSET
# -T v141
# -DCMAKE_GENERATOR_TOOLSET=v141

# from local
# C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC\14.16.27023\bin\HostX64\x64\cl.exe

# from actions
# VCToolsInstallDir: C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Tools\MSVC\14.44.35207\
# VCToolsVersion: 14.44.35207
# WindowsSDKLibVersion: 10.0.26100.0

# solution
# https://github.com/ilammy/msvc-dev-cmd/issues/92
# https://learn.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2022

vs_BuildTools powershell
```shell
# 下载 VS Build Tools 安装器
Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vs_BuildTools.exe" -OutFile "vs_BuildTools.exe"
# 安装 v141 工具集（VS2017 生成工具）
Start-Process -FilePath ./vs_BuildTools.exe -ArgumentList "--add", "Microsoft.VisualStudio.Component.VC.v141.x86.x64", "Microsoft.VisualStudio.Component.Windows10SDK.19041", "--quiet", "--norestart", "--force", "--wait" -Wait -PassThru
```

cmake .. -G "Visual Studio 17 2022" -A x64 -DCMAKE_SYSTEM_VERSION=10.0.19041.0 -DCMAKE_C_COMPILER="C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Tools\MSVC\14.16.27023\bin\HostX64\x64\cl.exe" -DCMAKE_CXX_COMPILER="C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Tools\MSVC\14.16.27023\bin\HostX64\x64\cl.exe" -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCITRA_USE_BUNDLED_QT=1 -DCITRA_USE_BUNDLED_SDL2=1 -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ON
cd ..

## 若你仅修改了源代码，而没有改变 CMakeLists.txt 文件，可以跳过 CMake 配置步骤，直接重新编译。
# rm -rf ./CMakeFiles/ && rm -f ./CMakeCache.txt

# msbuild
# https://learn.microsoft.com/en-us/visualstudio/msbuild/obtaining-build-logs-with-msbuild?view=vs-2022
# -terminalLogger:on -terminalloggerparameters:verbosity=diagnostic -fileLogger -fileloggerparameters:logfile=msbuild.log;verbosity=diagnostic 
msbuild msvc_build/citra.sln -property:Configuration=Release,Platform=x64 -maxCpuCount -target:Rebuild

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

Origin README
==============
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
