:: ローカル実行（自身の場所から実行）
:: 自身と同じ場所にある先頭のZIPが参照される
@echo off
rem 場所固定 → 本体起動 → 元戻り
pushd %~dp0
call "%~dp0..\myXZipRun\XZ_exe.bat" %*
popd
exit /b
