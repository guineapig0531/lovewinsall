$ErrorActionPreference = 'Stop'
$previewRoot = Join-Path $PSScriptRoot 'dist'
$previewPort = 4173
$pythonCandidates = @(
    (Join-Path $env:USERPROFILE '.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe'),
    'python'
)
$previewPython = $pythonCandidates | Where-Object { (Test-Path -LiteralPath $_) -or (Get-Command $_ -ErrorAction SilentlyContinue) } | Select-Object -First 1
if (-not $previewPython) {
    Start-Process (Join-Path $previewRoot 'index.html')
    Write-Host '已打开离线预览文件。'
    exit
}
Write-Host 'lovewinsall 本地预览：http://127.0.0.1:4173/'
Write-Host '关闭此窗口可停止本地预览。此地址只用于这台电脑。'
Start-Process 'http://127.0.0.1:4173/'
& $previewPython -m http.server $previewPort --bind 127.0.0.1 --directory $previewRoot
