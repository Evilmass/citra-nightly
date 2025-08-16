# citra-nightly

Custom-built emulator optimized for Monster Hunter Double Cross
- **Fix lag:** Periodic slowdowns with frame drops
- **Port functions:** Touch-mapping, fix SaveStates hotkeys

Inspired by
- [Lurpigi/Lime3DS](https://github.com/Lurpigi/lime3ds-dqmj3p)
- [Slashaim/citra-dqmj3pro](https://github.com/Slashaim/citra-dqmj3pro)

**Important**

1. **Revert [Improve core timing accuracy (#5257)](https://github.com/Evilmass/citra-nightly/commit/57aa18f52ea35ca74cd1a6c406a4abf04049b44e)**
   - This commit introduced sudden frame rate drops to **56 FPS**
2. **Revert [Update FPS to roughly match the actual 3DS rate](https://github.com/Evilmass/citra-nightly/commit/5e95b35900bb8c840169c4446634ff67982aa842)**
   - This commit caused the frame rate to fluctuate between **58–60 FPS**
3. **Maintain `BASE_CLOCK_RATE_ARM11 = 268868160`**
   - Keeping this setting ensures the emulator runs at a **steady 60 FPS**


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
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -A x64 -T v141 -DCMAKE_SYSTEM_VERSION=10.0.19041.0 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DENABLE_QT_TRANSLATION=OFF -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF -DUSE_DISCORD_PRESENCE=OFF
rm -rf build/bin
msbuild build/citra.sln -m -p:Configuration=Release,Platform=x64 -t:Rebuild

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
