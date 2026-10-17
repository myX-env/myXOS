:: 指定アプリを固定パスから呼び出すバッチ
@echo off
echo "読みバッチ（XY）管理者.lnk"を管理者起動します
pause
rem 現場移動 → 本体起動 → 元戻り
pushd "%~dp0..\myXYomi"
rem バッチをLINK化して管理者起動
start "" "読みバッチ（XY）管理者.lnk"
popd
exit /b

---★ここからアプリ情報

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

echo 読み上げ機能はインライン電卓起動後、
echo トレイメニューの"読み上げのみ"にチェックON
echo 選択反転中にCtrl+B、XEのリスト"読み･計算"を選択
pause
exit /b
:: 状況により、テキスト読み上げが正常に動作しない場合あり

---★ここまでアプリ情報
