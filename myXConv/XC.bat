:: 場所固定起動（フォルダを紐づけるため）
:: 外部からの起動バッチ
@echo off
rem 場所固定 → 本体起動 → 元戻り
pushd %~dp0
start "" /b "myXConv.exe" %*
popd
exit /b
