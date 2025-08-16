1671 auto mapping button revert core timing
==============
update .gitignore
update default.ini
update disable_telemetry
add pack.sh
add appveyor.yml
fix submodules
fix CMakeModules\DownloadExternals.cmake
fix msbuild error
    C:\Users\Evilmass\Desktop\dev\src\core\hle\kernel\thread.cpp(123): error C2679: 二进制“=”: 没有找到接受“std::weak_ptr<_Ty>”类型的右操作数的运算符(或没有可接
受的转换)
    https://github.com/Evilmass/citra-nightly/commits/cb44e4408d5e3fd6ec4f7c39c51aa094389408ba/src/core/hle/kernel/thread.cpp?since=2020-05-11&until=2021-01-01
    https://github.com/Evilmass/citra-nightly/blob/ce16653cc81a1298a34741a7af4808da988a190f/src/core/hle/kernel/thread.cpp#L123
update ci.yml

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
4. Set the CPU clock percentage to 300% (`804 MHz`) to avoid minor frame drops in the display.


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
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -A x64 -T v141 -DCMAKE_SYSTEM_VERSION=10.0.19041.0 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DCITRA_USE_BUNDLED_QT=1 -DCITRA_USE_BUNDLED_SDL2=1 -DENABLE_QT_TRANSLATION=OFF -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_LTO=ON
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

[ORIGINAL_README](./ORIGINAL_README.md)