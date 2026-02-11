#-----------------------------
# myXシリーズ3（XH）
# myXHelper - Xヘルパー v1.0 -
# メモ帳編集だけで使える
# 設定/ヘルプ/実行一体型ランチャー。
# 本体がそのままマニュアルなので、
# 見ながら直感的に調整できるのだ。
# 2ページ切替型
#---------------------------------
$objShell = New-Object -ComObject WScript.Shell  # PowerShellスクリプト

# 追加記述例：@("+ゲーム", "D:\\GAME\\RPG.exe"), // ESCS形式フルパスで記述(\→\\) ★ユーザー確認★

# アプリ一覧：Windowsアプリ＋α // ユーザー追加枠には(+)プラス、zip内アプリは(ZR/)付加
$apps = @(
    @("Win設定（10以降）", "cmd /c start ms-settings:"),
    @("ごみ箱/エクスプローラー", "explorer shell:RecycleBinFolder"),
    @("ファイル名指定実行", "explorer shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}"),
    @("コマンドプロンプト", "cmd.exe"),
    @("PowerShell", "powershell.exe"),
    @("コントロールパネル", "control.exe"),
    @("ディスククリーンアップ", "cleanmgr.exe"),
    @("タスクマネジャー", "taskmgr.exe"),
    @("音声ボリューム", "sndvol.exe"),
    @("電卓", "calc.exe"),
    @("スクリーンキーボード", "osk.exe"),
    @("SnippingTool", "SnippingTool.exe"),
    @("ペイント", "mspaint.exe"),
    @("メモ帳/ヘルプ編集", "notepad myXHelper.ps1"),	# メモ帳で本体を編集
    @("+変換もどき起動", "myXConv.exe"),			# 変換もどき起動
    @("+★更新（変換もどき）", "Tools\\丶★更新.bat"),	# 変換もどき更新
    @("+ﾂｰﾙ切替（変換もどき）", "T_change.bat"),	# ツールをUserとチェンジ
    @("ZR/ZIPリスト", "D:\\myX\\myXConv\\Tools\\#XC_zipを開く.bat")	# zip内アプリの確認/実行
    @("ZR/Hello, World!", "D:\\myX\\myXConv\\Tools\\#XC_zipを開く.bat Hello.bat"),		# zip内を指定
    @("ZR/メモ帳を起動", "D:\\myX\\myXConv\\Tools\\#XC_zipを開く.bat メモ帳を起動.ps1"),		# zip内を指定
    @("ZR/Xヘルパー更新", "D:\\myX\\myXConv\\Tools\\#XC_zipを開く.bat Xヘルパー更新.bat"),	# zip内を指定
    @("+変換BOX_空箱", "D:\\myX\\myXConv\\Tools\\#変換BOX_空箱.bat"),
    @("+ユーザー（カスタム）", "D:\\myX\\User.bat"),
    @("dir：テスト", "cmd /k dir & pause & exit"),	# コマンドサンプル
    @("未登録", ""),
    @("未登録", ""),
    @("未登録", ""),
    @("未登録", ""),
    @("未登録", ""),
    @("未登録", ""),
    @("未登録", ""),
    @("未登録", ""),
    @("未登録", ""),
    @("未登録", ""),
    @("未登録", ""),
    @("拡大鏡 (行き場なし)", "magnify.exe"),
    @("注):レジストリエディタ", "regedit.exe"),
    @("ここが最終項目", "")  # 最終項目","は入れない
)

# HTML作成用ファイルパス
$htaFile = [System.IO.Path]::Combine($env:TEMP, "launcher.hta")

# ファイル作成
$objFSO = New-Object -ComObject Scripting.FileSystemObject
$objFile = $objFSO.CreateTextFile($htaFile, $true)

