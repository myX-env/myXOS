:: 選択範囲を読み上げる場合
:: 要件：XL常駐・"読み上げのみ"チェックON
@echo off
start "" "%~dp0..\KeyAct.exe" ctrl b
exit /b
