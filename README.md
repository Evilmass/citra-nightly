2104
============

1. revert [Improve core timing accuracy (#5257)](57aa18f52ea35ca74cd1a6c406a4abf04049b44e)
2. 不需要 revert [Update FPS to roughly match the actual 3DS rate](16913feb4441ffba1a57347953a8a6aa0103e5c5)
3. remove NextSlice
4. update frame_ticks, `(268,111,856) / (4,468,531) = 59.99999910485123Hz`

```shell
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -A x64 -T v143 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DENABLE_QT_TRANSLATION=ON -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF
msbuild build/citra.sln -property:Configuration=Release,Platform=x64 -maxCpuCount -target:Rebuild
```

**[ORIGINAL_README](./ORIGINAL_README.md)**