:: 指定アプリを固定パスから呼び出すバッチ
@echo off
rem 現場移動 → 本体起動 → 元戻り
pushd "%~dp0..\myXView\"
start "" /b myXView.exe %*
popd
exit /b

---★ここからアプリ情報

@HELP_START@
myXシリーズ15（XV） myXView Xビュー v1.0
EXEファイルの埋め込みヘルプをメモリ内で高速表示します。
機能:
Xワーカー簡易版に基づくヘルプランチャー。
EXE実行前に内容を確認でき、EXEやDLLの判定が可能です。
補助バッチを配置して、BOXからのコピペを活用できる柔軟仕様。
起動方法
実行コマンド: プログラム.exe "ファイルパス"
例: myXView.exe "D:\Tools\Myapp.exe"
元容量：10752バイト
@HELP_END@

---★ここまでアプリ情報
