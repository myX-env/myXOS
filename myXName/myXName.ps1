#---------------------------------
# myXシリーズ7 myXName（XN） 
# - 命名マスター v2.0
# 3段タグ、手動修正、右メニュー強化
#---------------------------------
Add-Type -AssemblyName PresentationFramework

# 記号とタグの選択肢
$symbols = @("",
"        ▼第1タグ",
"-------ランク系-------",
 "[RANK_S]", "[RANK_A]", "[RANK_B]", "[RANK_C]", "[RANK_D]", "[RANK_E]", "[RANK_F]", "[RANK_",
 "[評_S]", "[評_A]", "[評_B]", "[評_C]", "[評_D]", "[評_E]", "[評_F]", "[評_", "[評"
)

$tags1   = @("",
"        ▼第2タグ",
"-----動作実行系-----",
 "[BA]", "[CS]", "[C#]", "[EX]", "[EXE]", "[HTM]", "[LNK]", "[PS]", "[PY]", "[REG]", "[SC]", "[SRC]",
"------中央繋ぎ------",
 "･", "_", "+", "-", "~", "～", "⇔", "[]"
)

$tags2   = @("",
"        ▼第3タグ",
"---▼記号/第2タグ重複---",
"------演算記号------",
 "[!]", "[+]", "[-]", "[x]", "[×]", "[＊]", "[÷]", "[／]",
"------図形記号------",
 "[★]", "[☆]", "[▲]", "[▼]", "[△]", "[▽]", "[■]", "[□]", "[◆]", "[◇]", "[●]", "[○]", "[◎]",
"-----末尾配置符-----",
 "[丶]", "[冖]"
)

#--- ★ここで分離（各自でカスタマイズ）
#--- 以下処理部分
# WPF XAMLを定義 (プレビュー用テキストボックスを編集可能に変更)
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="命名マスター v2.0  一覧から右クリック【開く】でファイル実行" Height="150" Width="550"
        Background="LightGray" Foreground="White" WindowStartupLocation="CenterScreen">
  <Grid Margin="10">
    <Grid.RowDefinitions>
      <RowDefinition Height="Auto"/>
      <RowDefinition Height="Auto"/>
      <RowDefinition Height="Auto"/>
      <RowDefinition Height="Auto"/>
    </Grid.RowDefinitions>

    <StackPanel Grid.Row="0" Orientation="Horizontal" Margin="0,0,0,0">
      <Button Name="ExtToolBtn" Content="外部ツール1" Width="60" Margin="0,0,0,0"
              ToolTip="【変換BOX_空箱】D:\myX\myXBlank\XB.bat"/>
      <Button Name="ExtToolBtn2" Content="外部ツール2" Width="60" Margin="0,0,10,0"
              ToolTip="【ユーザー】D:\myX\User.bat"/>
      <Button Name="RenameBtn" Content="命名確定" Width="60" Margin="0,0,0,0"/>
      <TextBox Name="PreviewText" Width="Auto" MinWidth="300" FontWeight="Bold"
               IsReadOnly="False" Background="#FFFFFF" Foreground="Blue"
               BorderThickness="1" HorizontalAlignment="Stretch"/>
    </StackPanel>

    <StackPanel Grid.Row="1" Orientation="Horizontal" Margin="0,0,0,10" HorizontalAlignment="Center">
        <StackPanel Orientation="Vertical" Margin="0,0,15,0">
            <Label Content="第1タグ" HorizontalAlignment="Center"/>
            <ComboBox Name="SymbolBox" Width="150" Background="#FFFFFF" Foreground="Black" MaxDropDownHeight="350"/>
        </StackPanel>
        <StackPanel Orientation="Vertical" Margin="0,0,15,0">
            <Label Content="第2タグ" HorizontalAlignment="Center"/>
            <ComboBox Name="Tag1Box" Width="150" Background="#FFFFFF" Foreground="Black" MaxDropDownHeight="350"/>
        </StackPanel>
        <StackPanel Orientation="Vertical">
            <Label Content="第3タグ" HorizontalAlignment="Center"/>
            <ComboBox Name="Tag2Box" Width="150" Background="#FFFFFF" Foreground="Black" MaxDropDownHeight="350"/>
        </StackPanel>
    </StackPanel>

    <StackPanel Orientation="Horizontal" Grid.Row="2" Margin="0,0,0,5">
      <Button Name="BrowseBtn" Content="選択(+右クリック)" Width="100"
              ToolTip="一覧から右クリック【開く】で拡張／バッチ起動"/>
      <TextBox Name="FilePathBox" Width="Auto" MinWidth="400" Margin="0,0,0,0" Background="#FFFFFF" Foreground="Black" HorizontalAlignment="Stretch"/>
    </StackPanel>
  </Grid>
