::------------------------------------------------------------
:: User.bat - 外部ツールなどで呼び出される起動用バッチ
::------------------------------------------------------------
:: 役割：
::   開発者推奨の BATランチャー(menu.bat) を起動する。
::   ただしユーザーが独自バッチを使う場合は、
::   _User.bat を同じ場所に置くとそちらが優先実行される。
::   _User+.bat (+)など付けておけば実行されない
::
:: 使い方：
::   1. _User.bat を作成して自分の処理を記述
::   2. User.bat を呼び出すと _User.bat が割り込んで起動する
::   3. 日本語を含む場合は SJIS で保存（文字化け防止）
::
:: 参考：アプリ起動例
::   @echo off
::   start "" "D:\MyTools\アプリ.exe"
::------------------------------------------------------------

@echo off
setlocal
cd /d "%~dp0"

if exist "_User.bat" (
    call "_User.bat"
    exit /b
)

cd /d "%~dp0myXAppBAT"
if exist "menu.bat" (
    call menu.bat
) else (
    call myXFull.bat
)
exit /b
