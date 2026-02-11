#--------------------------------------------
# myXシリーズ8（XW）
# myXWorker - Xワーカー v1.0
# 統合GUIランチャー、固定Tempでbat履歴2個保持
# ラジオ選択/引数/右ヘルプ/プレビュー/PS対応
# EXE判定、ヘルプ、DLL
#--------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 実行ファイルの判定(x64,x86)＋DLLヒット数と候補一覧
function Get-ExePreviewSimple {
    param ($path)
    try {
        $bytes = [System.IO.File]::ReadAllBytes($path)
        if ($bytes.Length -lt 0x3C + 4) { return "判定不能" }

        $peOffset = [BitConverter]::ToInt32($bytes, 0x3C)
        if ($peOffset + 6 -ge $bytes.Length) { return "判定不能" }

        if ($bytes[$peOffset] -ne 0x50 -or $bytes[$peOffset+1] -ne 0x45) {
            return "判定不能"
        }

        $machine = [BitConverter]::ToUInt16($bytes, $peOffset + 4)
        $bits = if ($machine -eq 0x8664) { "64ビット(x64)" } elseif ($machine -eq 0x014c) { "32ビット(x86)" } else { "未対応アーキテクチャ" }

        $optHeaderOffset = $peOffset + 24
        if ($optHeaderOffset + 70 -ge $bytes.Length) { return "$bits の実行ファイル（サブシステム不明）なのだ" }

        $subsystem = [BitConverter]::ToUInt16($bytes, $optHeaderOffset + 68)
        $ui = switch ($subsystem) {
            2 { "Windows GUI アプリケーション" }
            3 { "コンソール アプリケーション" }
            default { "その他の形式" }
        }

        # DLLヒット数・候補一覧
        $dllStr = [System.Text.Encoding]::ASCII.GetString($bytes)
        $matches = [regex]::Matches($dllStr, '\b[\w\.\-]{1,64}\.dll\b', 'IgnoreCase')
        $dllNames = $matches | ForEach-Object { $_.Value } | Sort-Object -Unique

        $lowerDlls = ($dllNames | Where-Object { $_ -cmatch '\.dll$' }).Count
        $upperDlls = ($dllNames | Where-Object { $_ -cmatch '\.DLL$' }).Count

        $infoLine = "これは $bits  $ui なのだ" + " " * 30 + "⇒ DLL依存：（.dll $lowerDlls / .DLL $upperDlls）"
        $dllLine = if ($dllNames.Count -gt 0) {
            " ⇒ 候補：" + ($dllNames -join ", ")
        } else {
            "DLL候補なしなのだ"
        }

        # ===== ここからHELP抽出 =====
        $helpText = ""
$helpText = ""
try {
    # バイト列をUTF8で変換
    $txt = $null
    try { $txt = [System.Text.Encoding]::UTF8.GetString($bytes) } catch {}
    # UTF8で見えなければシステム既定文字コードで
    if (-not $txt) { $txt = [System.Text.Encoding]::Default.GetString($bytes) }

    # 正規表現で @HELP_START@ ～ @HELP_END@ を抽出
    $helpMatch = [regex]::Match($txt, "@HELP_START@(.*?)@HELP_END@", "Singleline")
    if ($helpMatch.Success) {
        $helpText = "`r`n------ ヘルプ内容 ------`r`n" + $helpMatch.Groups[1].Value.Trim()
    }
} catch {}

        return $infoLine + "`n" + $dllLine + $helpText
    } catch {}
    return "判定不能"
}

# フォーム構築
$form = New-Object System.Windows.Forms.Form
$form.Text = "Xワーカー v1.0 統合GUIランチャー"
$form.Size = New-Object System.Drawing.Size(600, 400)
$form.StartPosition = "CenterScreen"
$form.Add_Resize({
    # プレビューの高さを調整
    $topMargin = 180  # プレビュー開始位置のY座標
    $bottomMargin = 20 # 下の余白
    $newHeight = $form.ClientSize.Height - $topMargin - $bottomMargin
    if ($newHeight -gt 50) {
        $previewBox.Height = $newHeight
    }
})

