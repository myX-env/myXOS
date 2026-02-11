:: キーナビの矩形取得バッチ（ALTモード起動）
@echo off

:: 場所記憶・固定 
pushd "%~dp0"

:: ALTモードで起動
call XK.bat alt

:: PowerShellでクリップボード内容を表示
cmd /k powershell -ExecutionPolicy Bypass -Command Get-Clipboard

:: 記憶場所戻り
popd
exit /b
