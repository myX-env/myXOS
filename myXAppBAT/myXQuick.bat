:: 指定アプリを固定パスから呼び出すバッチ
@echo off
rem 現場移動 → 本体起動 → 元戻り
pushd "%~dp0..\myXQuick"
call XQ.bat %*
popd
exit /b

---★ここからアプリ情報

=======================================
(C) 2026 myXシリーズ20（XQ）
myXQuick - クイックコール v1.0軽量版 -
=======================================
【ファイル構成】
myXQuick
├ myXQuick_Lite.exe	：本体
├ XQ.bat	：外部からの起動バッチ
├ LPause_Lite.exe	：Pauseキー発動ツール
├ readme.txt	：このファイル
└ readme_en.txt：英語翻訳

【開発環境】
・Windows 10
・.NET Framework 4.8

【概要】
Pause／BreakキーでmyXKey（XK）キーナビを
カーソル付近まで呼び出す常駐ツール。

【使い方】
実行コマンド：
myXQuick.exe "起動するプログラム" "引数1" "引数2" ...
例：
myXQuick.exe "D:\app\Tool.exe" memo.txt test.txt
※デフォルトの対象は myXKey.exe
※トレイメニューから切替え可能
※ LPause_Lite.exe を併用すると、マウス操作からでも
   Pauseキーを発動できます

---★ここまでアプリ情報
