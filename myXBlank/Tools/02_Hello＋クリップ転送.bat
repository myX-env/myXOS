:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

::=== ここから本処理 ===
:: 出力表示とクリップ転送テスト：この場で完了
@echo off
echo Hello, World! > output.txt

:: クリップボードに転送
type output.txt | clip

msg * "Hello, World! 出力成功なのだ"
msg * "クリップボードにも転送したのだ"
msg * "入力BOXに何回も貼り付けてみるのだ"
exit /b
