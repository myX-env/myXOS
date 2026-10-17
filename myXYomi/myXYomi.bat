:: （仮）myXYomi（XY）読みバッチ
:: 読み上げ準備バッチ
:: 管理者権限で実行（用意した.lnkからの起動を推奨）
:: myX新作ではないため、独立したツールとしての公開予定なし
:: XQ・XE・XLなど既存ツールの組合せで実現
:: 選択範囲を対象に読み上げ（クリップボードへの影響を抑制）
:: インストール不要
@echo off

echo 管理者権限で起動していますか？
echo [Enter]で続行 [0]で終了
set /p x="> "
if "%x%"=="0" echo 終了します & pause & exit /b

start "" "D:\myX\myXQuick\LPause_Lite.exe"
timeout /t 1 /nobreak >nul

start "" "D:\myX\myXQuick\myXQuick_Lite.exe" "D:\myX\myXExeway\Exeway.exe"
timeout /t 1 /nobreak >nul

start "" "D:\myX\myXLine\myXLine.exe"

echo 手順
echo トレイアイコンの"インライン電卓（Ctrl＋B）"を確認
echo 右クリックでトレイメニューの"読み上げのみ"にチェックON
echo テキスト選択状態でCtrl+B、または、XEのリストから"読み･計算"を選択
pause
exit /b
:: 状況により、テキスト読み上げが正常に動作しない場合あり
