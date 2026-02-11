:: これは本体とセットで、圧縮EXE調査用の補助バッチ
:: ZIP内のEXEを実行前に判定と内部ヘルプを表示する
@echo off
:: この場所で ZIPRUN を呼ぶ
pushd "D:\myX\myXConv\XC"
call "D:\myX\myXZipRun\XZ_exe.bat"
popd

:: 解凍済みファイルを指定して XV 起動
echo 【ZIPRUN操作】
echo EXE内部確認 ≫ EXE選択後、右クリックから 解凍＋閉じる
echo そのまま起動 ≫ 解凍 ＋ 実行ボタン
echo.
echo 【解凍後の操作】
echo [Enter]で続行 ≫ Xビューで確認
pause
:: 解凍先フォルダにあるファイルをセット
for %%f in ("%Temp%\ExeCollection\*.*") do (
    myXView.exe "%%f"
)
exit /b