# 右クリック表示
$form.Add_MouseUp({
    param($sender, $e)
    if ($e.Button -eq [System.Windows.Forms.MouseButtons]::Right) {
        $menu = New-Object System.Windows.Forms.ContextMenuStrip

        # 項目を追加
        $menu.Items.Add("→ 履歴フォルダを開く") | ForEach-Object {
            $_.Add_Click({
                Start-Process -FilePath "$env:TEMP"
            })
        }
        $menu.Items.Add((New-Object System.Windows.Forms.ToolStripSeparator))

        # ローカルZIP
        $ext = $menu.Items.Add("＋ ローカルZIP... ZIPRUN")
        $ext.ToolTipText = "$PSScriptRoot\XZ_zip_exeを開く.bat"        
        $ext.Add_Click({
            Start-Process "$PSScriptRoot\XZ_zip_exeを開く.bat"
        })

        $ext1 = $menu.Items.Add("＋ 外部ツール1... 変換BOX_空箱")
        $ext1.ToolTipText = "D:\myX\myXBlank\XB.bat"
        $ext1.Add_Click({
            Start-Process -FilePath "D:\myX\myXBlank\XB.bat"
        })
        $ext2 = $menu.Items.Add("＋ 外部ツール2... ユーザー")
        $ext2.ToolTipText = "D:\myX\User.bat"
        $ext2.Add_Click({
            Start-Process -FilePath "D:\myX\User.bat"
        })
        $menu.Items.Add((New-Object System.Windows.Forms.ToolStripSeparator))

        $menu.Items.Add("   補足") | ForEach-Object {
            $_.Add_Click({
                [System.Windows.Forms.MessageBox]::Show(
                    "myXシリーズ8 `n`nmyXWorker（XW） - Xワーカー v1.0 -`n`n" +
                    "概要：擬似GUIランチャーで、ps1/bat/exe を引数付きで実行可能`n`n" +
                    "ファイル・フォルダをまとめて渡せるが、対応はアプリ次第`n`n" +
                    "EXEの埋め込みヘルプと依存DLL情報も確認できるのだ`n`n" +
                    "バッチファイルの対応`n`n" +
                    "・安全策として Temp フォルダで実行（ファイル名：PersistentBatch.bat）`n`n" +
                    "・（ exit / goto :eof ） は即終了のため pause & exit に置換（任意）",
                    "補足")
            })
        }
        $menu.Items.Add((New-Object System.Windows.Forms.ToolStripSeparator))
        $menu.Items.Add("× 閉じる") | ForEach-Object {
            $_.Add_Click({ $form.Close() })
        }

        # カーソル位置に表示
        $menu.Show($form, $e.Location)
    }
})

# 実行ファイル選択
$scriptLabel = New-Object System.Windows.Forms.Label
$scriptLabel.Location = New-Object System.Drawing.Point(10,10)
$scriptLabel.Size = New-Object System.Drawing.Size(300,20)
$scriptLabel.Text = "実行ファイル（ .ps1 / .bat / .exe / .dll ）:"
$form.Controls.Add($scriptLabel)

$scriptBox = New-Object System.Windows.Forms.TextBox
$scriptBox.Location = New-Object System.Drawing.Point(10,35)
$scriptBox.Size = New-Object System.Drawing.Size(470,20)
$form.Controls.Add($scriptBox)

$browseScript = New-Object System.Windows.Forms.Button
$browseScript.Location = New-Object System.Drawing.Point(480,35)
$browseScript.Size = New-Object System.Drawing.Size(100,23)
$browseScript.Text = "参照..."
$browseScript.Add_Click({
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = "スクリプト (*.ps1;*.bat;*.exe;*.dll)|*.ps1;*.bat;*.exe;*.dll|すべて (*.*)|*.*"
    $dialog.InitialDirectory = (Get-Location).Path
    if ($dialog.ShowDialog() -eq "OK") {
        $scriptBox.Text = $dialog.FileName
    }
})
$form.Controls.Add($browseScript)

# プレビューBOX追加（実行ファイル確定後）
$previewBox = New-Object System.Windows.Forms.TextBox
$previewBox.Location = New-Object System.Drawing.Point(10, 180)
$previewBox.Size = New-Object System.Drawing.Size(570, 170) # 高さ初期値
$previewBox.Multiline = $true
$previewBox.ScrollBars = "Vertical"
$previewBox.ReadOnly = $true
$previewBox.Font = New-Object System.Drawing.Font("Consolas", 10)
$form.Controls.Add($previewBox)

# $scriptBox の TextChanged イベントでプレビュー更新処理を追加
$scriptBox.Add_TextChanged({
    $filePath = $scriptBox.Text.Trim('"').Trim()
    if (Test-Path -LiteralPath $filePath) {
        $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
        if ($ext -eq ".ps1" -or $ext -eq ".bat" -or $ext -eq ".cmd" -or $ext -eq ".txt") {
            try {
                $content = Get-Content -LiteralPath $filePath -Encoding Default -ErrorAction Stop
                $previewBox.Text = $content -join "`r`n"
            } catch {
                $previewBox.Text = "ファイル読み込みエラー"
            }
        } elseif ($ext -eq ".exe" -or $ext -eq ".dll") {
            # exe/dllは判定を表示
            $previewBox.Text = Get-ExePreviewSimple $filePath
        } else {
            $previewBox.Text = "" # 指定拡張子以外はプレビューなし (変更可能)
        }
    } else {
        $previewBox.Text = ""
    }
})

# 引数を受け取り
if ($args.Count -ge 1 -and (Test-Path -LiteralPath $args[0])) {
    $scriptBox.Text = $args[0]
}

# 引数選択
$argLabel = New-Object System.Windows.Forms.Label
$argLabel.Location = New-Object System.Drawing.Point(10,80)
$argLabel.Size = New-Object System.Drawing.Size(220,20)
$argLabel.Text = "引数として渡す項目を選択　　　（"
$form.Controls.Add($argLabel)

