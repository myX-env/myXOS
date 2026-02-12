#--------------------------
# myXシリーズ3（XH） 軽量版
# myXHelper - Xヘルパー v1.0 -
# メモ帳編集だけで使える
# 設定・ヘルプ・実行一体型ランチャー。
# 本体がそのままマニュアルなので、
# 見ながら直感的に調整できるのだ。
#--------------------------
$objShell = New-Object -ComObject WScript.Shell		# PowerShellスクリプト

# 追加記述例：@("+ゲーム", "D:\\GAME\\RPG.exe"), // ESCS形式フルパスで記述(\→\\) ★ユーザー確認

# アプリ一覧：Windowsアプリ＋α // 未登録には(+)プラス、zip内アプリは(ZR/)付加
$apps = @(
    @("Win設定（10以降）", "cmd /c start ms-settings:"),
    @("エクスプローラー", "explorer.exe"),
    @("コントロールパネル", "control.exe"),
    @("注):レジストリエディタ", "regedit.exe"),
    @("ディスククリーンアップ", "cleanmgr.exe"),
    @("コマンドプロンプト", "cmd.exe"),
    @("PowerShell", "powershell.exe"),
    @("タスクマネジャー", "taskmgr.exe"),
    @("音声ボリューム", "sndvol.exe"),
    @("メモ帳/ヘルプ編集", "notepad myXHelper_Lite.ps1"),	# ★メモ帳で本体を編集
    @("ワードパッド", "write.exe"),
    @("ペイント", "mspaint.exe"),
    @("電卓", "calc.exe"),
    @("文字コード表", "charmap.exe"),
    @("スクリーンキーボード", "osk.exe"),
    @("拡大鏡", "magnify.exe"),
    @("スニッピングツール", "snippingtool.exe"),
    @("マウスのプロパティ", "control main.cpl"),
    @("画面のプロパティ", "control desk.cpl"),
    @("プログラムの追加と削除", "control appwiz.cpl"),
    @("地域と言語", "control intl.cpl"),
    @("サウンド", "control mmsys.cpl"),
    @("ネットワーク", "control ncpa.cpl"),
    @("システム", "control sysdm.cpl"),
    @("日付と時刻", "control timedate.cpl"),
    @("ハードウェアの追加", "control hdwwiz.cpl"),
    @("ファイアウォール", "control firewall.cpl"),
    @("電源", "control powercfg.cpl"),
    @("システムの保護(復元)", "SystemPropertiesProtection.exe"),
    @("システムの詳細設定", "SystemPropertiesAdvanced"),
    @("デバイスマネージャ関連", "SystemPropertiesHardware.exe"),
    @("ファイル名指定実行", "explorer shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}"),
    @("ごみ箱", "explorer shell:::{645FF040-5081-101B-9F08-00AA002F954E}"),
    @("+変換BOX_空箱", "D:\\myX\\myXBlank\\XB.bat"),
    @("+ユーザー（カスタム）", "D:\\myX\\User.bat"),
    @("+XH_zipを開く", "D:\\myX\\myXHelper\\XH_zipを開く.bat"),
    @("+ZIPRUNのZIPリスト", "D:\\myX\\myXZipRun\\XZ.bat"),
    @("+ZR/PSテスト：Hello", "D:\\myX\\myXZipRun\\XZ.bat Hello.ps1"),
    @("未登録", ""),
    @("未登録", ""),
    @("未登録", ""),
    @("ここが最終項目", "")  # 最終項目","は入れない
)

# HTML作成用ファイルパス
$htaFile = [System.IO.Path]::Combine($env:TEMP, "launcher.hta")

# ファイル作成
$objFSO = New-Object -ComObject Scripting.FileSystemObject
$objFile = $objFSO.CreateTextFile($htaFile, $true)

# HTML文字列作成
$html = "<html><head><title>Xヘルパー軽量版</title>" + [Environment]::NewLine
$html += "<HTA:APPLICATION windowWidth='768' windowHeight='418' windowResizable='no' border='thin' scroll='yes' sysmenu='yes' />" + [Environment]::NewLine
$html += "<style>" + [Environment]::NewLine
$html += "body { text-align: center; background-color: black;}" + [Environment]::NewLine
$html += "button { width: 170px; height: 24px;}" + [Environment]::NewLine
$html += "</style>" + [Environment]::NewLine
$html += "</head><body>" + [Environment]::NewLine

# アプリボタンをHTMLに追加
foreach ($app in $apps) {
    $html += "<button onclick='RunApp(""" + $app[1] + """)'>" + $app[0] + "</button>" + [Environment]::NewLine
}

# 解像度1280ｘ768（デフォルト）
# 画面解像度：1920Ｘ1080の場合	// window.moveTo(990, 98) →(1310, 270) ★ユーザー確認★
$html += "<script>" + [Environment]::NewLine
$html += "function RunApp(app) { if (app) { new ActiveXObject('WScript.Shell').Run(app, 1, false); } }" + [Environment]::NewLine
$html += "window.resizeTo(225, 540);window.moveTo(990, 98);" + [Environment]::NewLine
$html += "</script>" + [Environment]::NewLine

# HTMLファイルを書き込む
$objFile.Write($html)
$objFile.Close()

# HTAを実行
$objShell.Run("mshta """ + $htaFile + """")
