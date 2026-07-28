:: 設定ファイル兼ヘルプ（処理なし）
@echo off
echo No processing in this file.
pause
exit /b

::-- ここから設定・解説 --
settings.cmd：UTF-8形式
バッチ処理部では全角文字を使用しないこと

現在適用される設定（ButtonX=行のみ有効）
@HELP_START@
Button1=全#|^a|#v
Button2=戻<|^z|^y
Button3=
Button4=検*|^f|#x
@HELP_END@

記述形式（X＝ボタン番号）
ButtonX=表示名|左クリック|右クリック
空欄なら初期値

各項目の意味
表示名 ： ボタンに表示する文字
|      ： 区切り文字（半角の縦棒）
^      ： Ctrlキー
#      ： Windowsキー

例
^f  = Ctrl + F
#x  = Windows + X

※ Ctrlキーは小文字で記述する
　例：^f、^c、^v
