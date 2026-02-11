:: 指定アプリを固定パスから呼び出すバッチ
@echo off
rem 現場移動 → 本体起動 → 元戻り
pushd "%~dp0..\..\myXBlank"
taskkill /f /im XB.bat
call XB.bat %*
popd
exit /b
