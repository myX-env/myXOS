:: ローカル選択からの起動用
@echo off
pushd "%~dp0..\myXMouse"
start "" myXMouse.exe
popd
exit /b
