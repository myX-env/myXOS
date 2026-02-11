:: 割込み切替えを呼ぶCMDバッチ
:: 瞬時に反映、確認なし
:: ※ このバッチを起動すると_Exeway⇔_Exeway+ どちらかになる
:: ※ 内部のファイル名も 禁止と許可が入替わる
@echo off
pushd "%~dp0..\_Exeway" || pushd "%~dp0..\_Exeway+"
call 割込みを禁止する.cmd || call 割込みを許可する.cmd
popd
exit /b
