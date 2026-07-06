:: 指定アプリを固定パスから呼び出すバッチ
@echo off
rem 現場移動 → 本体起動 → 元戻り
pushd "%~dp0..\myXLine"
start "" /b myXLine.exe %*
popd
exit /b

---★ここからアプリ情報

=======================================
(C) 2025 myXシリーズ18（XL）
myXLine - インライン電卓 v1.0 -
=======================================
【ファイル構成】
myXLine
├ myXLine.exe ：本体
└ readme.txt ：このファイル

【動作環境】
・Windows 7 / 8 / 10 / 11
・.NET Framework 4.8

【概要】
文字入力できる場所なら、計算式を範囲選択して
ホットキーを押すだけで、結果を表示します。
例：2^2 → 2^2=4

【使い方】
1. myXLine.exe を起動します。（常駐）
2. 計算式を範囲選択します。
3. Ctrl+B を押します。
4. 「=結果」が追加されます。

【対応演算】
+　-　*　/　^　(べき乗)
() による計算も可能です。

【ホットキー変更】
EXEをリネームするだけで変更できます。

myXLine.exe　　　Ctrl+B（標準）
myXLine_a.exe　　Ctrl+A
myXLine_x.exe　　Ctrl+X
myXLine_sp.exe　 Ctrl+Space
myXLine_sl.exe　 Ctrl+/
myXLine_sc.exe　 Ctrl+;
myXLine_cl.exe　 Ctrl+:
myXLine_dt.exe　 Ctrl+.
myXLine_cm.exe　 Ctrl+,
myXLine_mu.exe　 Ctrl+無変換

---★ここまでアプリ情報
