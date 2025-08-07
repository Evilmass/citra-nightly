1782 bass off [Merge pull request #6108 from SachinVin/andy](d38098051d74d19b4b198fcaef7465cedb984fd4)

1. revert [Improve core timing accuracy (#5257)](57aa18f52ea35ca74cd1a6c406a4abf04049b44e)
2. dont revert [Update FPS to roughly match the actual 3DS rate](16913feb4441ffba1a57347953a8a6aa0103e5c5)
3. remove NextSlice
4. update frame_ticks, `(268,111,856) / (4,468,531) = 59.99999910485123Hz`

```shell
git clone -b 1782 --recursive https://github.com/Evilmass/citra-nightly

# msvc 2017
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -A x64 -T v142 -DCMAKE_SYSTEM_VERSION=10.0.19041.0 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DCITRA_USE_BUNDLED_QT=1 -DCITRA_USE_BUNDLED_SDL2=1 -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ON
rm -rf build/bin
msbuild build/citra.sln -m -p:Configuration=Release,Platform=x64 -t:Rebuild # /verbosity:detailed

# pack
bash pack.sh build/
```

note
```shell
git update-index --chmod=+x .ci\source.sh
git update-index --chmod=+x .ci\windows.sh
git commit -m "Fix: Add execute permission to source.sh and windows.sh"
git push

mklink /D C:\Users\Evilmass\Desktop\1782\head\user\load\textures\0004000000197100 C:\Users\Evilmass\Desktop\test\0004000000197100
```

**[ORIGINAL_README](./ORIGINAL_README.md)**
