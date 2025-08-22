bass off [Add vulkan backend (#6512)](dfa2fd0e0de74dea2f984beef4d847da5e18ab43)

1. revert [Improve core timing accuracy (#5257)](57aa18f52ea35ca74cd1a6c406a4abf04049b44e)
2. dont revert [Update FPS to roughly match the actual 3DS rate](16913feb4441ffba1a57347953a8a6aa0103e5c5)
3. remove NextSlice
4. `SCREEN_REFRESH_RATE` = `BASE_CLOCK_RATE_ARM11=268868160` / `frame_ticks=4481136` = 60

测试
- frame_ticks, `(268,111,856) / (4,468,531) = 59.99999910485123Hz`
- 加 raise_cpu_ticks 会跳帧，模拟速度不稳定
- SCREEN_REFRESH_RATE 超过 60 fps 会撕裂

```shell
git clone -b vulkan --recursive https://github.com/Evilmass/citra-nightly

# fix vk_device_info.obj : error LNK2001: 无法解析的外部符号 "class vk::detail::DispatchLoaderDynamic vk::detail::defaultDisp
set VULKAN_SDK=

# msvc 2019
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -A x64 -T v142 -DCMAKE_BUILD_TYPE=Release -DENABLE_QT_TRANSLATION=ON -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_LTO=ON
msbuild build/citra.sln -m -p:Configuration=Release,Platform=x64 -t:Rebuild

# ninja(x86_x64 Cross Tools Command Prompt)
mkdir ninja_build && cd ninja_build
cmake .. --fresh -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DENABLE_QT_TRANSLATION=ON -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF
ninja
ninja bundle

# cache result
ccache -s

# test
ctest -VV -C Release || echo "::error ::Test error occurred on Windows build"

# pack
bash pack.sh build/
```

**[ORIGINAL_README](./ORIGINAL_README.md)**