:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

:: ローカル実行（自身の場所から実行）
:: XBフォルダ内にある先頭のZIPが参照される（一覧表示）
@echo off
rem 場所固定 → 本体起動 → 元戻り
pushd "%~dp0..\XB"
call "%~dp0..\..\myXZipRun\XZ_exe.bat" %*
popd
exit /b

