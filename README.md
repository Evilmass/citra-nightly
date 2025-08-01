dev base off 1543

```shell
# git bash
git clone -b dev --recursive https://github.com/Evilmass/citra-nightly.git

# cmake
mkdir build && cd build
cmake .. -G "Visual Studio 17 2022" -A x64 -T v141 -DCMAKE_SYSTEM_VERSION=10.0.19041.0 -DCITRA_USE_BUNDLED_QT=1 -DCITRA_USE_BUNDLED_SDL2=1 -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_MF=ON -DENABLE_FFMPEG_VIDEO_DUMPER=ON
cd ..
msbuild build/citra.sln -property:Configuration=Release,Platform=x64 -maxCpuCount -target:Rebuild
bash pack.sh

# qrc_languages.cpp
AutoGen error
         -------------
         Info error in info file
         "C:/Users/Evilmass/Desktop/1671/build/src/citra_qt/CMakeFiles/citra-qt_autogen.dir/AutogenInfo.json":
         The source file "SRC:/build/src/citra_qt/qrc_languages.cpp" does not exist.

         系统找不到指定的批处理标签 - VCEnd
    64>C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Microsoft\VC\v150\Microsoft.CppCommon.targets(195,5): error MSB6006: “cmd.exe”已退出，代码
```


install custom msvc2017 in CI/CD
==============
https://github.com/ilammy/msvc-dev-cmd/issues/92


Translation
==============
```shell
# Error:
Could not find a package configuration file provided by "Qt5LinguistTools"
# Fix: add qttools
aqt.exe install-qt --outputdir ./qt-5.10.0-msvc2017_64 windows desktop 5.10.0 win64_msvc2017_64 --archives qtbase qtm ultimedia qttools qttranslations
```

custom info
==============
CMakeModules\GenerateSCMRev.cmake

AppVeyor
==============
[citra-nightly-AppVeyor](https://ci.appveyor.com/project/Evilmass/citra-nightly)