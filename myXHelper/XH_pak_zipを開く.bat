:: 固定パスから本体EXEを起動する身代わりバッチ
:: EXEをバッチで受けることで、本体の変更にも柔軟に対応できる
@echo off
call "%~dp0..\myXZipRun\XZ_exe.bat" %*
exit /b
