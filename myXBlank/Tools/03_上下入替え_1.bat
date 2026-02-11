:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 goto :end

::=== ここから本処理 ===
:: 入替え（上段は手動）
@echo off
type output.txt | clip
copy /Y input.txt output.txt

msg * "入力BOXの文字を消して貼り付ければ OK なのだ"
exit /b

