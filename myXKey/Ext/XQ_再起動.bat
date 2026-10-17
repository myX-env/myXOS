:: クイックコールの切替えバッチ（キーナビ）
@echo off
rem 自分自身を終了するために古いプロセスを終了
taskkill /f /im myXQuick.exe >nul 2>&1

rem 現場移動 → 本体バッチ起動 → 元戻り
pushd "%~dp0..\..\myXQuick"

rem "%*" には実行EXEと引数を指定できる
call XQ.bat %*

popd
exit /b
