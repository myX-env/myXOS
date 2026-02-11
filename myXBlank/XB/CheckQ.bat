:: "?"入力でプレビュー（シンプル版）
:: 引数1 = inputファイルの場所
:: 引数2 = プレビュー対象（呼び出し元バッチ）
:: 全角"？"はメモ帳も起動

@echo off
setlocal enabledelayedexpansion

set /p firstline=<"%~1"
set firstchar=!firstline:~0,1!

:: 先頭が小文字 ? ならプレビューして終了
if "!firstchar!"=="?" (
    REM ★more +2 は最初の2行飛ばしてプレビュー
    more +2 "%~2" > output.txt
    exit /b 1
)
:: 大文字？なら全表示＋メモ帳も起動
if "!firstchar!"=="？" (
    start "" "notepad" "%~2"
        (
            type "%~2"
        ) > output.txt
    exit /b 1
)
exit /b 0
