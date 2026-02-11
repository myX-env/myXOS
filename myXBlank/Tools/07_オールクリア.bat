:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

::=== ここから本処理 ===
:: theme.exe を呼ぶBAT（アプリ）
:: 上段/下段BOXをクリア
@echo off

:: Tab→Enter→BS
start "" ..\XB\theme.exe 0 0 1 1 1

type nul > output.txt
exit /b

--- theme.exe 起動方法
// XB専用テーマ切替え用（自動キー操作）
// 起動例＞theme.exe 1 2 2 1 2
// Ctrl＋左1回、Alt＋左2回、Tab2回、Enter1回、BS2回
//-----------------------
