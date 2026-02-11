:: これは本体とセットで、圧縮EXE調査用の補助バッチ
:: 解凍EXEの判定時、連携起動するために必要
powershell -ExecutionPolicy Bypass -File %*
exit
