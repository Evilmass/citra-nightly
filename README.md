dev base off 1543

```shell
# vs_buildtools
vs2017_BuildTools.exe --installPath C:\BuildTools --add Microsoft.VisualStudio.Workload.MSBuildTools --add Microsoft. VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.Windows10SDK.19041

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

# https://productionresultssa12.blob.core.windows.net/actions-results/bdf0a9d4-3f88-45e2-a5e0-a8e189c6040f/workflow-job-run-80838dcf-3474-532f-9647-d9f8a03a6115/logs/job/job-logs.txt?rsct=text%2Fplain&se=2025-08-01T05%3A39%3A10Z&sig=ka8VhN%2F4sj3oNM9tjKCzax8qiMy7PiUEzEqhjKPiqao%3D&ske=2025-08-01T14%3A45%3A58Z&skoid=ca7593d4-ee42-46cd-af88-8b886a2f84eb&sks=b&skt=2025-08-01T02%3A45%3A58Z&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skv=2025-05-05&sp=r&spr=https&sr=b&st=2025-08-01T05%3A29%3A05Z&sv=2025-05-05
2025-08-01T04:24:48.6426075Z     63>CustomBuild:
2025-08-01T04:24:48.6426915Z          1>Automatic MOC and UIC for target citra-qt
2025-08-01T04:24:48.6656222Z
2025-08-01T04:24:48.6666222Z          AutoGen error
2025-08-01T04:24:48.6670475Z          -------------
2025-08-01T04:24:48.6674128Z          Info error in info file
2025-08-01T04:24:48.6675699Z          "D:/a/citra-nightly/citra-nightly/build/src/citra_qt/CMakeFiles/citra-qt_autogen.dir/AutogenInfo.json":
2025-08-01T04:24:48.6688161Z          The source file "SRC:/build/src/citra_qt/qrc_languages.cpp" does not exist.
2025-08-01T04:24:48.6689525Z
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