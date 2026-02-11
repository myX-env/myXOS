:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

::=== ここから本処理 ===
# 入替え
@echo off
type output.txt | clip
copy /Y input.txt output.txt

:: 更新バッチの"｡★【更新】再起動.bat"を呼び再起動
call "｡★【更新】再起動.bat"

:: メッセージが先に出るため1秒待機
timeout /nobreak /t 1 > nul

msg * "次に『05_★出力テキスト整形』を起動するのだ"
exit /b

