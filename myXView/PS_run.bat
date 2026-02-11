:: PSを実行する場合に呼ぶバッチ
:: 手動でこのファイル名をコピペ追加して実行
powershell -ExecutionPolicy Bypass -File %*
exit

@HELP_START@
Run file: Test.ps1
>> PS_run.bat Test.ps1
@HELP_END@
