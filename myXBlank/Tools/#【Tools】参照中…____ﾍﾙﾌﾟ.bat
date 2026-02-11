:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

::=== ここから本処理 ===
:: 明示用BATファイル（参照フォルダ確認）
:: ヘルプを見る場合は ? をクリアして起動
@echo off
call "00_◆起動確認とヘルプ◆.bat"
exit /b


現在のコンボBOX用フォルダ
myXBlank
   ├ Tools…参照しているフォルダ
   ├ User
   └ _Test