:: 固定パスから本体EXEを起動する本体の代理バッチ
:: EXEをバッチで受けることで、本体の変更にも柔軟に対応できる
@echo off
start "" /b "%~dp0myXZipRun.exe" %*
exit /b
