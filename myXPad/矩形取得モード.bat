:: キーナビの矩形取得バッチを呼び出す
:: アプリ裏メニューのローカル選択からの起動用
@echo off
pushd "%~dp0..\myXKey"
call "XK_AltClip.bat"
popd
exit /b
