:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

:: ZIPRUNを介して、ZIP内のアプリをバッチから直接起動する
:: 展開後の実行ファイルを指定して即実行できる仕組み
@echo off
pushd "%~dp0..\XB"
set /p num=<"%~dp0input.txt"
call "%~dp0..\..\myXZipRun\XZ_exe.bat" 16hex.exe %num%
exit /b

--- 使い方 ---
入力BOXに10進数の数値を入れて
[変換／起動] ボタンをクリック
