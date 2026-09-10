:: 場所固定起動（ZIPを紐づけるため）
:: 外部からの起動バッチ
@echo off
rem 場所固定 → 本体起動 → 元戻り
pushd "%~dp0"
start "" "myXZipRun.exe" %*
popd
exit /b
