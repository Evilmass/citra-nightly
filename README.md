# Citra Nightly 1884

base off [Merge pull request #6439 from t895/theme-adjustments](9414db4f65ac777dbfdf54421681a230f9c3bd43)

## custom textures issue

[old version download](https://citra.en.uptodown.com/windows/versions)

[commit history](https://github.com/Evilmass/citra-nightly/commits/master/?since=2023-04-21&until=2023-04-28)

- Nightly 1893(2023-04-28) not reload

    [externals: Update SoundTouch (#6473)](9bd8c9290bd4bc32bc1fd3dc1dea8674ebbc1d8c)

- Nightly 1885(2023-04-27) not reload

    https://www.reddit.com/r/Citra/comments/12xtbwo/custom_textures_will_no_longer_load/

    [Rasterizer cache refactorRasterizer cache refacto [#6375]](26d6f9d1c695a9bb51b6a12aba8a4194fccf4752)
    > Part 2 of a series of PRs that breaks up the currently rather massive Vulkan PR into multiple pieces to allow for easier reviewing and testing.
    > This will improve Citra's performance with Mali GPUs by about 40%.
    > As a consequence of the improvements, the old Custom Textures implementation had to be axed. We already have a replacement for the old Custom Texture implementation in Canary 2461+. So if you want to use Custom Textures, please USE CANARY FOR NOW!

- Nightly 1884(2023-04-21) **reload**

    https://web.archive.org/web/20240229044336/https://github.com/citra-emu/citra-nightly/releases/tag/nightly-1884
    [Merge pull request #6439 from t895/theme-adjustments](9414db4f65ac777dbfdf54421681a230f9c3bd43)


## build

```shell
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -T v142 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DCITRA_USE_BUNDLED_QT=1 -DENABLE_QT_TRANSLATION=ON -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ON
msbuild build/citra.sln -property:Configuration=Release,Platform=x64 -maxCpuCount -target:Rebuild
buildcache -s
ctest -VV -C Release || echo "::error ::Test error occurred on Windows MSVC build"
```

[ORIGINAL_README](./ORIGINAL_README.md)