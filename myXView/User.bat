:: XCのオプション起動バッチを呼び出す
:: 2段階短縮で1文字起動：myXPad → XP → P
:: 起動キー：A-Z ／ 特別キー：NP・CM・PS
:: P＋引数パス → myXPad（XP）を起動
:: 入力例：User.bat P "D:\DATA\test.txt"
@echo off
pushd "%~dp0..\myXConv\Tools"
call "#Mode_myX.bat" "%~1" "%~2" "%~3" "%~4"
popd
exit /b

@HELP_START@
** Option : CM PS NP A-Z
  User.bat CM   : CMD
  User.bat PS   : PowerShell
  User.bat NP   : Notepad
  User.bat A-Z  : myX tool (A-Z)
** Sample : User.bat P "D:\DATA\test.txt"
@HELP_END@
