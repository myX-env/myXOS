:: ローカル実行（自身の場所から実行）
:: 自身と同じ場所にある先頭のZIPが参照される
@echo off
pushd %~dp0
call "%~dp0..\myXZipRun\XZ_exe.bat" %*
popd
exit /b
