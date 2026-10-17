:: ローカル選択からの起動用
@echo off
pushd "%~dp0..\myXXorBox"
start "" myXXorBox.exe
popd
exit /b
