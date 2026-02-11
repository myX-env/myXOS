:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

:: Out_txt_fix.ps1を呼ぶBAT
@echo off
powershell -ExecutionPolicy Bypass -File "..\XB\Out_txt_fix.ps1"
exit /b


#--- Out_txt_fix.ps1 内容 ---
# 出力テキストを整形
# 文字/改行コード：SJIS/CRLF に統一
$text = Get-Content "output.txt" -Raw
$text = $text -replace "`r?`n", "`n"
$text = $text -replace "`n", "`r`n"
[System.IO.File]::WriteAllText("temp.txt", $text, [System.Text.Encoding]::GetEncoding("shift_jis"))
Remove-Item "output.txt"
Rename-Item "temp.txt" "output.txt"
