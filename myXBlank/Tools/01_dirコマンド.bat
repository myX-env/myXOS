:: "?"プレビューを有効化（チュートリアル専用）
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 goto :end

::=== ここから本処理 ===
:: この場所のファイル一覧を表示させるコマンド
:: 表示内容を output.txt に保存し出力BOXに表示される
@echo off
dir /b /a:-d > output.txt

msg * "入力BOXに ? と入れると中身を確認できるのだ"
exit /b

:end
msg * "このようにバッチファイルの中身が表示されるのだ！"
exit /b

