[Add vulkan backend (#6512)](dfa2fd0e0de74dea2f984beef4d847da5e18ab43)

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