</Window>
"@

# XAML読み込み
$window = [Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader $xaml))

# 各コントロール取得
$controls = @{
    SymbolBox = $window.FindName("SymbolBox")
    Tag1Box   = $window.FindName("Tag1Box")
    Tag2Box   = $window.FindName("Tag2Box")
    BrowseBtn = $window.FindName("BrowseBtn")
    FilePathBox = $window.FindName("FilePathBox")
    PreviewText = $window.FindName("PreviewText")
    RenameBtn = $window.FindName("RenameBtn")
    ExtToolBtn = $window.FindName("ExtToolBtn")
    ExtToolBtn2 = $window.FindName("ExtToolBtn2")
}

# プレビュー表示
function Update-Preview {
    $file = $controls.FilePathBox.Text
    if (-not [string]::IsNullOrWhiteSpace($file) -and (Test-Path -LiteralPath $file)) {
        $name    = [System.IO.Path]::GetFileName($file)
        $symbol  = $controls.SymbolBox.SelectedItem
        $tag1    = $controls.Tag1Box.SelectedItem
        $tag2    = $controls.Tag2Box.SelectedItem
        
        # プレビューの内容を生成
        $controls.PreviewText.Foreground = "Blue"
        $controls.PreviewText.Text = "$symbol$tag1$tag2$name"
    } else {
        $controls.PreviewText.Text = ""
    }
}

# 引数対応
function Set-SelectedFile($filepath) {
    if (Test-Path -LiteralPath $filepath) {
        $controls.FilePathBox.Text = $filepath
        Update-Preview
    }
}

# 起動時引数（ファイルパス）
if ($args.Count -gt 0) { Set-SelectedFile $args[0] }

# ファイル選択イベント
$controls.BrowseBtn.Add_Click({
    $dlg = New-Object Microsoft.Win32.OpenFileDialog
    $dlg.InitialDirectory = (Get-Location).Path  # カレント
    if ($dlg.ShowDialog()) { Set-SelectedFile $dlg.FileName }
})

# リネーム処理
$controls.RenameBtn.Add_Click({
    $src = $controls.FilePathBox.Text
    if (-not (Test-Path -LiteralPath $src)) {
        [System.Windows.MessageBox]::Show("ファイルが選択されていません", "エラー")
        return
    }
    
    # プレビューから最終的なファイル名を取得
    $newName = $controls.PreviewText.Text
    $dst = Join-Path (Split-Path $src) $newName

    try {
        Rename-Item -LiteralPath $src -NewName $newName
        $controls.FilePathBox.Text = $dst
        Update-Preview  # プレビューを更新
        [System.Windows.MessageBox]::Show("リネーム成功: `n$newName", "完了")
    } catch {
        [System.Windows.MessageBox]::Show("リネーム失敗: $_", "エラー")
    }
})

# 外部呼出し
$controls.ExtToolBtn.Add_Click({
    Start-Process "D:\myX\myXBlank\XB.bat"
})
$controls.ExtToolBtn2.Add_Click({
    Start-Process "D:\myX\User.bat"
})

# ComboBox初期化
$symbols + $tags1 | ForEach-Object { $controls.SymbolBox.Items.Add($_) }
$symbols + $tags1 + $tags2 | ForEach-Object { $controls.Tag1Box.Items.Add($_) }
$tags2     | ForEach-Object { $controls.Tag2Box.Items.Add($_) }

# イベントバインド
$controls.SymbolBox.add_SelectionChanged({ Update-Preview })
$controls.Tag1Box.add_SelectionChanged({ Update-Preview })
$controls.Tag2Box.add_SelectionChanged({ Update-Preview })
$controls.FilePathBox.add_TextChanged({ Update-Preview })

# 右クリック(WPF ContextMenu)
$menu = New-Object System.Windows.Controls.ContextMenu

# 外部1
$ext1 = New-Object System.Windows.Controls.MenuItem
$ext1.Header  = "＋ 外部ツール1... 変換BOX_空箱"
$ext1.ToolTip = "D:\myX\myXBlank\XB.bat"
$ext1.Add_Click({ Start-Process -FilePath "D:\myX\myXBlank\XB.bat" })
$menu.Items.Add($ext1) | Out-Null

# 外部2
$ext2 = New-Object System.Windows.Controls.MenuItem
$ext2.Header  = "＋ 外部ツール2... ユーザー"
$ext2.ToolTip = "D:\myX\User.bat"
$ext2.Add_Click({ Start-Process -FilePath "D:\myX\User.bat" })
$menu.Items.Add($ext2) | Out-Null

