:: ZIP交換（リネームバッチ）
@echo off
setlocal

if exist "XC_pak.zip" ren "XC_pak.zip" "XC_pak.tmp"
if exist "_XC_pak.zip" ren "_XC_pak.zip" "XC_pak.zip"
if exist "XC_pak.tmp" ren "XC_pak.tmp" "_XC_pak.zip"

echo XC_pak.zip → _XC_pak.zip
echo _XC_pak.zip → XC_pak.zip
echo 切替え完了
pause
endlocal
exit /b