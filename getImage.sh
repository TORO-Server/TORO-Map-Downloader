#!/bin/bash

# このshファイルがあるディレクトリに移動(相対パスに対応させるため)
cd "$(dirname "$0")"

# 取得元の地図 API のベース URL (環境変数 DYNMAP_BASE_URL で差し替え可能)
BASE_URL="${DYNMAP_BASE_URL:-https://api.torosaba.net/map/v1}"

# Dynmapの画像を取得する
# https://github.com/hampta/minecraft-dynmap-timemachine
cd ./minecraft-dynmap-timemachine
python3 dynmap-timemachine.py -v "$BASE_URL" main flat [0,100,-2000] [25,25] 4 ../map/main-flat -th 32
rm .cache -R
python3 dynmap-timemachine.py -v "$BASE_URL" flat flat [0,100,0] [10,10] 4 ../map/flat-flat -th 32