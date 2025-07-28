[download vswhere-3.1.7](https://github.com/microsoft/vswhere/releases/download/3.1.7/vswhere.exe)

```shell
C:\Users\Administrator\Desktop\dev (dev -> origin)
λ find_vc.bat
[MSVC 版本信息]
======================
找到 MSVC 路径: C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.16.27023
找到 MSVC 版本: 14.16.27023

[Windows SDK 版本信息]
======================
找到 Windows 10 SDK 版本: 10.0.19041.0

版本检测完成
Press any key to continue . . .


C:\Users\Administrator\Desktop\dev (dev -> origin)
λ vswhere.exe -products * -requires Microsoft.Component.MSBuild
Visual Studio Locator version 3.1.7+f39851e70f [query version 3.7.2182.35401]
Copyright (C) Microsoft Corporation. All rights reserved.

instanceId: ae0dfb34
installDate: 2025/7/28 14:38:07
installationName: VisualStudio/15.9.75+36227.7
installationPath: C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools
installationVersion: 15.9.36227.7
productId: Microsoft.VisualStudio.Product.BuildTools
productPath: C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\LaunchDevCmd.bat
state: 4294967295
isComplete: 1
isLaunchable: 1
isPrerelease: 0
isRebootRequired: 0
displayName: Visual Studio 15 生成工具 2017
description: Visual Studio 生成工具允许生成本机和基于 MSBuild 的托管 .NET 应用程序，而不需要 Visual Studio IDE。还可以选
择安装 Visual C++ 编译器和库、MFC、ALT 和 C++/CLI 支持。
channelId: VisualStudio.15.Release
channelUri: https://aka.ms/vs/15/release/channel
enginePath: C:\Program Files (x86)\Microsoft Visual Studio\Installer\resources\app\ServiceHub\Services\Microsoft.VisualStudio.Setup.Service
installedChannelId: VisualStudio.15.Release
installedChannelUri: https://aka.ms/vs/15/release/channel
releaseNotes: https://go.microsoft.com/fwlink/?LinkId=660692#15.9.75
resolvedInstallationPath: C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools
thirdPartyNotices: https://go.microsoft.com/fwlink/?LinkId=660708
updateDate: 2025-07-28T06:38:07.4674263Z
catalog_buildBranch: d15.9
catalog_buildVersion: 15.9.36227.7
catalog_id: VisualStudio/15.9.75+36227.7
catalog_localBuild: build-lab
catalog_manifestName: VisualStudio
catalog_manifestType: installer
catalog_productDisplayVersion: 15.9.75
catalog_productLine: Dev15
catalog_productLineVersion: 2017
catalog_productMilestone: RTW
catalog_productMilestoneIsPreRelease: False
catalog_productName: Visual Studio
catalog_productPatchVersion: 75
catalog_productPreReleaseMilestoneSuffix: 1.0
catalog_productRelease: RTW
catalog_productSemanticVersion: 15.9.75+36227.7
catalog_requiredEngineVersion: 1.18.1063.29791
properties_campaignId:
properties_channelManifestId: VisualStudio.15.Release/15.9.75+36227.7
properties_includeRecommended: 0
properties_nickname:
properties_setupEngineFilePath: C:\Program Files (x86)\Microsoft Visual Studio\Installer\setup.exe

```