@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 检测MSVC版本
echo.
echo [MSVC 版本信息]
echo ======================
set "vs_base=%ProgramFiles(x86)%\Microsoft Visual Studio"
for /D %%v in ("%vs_base%\*") do (
    for /D %%w in ("%%v\*") do (
        set "vc_tools=%%w\VC\Tools\MSVC"
        if exist "!vc_tools!" (
            for /D %%m in ("!vc_tools!\*") do (
                set "msvc_path=%%m"
                echo 找到 MSVC 路径: !msvc_path!
                for %%j in ("!msvc_path!") do set "msvc_version=%%~nxj"
                echo 找到 MSVC 版本: !msvc_version!
            )
        )
    )
)

:: 检测Windows SDK版本
echo.
echo [Windows SDK 版本信息]
echo ======================
:: 尝试Windows 10 SDK路径
for /D %%i in ("%ProgramFiles(x86)%\Windows Kits\10\Include\*.*") do (
    set "sdk_path=%%i"
    for %%j in ("!sdk_path!") do set "sdk_folder=%%~nxj"
    echo 找到 Windows 10 SDK 版本: !sdk_folder!
)
:: 尝试Windows 11 SDK路径
for /D %%i in ("%ProgramFiles(x86)%\Windows Kits\11\Include\*.*") do (
    set "sdk_path=%%i"
    for %%j in ("!sdk_path!") do set "sdk_folder=%%~nxj"
    echo 找到 Windows 11 SDK 版本: !sdk_folder!
)

echo.
echo 版本检测完成!
pause