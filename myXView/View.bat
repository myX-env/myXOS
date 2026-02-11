:: バッチとPSのコード内容を見るためのバッチ
:: 手動でこのファイル名をコピペ追加して実行
@echo off
type %*
pause
exit /b

@HELP_START@
Show file: Test.ps1(bat)
>> View.bat Test.ps1(bat)
@HELP_END@