# ローカルZIP
$extZip = New-Object System.Windows.Controls.MenuItem
$extZip.Header  = "＋ ローカルZIP... ZIPRUN"
$extZip.ToolTip = "$PSScriptRoot\XZ_pak_zipを開く.bat"
$extZip.Add_Click({ Start-Process "$PSScriptRoot\XZ_pak_zipを開く.bat" })
$menu.Items.Add($extZip) | Out-Null
$menu.Items.Add((New-Object System.Windows.Controls.Separator)) | Out-Null

# ローカル選択
$subA = New-Object System.Windows.Controls.MenuItem
$subA.Header  = "≫ ローカル選択"
$subA.ToolTip = "現在位置のファイルを起動"
$basePathMenu = $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($basePathMenu)) {
    $basePathMenu = [System.IO.Directory]::GetCurrentDirectory()
}
$filesMenu = [System.IO.Directory]::GetFiles($basePathMenu, "*.*")
foreach ($f in $filesMenu) {
    $filePath = [string]$f
    $fileName = [System.IO.Path]::GetFileName($filePath)
    $item = New-Object System.Windows.Controls.MenuItem
    $item.Header = $fileName
    $item.Tag    = $filePath
    $null = $item.Add_Click({
        param($sender, $eventArgs)
        $fp = $sender.Tag
        if (-not (Test-Path -LiteralPath $fp)) { return }
        try {
            $psi = New-Object System.Diagnostics.ProcessStartInfo
            $psi.FileName = $fp
            $psi.UseShellExecute = $true
            [System.Diagnostics.Process]::Start($psi) | Out-Null
        } catch {
            [System.Windows.MessageBox]::Show("開けなかったのだ: $fp `n`n$($_.Exception.Message)")
        }
    })
    $subA.Items.Add($item) | Out-Null
}
$menu.Items.Add($subA) | Out-Null

# ユーザー補足
$mi6 = New-Object System.Windows.Controls.MenuItem
$mi6.Header = "     ユーザー補足"
$mi6.Add_Click({
    [Console]::WriteLine(" ")
    [Console]::WriteLine("《 myXName（XN） - パス一覧 - 》")
    [Console]::WriteLine(" ")
    [Console]::WriteLine("スクリプト本体: $PSCommandPath")
    [Console]::WriteLine("ローカルZIP   : $PSScriptRoot\XZ_pak_zipを開く.bat")
    [Console]::WriteLine("外部ツール1   : D:\myX\myXBlank\XB.bat")
    [Console]::WriteLine("外部ツール2   : D:\myX\User.bat")
    [Console]::WriteLine("履歴フォルダ  : $env:TEMP")
})
$menu.Items.Add($mi6) | Out-Null
$menu.Items.Add((New-Object System.Windows.Controls.Separator)) | Out-Null

# 履歴フォルダ
$mi1 = New-Object System.Windows.Controls.MenuItem
$mi1.Header = "→ 履歴フォルダを開く"
$mi1.Add_Click({ Start-Process -FilePath "$env:TEMP" })
$menu.Items.Add($mi1) | Out-Null

# エクスプローラー
$ext3 = New-Object System.Windows.Controls.MenuItem
$ext3.Header  = "＋ エクスプローラー..."
$ext3.ToolTip = "現在位置を開く$PSScriptRoot"
$ext3.Add_Click({
    explorer.exe "$PSScriptRoot"
})
$menu.Items.Add($ext3) | Out-Null
$menu.Items.Add((New-Object System.Windows.Controls.Separator)) | Out-Null

# 情報
$mi7 = New-Object System.Windows.Controls.MenuItem
$mi7.Header = " i  情報"
$mi7.Add_Click({
    [System.Windows.MessageBox]::Show(
        "myXシリーズ7`n`nmyXName（XN） - 命名マスター v2.0 -`n`n" +
        "概要：ファイル単体を命名するリネーム補助ツール",
        "i 情報")
})
$menu.Items.Add($mi7) | Out-Null
$menu.Items.Add((New-Object System.Windows.Controls.Separator)) | Out-Null

# 閉じる
$mi8 = New-Object System.Windows.Controls.MenuItem
$mi8.Header = "×  閉じる"
$mi8.Add_Click({ $window.Close() })
$menu.Items.Add($mi8) | Out-Null

# ウィンドウに割り当て（WPFは自動で右クリック反応するのだ）
$window.ContextMenu = $menu

# 初期化と表示
$window.ShowDialog() | Out-Null
