2104
============

```shell
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -A x64 -T v143 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DENABLE_QT_TRANSLATION=ON -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF
msbuild build/citra.sln -property:Configuration=Release,Platform=x64 -maxCpuCount -target:Rebuild
```

**[ORIGINAL_README](./ORIGINAL_README.md)**