# HTML文字列作成
$html = "<html><head><title>Xヘルパー v1.0</title>" + [Environment]::NewLine
$html += "<HTA:APPLICATION windowWidth='768' windowHeight='418' windowResizable='no' border='thin' scroll='no' sysmenu='yes' />" + [Environment]::NewLine
$html += "<style>" + [Environment]::NewLine
$html += "body { text-align: center; background-color: black;}" + [Environment]::NewLine
$html += "button { width: 170px; height: 24px;}" + [Environment]::NewLine
$html += "</style>" + [Environment]::NewLine
$html += "</head><body>" + [Environment]::NewLine

# ページ替えボタンを追加
$html += "<button onclick='changePage()'>▲/▼</button>" + [Environment]::NewLine

# アプリボタンをHTMLに追加
$html += "<div id='page1'>" + [Environment]::NewLine
for ($i = 0; $i -lt 19; $i++) {
    $html += "<button onclick='RunApp(""" + $apps[$i][1] + """)' title='右クリック：ガイド'>" + $apps[$i][0] + "</button>" + [Environment]::NewLine}
$html += "</div>" + [Environment]::NewLine

$html += "<div id='page2' style='display:none;'>" + [Environment]::NewLine
for ($i = 19; $i -lt $apps.Length; $i++) {
    $html += "<button onclick='RunApp(""" + $apps[$i][1] + """)'>" + $apps[$i][0] + "</button>" + [Environment]::NewLine
}
$html += "</div>" + [Environment]::NewLine

# 解像度1280ｘ768（デフォルト）
# 画面解像度：1920Ｘ1080の場合	// window.moveTo(990, 98) →(1310, 270) ★ユーザー確認★
$html += "<script>" + [Environment]::NewLine
$html += "window.resizeTo(200, 540);window.moveTo(990, 98);" + [Environment]::NewLine
$html += "function RunApp(app) { if (app) { new ActiveXObject('WScript.Shell').Run(app, 1, false); } }" + [Environment]::NewLine
$html += "var currentPage = 1;" + [Environment]::NewLine
$html += "function changePage() {" + [Environment]::NewLine
$html += "    if (currentPage === 1) {" + [Environment]::NewLine
$html += "        document.getElementById('page1').style.display = 'none';" + [Environment]::NewLine
$html += "        document.getElementById('page2').style.display = 'block';" + [Environment]::NewLine
$html += "        currentPage = 2;" + [Environment]::NewLine
$html += "    } else {" + [Environment]::NewLine
$html += "        document.getElementById('page2').style.display = 'none';" + [Environment]::NewLine
$html += "        document.getElementById('page1').style.display = 'block';" + [Environment]::NewLine
$html += "        currentPage = 1;" + [Environment]::NewLine
$html += "    }" + [Environment]::NewLine
$html += "}" + [Environment]::NewLine
$html += "document.oncontextmenu = function() {" + [Environment]::NewLine
$html += "  window.event.returnValue = false;" + [Environment]::NewLine
$html += "  alert(" + [Environment]::NewLine
$html += "    'myXシリーズ3  myXHelper（XH）\n\n' +" + [Environment]::NewLine
$html += "    '《Xヘルパーガイド》  - Xヘルパー v1.0 - \n\n' +" + [Environment]::NewLine
$html += "    'ここは単なる解説用ヘルプ。個人向けに書き直していいのだ\n\n' +" + [Environment]::NewLine
$html += "    '・「メモ帳/ヘルプ編集」は、本体を直接編集できる\n' +" + [Environment]::NewLine
$html += "    '　修正を適用するには本体の再起動が必要\n\n' +" + [Environment]::NewLine 
$html += "    '専門知識がなくても､手軽に調整できるスクリプトなのだ!'" + [Environment]::NewLine # 最終行は+を削除
$html += "  );" + [Environment]::NewLine
$html += "}" + [Environment]::NewLine
$html += "</script>" + [Environment]::NewLine

# HTMLファイルを書き込む
$objFile.Write($html)
$objFile.Close()

# HTAを実行
$objShell.Run("mshta """ + $htaFile + """")
