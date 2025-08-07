bass off [Add vulkan backend (#6512)](dfa2fd0e0de74dea2f984beef4d847da5e18ab43)

1. revert [Improve core timing accuracy (#5257)](57aa18f52ea35ca74cd1a6c406a4abf04049b44e)
2. 不需要 revert [Update FPS to roughly match the actual 3DS rate](16913feb4441ffba1a57347953a8a6aa0103e5c5)
3. remove NextSlice
4. update frame_ticks, `(268,111,856) / (4,468,531) = 59.99999910485123Hz`

```shell
git clone -b vulkan --recursive https://github.com/Evilmass/citra-nightly

# msvc 2017
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -A x64 -T v142 -DCMAKE_SYSTEM_VERSION=10.0.19041.0 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DENABLE_QT_TRANSLATION=OFF -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF
rm -rf build/bin
msbuild build/citra.sln -m -p:Configuration=Release,Platform=x64 -t:Rebuild # /verbosity:detailed

# pack
bash pack.sh build/

# ninja(x86_x64 Cross Tools Command Prompt)
mkdir build && cd build
cmake .. --fresh -G Ninja -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DENABLE_QT_TRANSLATION=ON -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF
ninja
ninja bundle
ccache -s
```

**[ORIGINAL_README](./ORIGINAL_README.md)**