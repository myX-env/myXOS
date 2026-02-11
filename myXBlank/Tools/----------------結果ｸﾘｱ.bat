:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

::=== ここから本処理 ===
:: 区切り＋履歴クリア
:: 削除後、中身ゼロファイル作成
@echo off
type nul > output.txt
exit /b
