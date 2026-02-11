:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

::=== ここから本処理 ===
:: プロセス終了
@echo off
taskkill /f /im "myXBlank.exe" >nul 2>&1
exit /b
