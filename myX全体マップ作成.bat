:: myXフォルダ専用全体マップ作成
:: ステップ起動バッチ
@echo off

:loop
cls
echo ==== myXIndex メニュー ====
echo 1: myXフォルダリスト作成（初回）
echo 2: ツリービュア表示（リスト作成済）
echo 0: 終了
set /p sel=選択:

if "%sel%"=="1" (
    pushd "%~dp0myXIndex"
    start "" /wait myXIndex.exe "%~dp0..\myX"
    popd
    goto loop
)

if "%sel%"=="2" (
    if exist "%~dp0..\myX_list.html" (
        start "" "%~dp0..\myX_list.html"
    ) else (
        echo インデックスが存在しません
        pause
    )
    goto loop
)

if "%sel%"=="0" exit

goto loop
