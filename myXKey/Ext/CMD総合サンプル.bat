@echo off
title %~n0
color 0a
:MENU
cls
echo ===========================
echo       CMD総合サンプル
echo ===========================
echo [1] コンソールヘルプ一覧
echo [2] コマンド指定ヘルプ
echo [3] 使用例表示
echo [4] 環境チェック
echo [0] 終了
echo ===========================
set /p sel=番号を選んでください: 

if "%sel%"=="1" goto HELPALL
if "%sel%"=="2" goto HELPONE
if "%sel%"=="3" goto SAMPLE
if "%sel%"=="4" goto CHECK
if "%sel%"=="0" (
    echo BATメニュー終了
    pause
    exit
)
goto MENU

:HELPALL
cls
echo [HELP一覧]
help
pause
goto MENU

:HELPONE
cls
pushd %~dp0..
call "..\myXZipRun\XZ_exe.bat" コマンド指定ヘルプ.bat
popd
echo 解凍中...
timeout /t 2 >nul
goto MENU

:SAMPLE
cls
pushd %~dp0..
call "..\myXZipRun\XZ_exe.bat" CMD使用例.txt
popd
echo 解凍中...
timeout /t 2 >nul
goto MENU

:CHECK
cls
echo OSバージョンと環境変数を確認します…
ver
echo.
set
pause
goto MENU
