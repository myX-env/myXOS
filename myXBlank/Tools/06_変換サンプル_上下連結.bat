:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

:: シンプル上下連結
@echo off
copy /b input.txt + output.txt temp.txt
move /y temp.txt output.txt
exit /b
