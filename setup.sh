#!/bin/bash
set -euo pipefail

# このshファイルがあるディレクトリに移動
cd "$(dirname "$0")"

# 取得する minecraft-dynmap-timemachine のコミット(固定)
TIMEMACHINE_COMMIT=706631eb5f01377fb40400ac96f3eed62f77281e

# mapディレクトリ作成
mkdir -p map

# git クローン (コミットを固定)
git clone https://github.com/hampta/minecraft-dynmap-timemachine.git
cd ./minecraft-dynmap-timemachine
git checkout "$TIMEMACHINE_COMMIT"

# patches/ のパッチをすべて適用 (適用できなければビルドを失敗させる)
for p in ../patches/*.patch; do
  echo "apply: $p"
  git apply --verbose "$p"
done

# ライブラリインストール
pip install -r requirements.txt