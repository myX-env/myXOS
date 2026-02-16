@echo off
:: ZIP内の丶Mode_myX.ps1を起動（オプション1文字入力も対応）
:: オプション選択：A～Z / XA～XZ（例：P D:\myX\User.bat）
:: X省略可：X=EX（テスト用）

pushd "D:\myX\myXZipRun"

:: XZ_exe.batを呼び出し、丶Mode_myX.ps1を引数付きで実行
call "XZ_exe.bat" "丶◆Mode_myX.ps1" %*

popd
exit /b
