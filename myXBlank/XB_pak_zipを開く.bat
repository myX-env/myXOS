:: ローカル実行（自身の場所から実行）
:: 自身と違う場所のZIPが参照される
:: アプリ裏メニューのローカル選択からの起動用
@echo off
rem 場所固定 → 本体起動 → 元戻り
pushd "%~dp0XB"
call "%~dp0..\myXZipRun\XZ_exe.bat" %*
popd
exit /b
