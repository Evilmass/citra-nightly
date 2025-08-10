https://citra.en.uptodown.com/windows/versions
https://github.com/Evilmass/citra-nightly/commits/master/?since=2023-04-21&until=2023-04-28

- Nightly1893(2023-04-28) 掉材质包

    [externals: Update SoundTouch (#6473)](9bd8c9290bd4bc32bc1fd3dc1dea8674ebbc1d8c)

- Nightly1885(2023-04-27) 掉材质包

    https://www.reddit.com/r/Citra/comments/12xtbwo/custom_textures_will_no_longer_load/

- Nightly 1885

    [Rasterizer cache refactorRasterizer cache refacto [#6375]](26d6f9d1c695a9bb51b6a12aba8a4194fccf4752)
    > Part 2 of a series of PRs that breaks up the currently rather massive Vulkan PR into multiple pieces to allow for easier reviewing and testing.
    > This will improve Citra's performance with Mali GPUs by about 40%.
    > As a consequence of the improvements, the old Custom Textures implementation had to be axed. We already have a replacement for the old Custom Texture implementation in Canary 2461+. So if you want to use Custom Textures, please USE CANARY FOR NOW!

- Nightly1884(2023-04-21) 不掉材质包

    https://web.archive.org/web/20240229044336/https://github.com/citra-emu/citra-nightly/releases/tag/nightly-1884
    [Merge pull request #6439 from t895/theme-adjustments](9414db4f65ac777dbfdf54421681a230f9c3bd43)


```shell
cmake --fresh -S . -B build -G "Visual Studio 17 2022" -T v142 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DCITRA_USE_BUNDLED_QT=1 -DENABLE_QT_TRANSLATION=OFF -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF -DUSE_DISCORD_PRESENCE=ON -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ON
# -DOPENSSL_DLL_DIR="C:\Program Files\OpenSSL\bin"
msbuild build/citra.sln -property:Configuration=Release,Platform=x64 -maxCpuCount -target:Rebuild
buildcache -s
ctest -VV -C Release || echo "::error ::Test error occurred on Windows MSVC build"
```

<h1 align="center">
  <br>
  <a href="https://citra-emu.org/"><img src="https://raw.githubusercontent.com/citra-emu/citra-assets/master/Main/citra_logo.svg" alt="Citra" width="200"></a>
  <br>
  <b>Citra</b>
  <br>
</h1>

<h4 align="center"><b>Citra</b> is the world's most popular, open-source, Nintendo 3DS emulator.
<br>
It is written in C++ with portability in mind and builds are actively maintained for Windows, Linux, Android and macOS.
</h4>

<p align="center">
    <a href="https://github.com/citra-emu/citra/actions/">
        <img src="https://github.com/citra-emu/citra/workflows/citra-ci/badge.svg"
            alt="GitHub Actions Build Status">
    </a>
    <a href="https://discord.gg/FAXfZV9">
        <img src="https://img.shields.io/discord/220740965957107713?color=%237289DA&label=Citra&logo=discord&logoColor=white"
            alt="Discord">
    </a>
</p>

<p align="center">
  <a href="#compatibility">Compatibility</a> |
  <a href="#releases">Releases</a> |
  <a href="#development">Development</a> |
  <a href="#building">Building</a> |
  <a href="#support">Support</a> |
  <a href="#license">License</a>
</p>


## Compatibility

The emulator is capable of running most commercial games at full speed, provided you meet the necessary hardware requirements.

For a full list of games Citra supports, please visit our [Compatibility page](https://citra-emu.org/game/)

Check out our [website](https://citra-emu.org/) for the latest news on exciting features, progress reports, and more!
Please read the [FAQ](https://citra-emu.org/wiki/faq/) before getting started with the project.

Need help? Check out our [asking for help](https://citra-emu.org/help/reference/asking/) guide.

## Releases

Citra has two main release channels: Nightly and Canary.

The [Nightly](https://github.com/citra-emu/citra-nightly) build is based on the master branch, and contains already reviewed and tested features.

The [Canary](https://github.com/citra-emu/citra-canary) build is based on the master branch, but with additional features still under review. PRs tagged `canary-merge` are merged only into the Canary builds.

Both builds can be installed with the installer provided on the [website](https://citra-emu.org/download/), but those looking for specific versions or standalone releases can find them in the release tabs of the [Nightly](https://github.com/citra-emu/citra-nightly/releases) and [Canary](https://github.com/citra-emu/citra-canary/releases) repositories.

Android builds can be downloaded from the Google Play Store.

A Flatpak for Citra is available on [Flathub](https://flathub.org/apps/details/org.citra_emu.citra). Details on the build process can be found in [our Flathub repository](https://github.com/flathub/org.citra_emu.citra).

## Development

Most of the development happens on GitHub. It's also where [our central repository](https://github.com/citra-emu/citra) is hosted.
For development discussion, please join us on our [Discord server](https://citra-emu.org/discord/) or at #citra-dev on libera.

If you want to contribute please take a look at the [Contributor's Guide](https://github.com/citra-emu/citra/wiki/Contributing) and [Developer Information](https://github.com/citra-emu/citra/wiki/Developer-Information). You can also contact any of the developers on Discord in order to know about the current state of the emulator.

If you want to contribute to the user interface translation, please check out the [Citra project on transifex](https://www.transifex.com/citra/citra). We centralize the translation work there, and periodically upstream translations.

## Building

* __Windows__: [Windows Build](https://github.com/citra-emu/citra/wiki/Building-For-Windows)
* __Linux__: [Linux Build](https://github.com/citra-emu/citra/wiki/Building-For-Linux)
* __macOS__: [macOS Build](https://github.com/citra-emu/citra/wiki/Building-for-macOS)
* __Android__: [Android Build](https://github.com/citra-emu/citra/wiki/Building-for-Android)


## Support

If you enjoy the project and want to support us financially, check out our Patreon!

<a href="https://www.patreon.com/citraemu">
    <img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="160">
</a>

We also happily accept donated games and hardware.
Please see our [donations page](https://citra-emu.org/donate/) for more information on how you can contribute to Citra.
Any donations received will go towards things like:
* 3DS consoles for developers to explore the hardware
* 3DS games for testing
* Any equipment required for homebrew
* Infrastructure setup

We also more than gladly accept used 3DS consoles! If you would like to give yours away, don't hesitate to join our [Discord server](https://citra-emu.org/discord/) and talk to bunnei.


## License

Citra is licensed under the GPLv2 (or any later version). Refer to the [LICENSE.txt](https://github.com/citra-emu/citra/blob/master/license.txt) file.
