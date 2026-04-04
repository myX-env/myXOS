:: 指定アプリを固定パスから呼び出すバッチ
@echo off
rem 現場移動 → 本体起動 → 元戻り
pushd "%~dp0..\myXZipRun\"
call XZ.bat %*
popd
exit /b

---★ここからアプリ情報

=================================
 myXシリーズ6（XZ）
 myXZipRun - ZIPRUN v1.0 -
=================================
ZIP解凍後のファイル構成、簡易解説

■ ファイル最小構成
 myXZipRun
 ├ myXZipRun.exe … ZIPRUN（本体）
 ├ readme.txt … このファイル
 └ XZ_pak.zip …テスト用ツール集＋この解説書
──────────────────────

■ 概要
ZIPRUN は、ZIP内のファイル（バッチやPS、
EXE）を仮想的に取り出して即実行できる、
安全な中継ランチャー」なのだ。

■ 動作環境
・OS: Windows 7 以降（PowerShell実行可能な環境）
・.NET Framework 4.8 必須
・C# により開発

■ 起動方法
1. 「myXZipRun.exe」をダブルクリックして起動
2. ZIP内のファイルが表示され、選択可能
3. 参照から処理ファイルを選択、無ければ空欄
4. 解凍＋実行ボタンで処理を実行

■ 使用例：コマンドで中のファイルを動かすのだ
 myXZipRun.exe Timemo.exe
   → これは zip の中の Timemo.exe を一時的に
　　　取り出して実行するコマンドなのだ！
※myXZipRun.exe /x Timemo.exe … 解凍のみ

 起動オプション付きでも使えるし、PowerShell
 スクリプトもいけるのだ！
 myXZipRun.exe tool.ps1 -Verbose
 myXZipRun.exe tool.exe /silent /log

■ 備考
・zip ファイル名に関係なく、一時展開先は
  %%TEMP%%\ExeCollection に固定されています
・実行ファイルは一時展開され、次回の
　 ZIPRUN 起動時に自動で削除されます
　 必要に応じてTEMP 内の再利用も可能です
・単体ではZIPランチャーとして使用可能です

■ 注意事項
・設定は記録されません(config.iniは不要)
・レジストリは使用していません
・ショートカット（.lnk）は直接実行できません
・バッチファイル（.bat/.cmd）は単体ファイル
　のみ対応（呼び出し先での依存不可）
・パスに空白を含むファイルは正常に渡せない
　場合があります
・UACのある環境では管理者権限が必要な
　ツールは起動できない場合があります

※ 詳細やFAQは readme.txt を参照

---★ここまでアプリ情報
