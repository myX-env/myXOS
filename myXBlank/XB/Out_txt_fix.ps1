# 出力テキストを整形
# 文字/改行コード：SJIS/CRLF に統一
$text = Get-Content "output.txt" -Raw
$text = $text -replace "`r?`n", "`n"
$text = $text -replace "`n", "`r`n"
[System.IO.File]::WriteAllText("temp.txt", $text, [System.Text.Encoding]::GetEncoding("shift_jis"))
Remove-Item "output.txt"
Rename-Item "temp.txt" "output.txt"
