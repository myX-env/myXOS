:: ZIPRUNの総合ZIP用
:: これをZIPに配置し、本家ZIP参照、EXEアプリ指定＋引数も可能
@echo off
pushd "%~dp0"
call "D:\myX\myXZipRun\XZ.bat" %*
popd
exit /b
