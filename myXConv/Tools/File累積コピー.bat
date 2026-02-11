:: 種類：バッチファイル（汎用サンプル）
:: 概要：回数分プラス(＋)貼付コピー（例：Test→Test+→Test++）
@echo off
setlocal enabledelayedexpansion

set "filePath=%~1"

:: 基本ファイル名と拡張子を取得
set "baseName=%~dpn1"
set "extension=%~x1"

:: 初期のコピー先ファイル名（+が1つ付いた状態）
set "destFile=%baseName%+"

:: 同名のファイルが存在する場合、無限に"+"を追加していく
:checkExist
if exist "%destFile%%extension%" (
    set "destFile=%baseName%"
    set "plusSign="
    :addPlus
    set "destFile=!destFile!!plusSign!"
    if not exist "!destFile!!extension!" (
        goto copyFile
    )
    set "plusSign=+"
    goto addPlus
)

:copyFile
:: ファイルコピー実行
copy "%filePath%" "%destFile%%extension%"
echo コピー先：%destFile%%extension%
pause

endlocal
exit /b
