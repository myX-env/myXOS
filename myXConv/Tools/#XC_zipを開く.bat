:: ローカルフォルダXC内のZIP実行
:: その場所にある先頭のZIPが参照される
@echo off
rem 場所固定 → 本体起動 → 元戻り
pushd "%~dp0..\XC\"
call "%~dp0..\..\myXZipRun\XZ_exe.bat" %*
popd
exit /b