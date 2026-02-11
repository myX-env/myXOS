:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

::=== ここから本処理 ===
:: 明示用BATファイル（参照フォルダ確認）
:: ヘルプを見る場合は ? をクリアして起動
@echo off
call "00====◆起動確認◆===ﾍﾙﾌﾟ.bat"
exit /b


myXBlank
   ├ User…参照しているフォルダ
   ├ _Test
   └ _Tools
