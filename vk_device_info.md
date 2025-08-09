# error LNK2001: 无法解析的外部符号 "class vk::detail::DispatchLoaderDynamic vk::detail::defaultDispatchLoaderDynamic"

原因：Github Actions 的 VULKAN_SDK\Include 目录优先级不一样，实际编译引用的是 `externals/vulkan-headers/include`。Windows 的 VULKAN_SDK 在系统优先级过高，推荐使用 Ninja 编译。

vk_device_info.cpp: https://github.com/Evilmass/citra-nightly/actions/runs/16794902171/job/47563720084#step:9:16071

```shell
LINK: command "C:\PROGRA~1\MIB055~1\2022\COMMUN~1\VC\Tools\MSVC\1444~1.352\bin\Hostx64\x64\link.exe /nologo @CMakeFiles\citra-qt.rsp /out:bin\Release\citra-qt.exe /implib:src\citra_qt\citra-qt.lib /pdb:bin\Release\citra-qt.pdb /version:0.0 /machine:x64 /DEBUG /MANIFEST:NO /INCREMENTAL:NO /OPT:REF,ICF /subsystem:console /SUBSYSTEM:WINDOWS" failed (exit code 1120) with the following output:
  正在创建库 src\citra_qt\citra-qt.lib 和对象 src\citra_qt\citra-qt.exp
vk_device_info.cpp.obj : error LNK2001: 无法解析的外部符号 "class vk::detail::DispatchLoaderDynamic vk::detail::defaultDispatchLoaderDynamic" (?defaultDispatchLoaderDynamic@detail@vk@@3VDispatchLoaderDynamic@12@A)
bin\Release\citra-qt.exe : fatal error LNK1120: 1 个无法解析的外部命令
```

fix: set VULKAN_SDK=