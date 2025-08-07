# https://learn.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2022/install/workload-component-id-vs-build-tools?view=vs-2022#msbuild-tools
# https://learn.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2022/install/workload-component-id-vs-build-tools?view=vs-2022#visual-c-build-tools

$vs_url = "https://aka.ms/vs/17/release/vs_BuildTools.exe"
Invoke-WebRequest -Uri $vs_url -OutFile "vs_buildtools.exe"
if (-not (Test-Path "vs_buildtools.exe")) {
    Write-Error "Failed to download VS Build Tools"
    exit 1
}
$components = @(
"Microsoft.VisualStudio.Workload.MSBuildTools",
"Microsoft.VisualStudio.Workload.VCTools",
"Microsoft.VisualStudio.Component.Windows10SDK.19041",
"Microsoft.VisualStudio.Component.VC.v141.x86.x64",
"Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64"
)
$componentArgs = ($components | ForEach-Object { "--add $_" }) -join " "
$installCmd = ".\vs_buildtools.exe --quiet --norestart --force --wait --installPath C:\BuildTools $componentArgs"
Start-Process -FilePath ".\vs_buildtools.exe" -ArgumentList $installCmd.Split() -Wait -PassThru