# ラジオ選択
$radioFile = New-Object System.Windows.Forms.RadioButton
$radioFile.Text = "ファイル"
$radioFile.Location = New-Object System.Drawing.Point(230, 80)
$radioFile.Size = New-Object System.Drawing.Size(100, 20)
$radioFile.Checked = $true
$form.Controls.Add($radioFile)

$radioFolder = New-Object System.Windows.Forms.RadioButton
$radioFolder.Text = "フォルダ　）"
$radioFolder.Location = New-Object System.Drawing.Point(330, 80)
$radioFolder.Size = New-Object System.Drawing.Size(100, 20)
$form.Controls.Add($radioFolder)

$argBox = New-Object System.Windows.Forms.TextBox
$argBox.Location = New-Object System.Drawing.Point(10,105)
$argBox.Size = New-Object System.Drawing.Size(470,20)
$form.Controls.Add($argBox)

$browseArg = New-Object System.Windows.Forms.Button
$browseArg.Location = New-Object System.Drawing.Point(480,105)
$browseArg.Size = New-Object System.Drawing.Size(100,23)
$browseArg.Text = "参照..."
$browseArg.Add_Click({
    $selected = @()
    if ($radioFile.Checked) {
        $fileDialog = New-Object System.Windows.Forms.OpenFileDialog
        $fileDialog.Filter = "All files (*.*)|*.*"
        $fileDialog.InitialDirectory = (Get-Location).Path
        $fileDialog.Multiselect = $true
        if ($fileDialog.ShowDialog() -eq "OK") {
            $selected = $fileDialog.FileNames
        }
    } elseif ($radioFolder.Checked) {
        $folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
        $folderDialog.SelectedPath = (Get-Location).Path
        if ($folderDialog.ShowDialog() -eq "OK") {
            $selected = @($folderDialog.SelectedPath)
        }
    }

    if ($selected.Count -gt 0) {
        $argBox.Text = ($selected -join "`n")
    }
})
$form.Controls.Add($browseArg)

# 実行ボタン
$runButton = New-Object System.Windows.Forms.Button
$runButton.Location = New-Object System.Drawing.Point(200,140)
$runButton.Size = New-Object System.Drawing.Size(200,30)
$runButton.Text = "実　行"
$runButton.Add_Click({
    $script = $scriptBox.Text.Trim('"').Trim()
    if (-not ($script -and (Test-Path -LiteralPath $script))) {
        [System.Windows.Forms.MessageBox]::Show("実行ファイルが無効です")
        return
    }

    $argsRaw = $argBox.Text
    $splitArgs = $argsRaw -split "`r?`n" | Where-Object { $_ -ne "" }
    $quotedArgs = $splitArgs | ForEach-Object { "`"$_`"" }

    $ext = [System.IO.Path]::GetExtension($script).ToLower()

    switch ($ext) {
        ".ps1" {
            $psArgs = @("-NoExit", "-ExecutionPolicy", "Bypass", "-File", "`"$script`"")
            if ($quotedArgs.Count -gt 0) { $psArgs += $quotedArgs }
            Start-Process powershell -ArgumentList $psArgs
        }
        ".bat" {
            $basePath = "$env:TEMP\PersistentBatch.bat"
            $execPath = "$env:TEMP\TempRun.bat"
            $backupPath = "$basePath.bak"

            # 前回の PersistentBatch.bat を .bak に退避
            if (Test-Path -LiteralPath $basePath) {
                Copy-Item -Path $basePath -Destination $backupPath -Force
            }

            # 今回の新しいバッチ内容を PersistentBatch.bat に反映
            Copy-Item -Path $script -Destination $basePath -Force

            # `PersistentBatch.bat` に更新
            (Get-Content $script -Raw) | Set-Content $basePath
            (Get-Content $basePath -Raw) + "`r`n@pause" | Set-Content $execPath

            if ($quotedArgs.Count -gt 0) {
                $joinedArgs = $quotedArgs -join " "
                $cmdLine = "`"$execPath $joinedArgs`""
            } else {
                $cmdLine = "`"$execPath`""
            }
            Start-Process cmd.exe -ArgumentList "/c $cmdLine"
            
            Start-Sleep -Seconds 2 # バッチの即実行を考慮し、2秒待機
            Remove-Item $execPath -Force -ErrorAction SilentlyContinue
        }

        ".exe" {
            if ($quotedArgs.Count -gt 0) {
                Start-Process $script -ArgumentList ($quotedArgs -join " ")
            } else {
                Start-Process $script
            }
        }
        default {
            try {
                # この場合、GUIで指定された引数($quotedArgs)は使用しない
                Start-Process -FilePath $script
            } catch {
                [System.Windows.Forms.MessageBox]::Show("ファイルを開けませんでした: $($_.Exception.Message)", "エラー", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            }
        }
    }
    $form.WindowState = 'Minimized' # どの処理の後でも最小化 (元の動作)
})
$form.Controls.Add($runButton)

# 初期状態でフォームを最前面表示し、アクティブにする
$form.Topmost = $true
$form.Add_Shown({ $form.Activate(); $form.Topmost = $false }) # Activate後にTopmostを解除することが推奨される場合がある
[void]$form.ShowDialog()
