:: myX専用 オプション起動バッチ
:: 2段階短縮で1文字起動：myXPad → XP → P
:: 起動キー：A-Z ／ 特別キー：NP・CM・PS
:: P＋引数パス → myXPad（XP）を起動
:: 入力例：#Mode_myX.bat P "D:\DATA\test.txt"
@echo off
setlocal
pushd "D:\myX"

set "mode=%~1"

:: 引数がない場合はデフォルト処理へ
if "%mode%"=="" goto DEFAULT

:: 各オプションの判定（大文字小文字を区別しない）
if /I "%mode%"=="A"  goto DO_A
if /I "%mode%"=="B"  goto DO_B
if /I "%mode%"=="C"  goto DO_C
if /I "%mode%"=="D"  goto DO_D
if /I "%mode%"=="E"  goto DO_E
if /I "%mode%"=="F"  goto DO_F
if /I "%mode%"=="H"  goto DO_H
if /I "%mode%"=="I"  goto DO_I
if /I "%mode%"=="K"  goto DO_K
if /I "%mode%"=="L"  goto DO_L
if /I "%mode%"=="N"  goto DO_N
if /I "%mode%"=="P"  goto DO_P
if /I "%mode%"=="R"  goto DO_R
if /I "%mode%"=="S"  goto DO_S
if /I "%mode%"=="T"  goto DO_T
if /I "%mode%"=="V"  goto DO_V
if /I "%mode%"=="W"  goto DO_W
if /I "%mode%"=="X"  goto DO_X
if /I "%mode%"=="Z"  goto DO_Z
if /I "%mode%"=="NP" goto DO_NP
if /I "%mode%"=="CM" goto DO_CMD
if /I "%mode%"=="PS" goto DO_PS

goto DEFAULT

:DO_A
call "D:\myX\myXAppBAT\menu.bat"
goto END

:DO_B
call "D:\myX\myXBlank\XB.bat" "%~2"
goto END

:DO_C
call "D:\myX\myXConv\XC.bat" "%~2"
goto END

:DO_D
start "" "D:\myX\myXDiff\myXDiff.exe" "%~2"
goto END

:DO_E
start "" "D:\myX\myXExeway\Exeway.exe" "%~2"
goto END

:DO_F
call "D:\myX\myXFull\myXFull.bat" "%~2"
goto END

:DO_H
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\myX\myXHelper\myXHelper_Lite.ps1"
goto END

:DO_I
start "" "D:\myX\myXIndex\myXIndex.exe" "%~2"
goto END

:DO_K
call "D:\myX\myXKey\XK.bat"
goto END

:DO_L
start "" "D:\myX\myXLine\myXLine.exe" "%~2"
goto END

:DO_N
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\myX\myXName\myXName.ps1" "%~2"
goto END

:DO_P
start "" "D:\myX\myXPad\myXPad.exe" "%~2"
goto END

:DO_R
call "D:\myX\myXReturn\User.bat"
goto END

:DO_S
start "" "D:\myX\myXSend\myXSend.exe" "%~2"
goto END

:DO_T
start "" "D:\myX\myXTimemo9\myXTimemo9.exe" "%~2" "%~3" "%~4"
goto END

:DO_V
start "" "D:\myX\myXView\myXView.exe" "%~2"
goto END

:DO_W
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\myX\myXWorker\myXWorker.ps1" "%~2"
goto END

:DO_X
start "" "D:\myX\myXXorBox\myXXorBox.exe"
goto END

:DO_Z
call "D:\myX\myXZipRun\XZ.bat" "%~2"
goto END

:DO_NP
start "" notepad.exe "%~2"
goto END

:DO_CMD
start cmd.exe
goto END

:DO_PS
start powershell.exe -NoLogo -NoProfile
goto END

:DEFAULT
if exist "_User.bat" (
    call "_User.bat"
) else if exist "D:\myX\myXAppBAT\menu.bat" (
    call "D:\myX\myXAppBAT\menu.bat"
) else (
    call "D:\myX\myXAppBAT\myXFull.bat"
)
goto END

:END
popd

exit /b

