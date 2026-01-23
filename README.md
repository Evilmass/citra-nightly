bass off [Add vulkan backend (#6512)](dfa2fd0e0de74dea2f984beef4d847da5e18ab43)

1. revert [Improve core timing accuracy (#5257)](57aa18f52ea35ca74cd1a6c406a4abf04049b44e)
2. dont revert [Update FPS to roughly match the actual 3DS rate](16913feb4441ffba1a57347953a8a6aa0103e5c5)
3. remove NextSlice
4. fix [custom textures not loading after restoring a savestate](https://github.com/azahar-emu/azahar/pull/1672/commits/1c44522e23a38160cbcafe4795c2b2e71b6752b6)
5. use original `BASE_CLOCK_RATE_ARM11 = 268111856`
6. add Linux CI/CD & docker build-environments=
7. [rasterizer_cache: Improve validation skip heuristic #69](https://github.com/Borked3DS/Borked3DS/commit/9dfe3eb4bcd26207a5b6723dcc40f2c7147b803d)
8. async_presentation cause [input lag issue](https://github.com/azahar-emu/azahar/issues/1615), set default=false
9. add [custom_cpu_ticks](https://github.com/Borked3DS/Borked3DS/commit/1ec039babd557baa8f250ca4d8656bb59c47303c)

测试
- frame_ticks, `(268,111,856) / (4,481,136) = 59.83122493939037Hz`, `(268,111,860) / (4,468,130) = 60Hz`

- SCREEN_REFRESH_RATE 超过 60 fps 会撕裂

- 不要应用 [core_timing: Allow configuring a fixed or random initial system tick value. (#7309)](https://github.com/Evilmass/citra-nightly/commit/0165012ba400a51710714470b148375ddd1be81c)，会使模拟器速度不稳定。

- 以下功能会导致材质包显示问题
    skip_low_draw
    skip_texture_copy
    skip_cpu_write
    upscaling

```shell
git clone -b vulkan --recursive https://github.com/Evilmass/citra-nightly

# fix vk_device_info.obj : error LNK2001: 无法解析的外部符号 "class vk::detail::DispatchLoaderDynamic vk::detail::defaultDisp
set VULKAN_SDK=

# msvc 2017
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -A x64 -T v142 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DENABLE_QT_TRANSLATION=ON -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF
msbuild build/citra.sln -m -p:Configuration=Release,Platform=x64 -t:Rebuild

# ninja(x86_x64 Cross Tools Command Prompt)
mkdir ninja_build && cd ninja_build
cmake .. --fresh -G Ninja -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DENABLE_QT_TRANSLATION=ON -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF
ninja
ninja bundle

# cache result
ccache -s

# test
ctest -VV -C Release || echo "::error ::Test error occurred on Windows build"

# pack
bash pack.sh build/
```

Docker
```sh
# docker pull evi1docker/build-environments:linux-appimage
git clone -b vulkan --recursive https://github.com/Evilmass/citra-nightly/ app
docker run --rm -v ./app:/app -w /app \
 -e OS=linux -e TARGET=appimage -e ENABLE_COMPATIBILITY_LIST_DOWNLOAD=false \
 pablomk7/build-environments@sha256:bfde277bdaba9bdb516664dfae051c0c4deeec9c2dd33a5246684cf0391e8e1b \
 /bin/sh -c "git config --global --add safe.directory /app && ./.ci/linux.sh"
```

**[ORIGINAL_README](./ORIGINAL_README.md)**
