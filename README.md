# TOROMapDownloader

TOROサーバーの地図(Dynmap)を、png ファイルとしてダウンロードするツールです。
Docker イメージとして使います。

## 取得元

既定の取得元は TORO の地図 API `https://api.torosaba.net/map/v1` です。
環境変数 `DYNMAP_BASE_URL` で変更できます。

```pwsh
docker run --rm -e DYNMAP_BASE_URL=https://example.com/map/v1 -v ${PWD}/map:/app/map ghcr.io/toro-server/toro-map-downloader
```

取得元は次の経路を提供している必要があります(ベース URL からの相対経路)。

| 経路 | 内容 |
| --- | --- |
| `configuration` | ワールドと地図の設定(JSON) |
| `world/{world}/{timestamp}` | ワールドの更新情報(JSON) |
| `tiles/{world}/{map}/…` | タイル画像 |

画像の結合には [minecraft-dynmap-timemachine](https://github.com/hampta/minecraft-dynmap-timemachine) を使います。
取得元の API には Dynmap の `standalone/config.js` が無いため、ビルド時に次の処理を行います。

- `minecraft-dynmap-timemachine` を固定のコミットで取得します(`setup.sh` の `TIMEMACHINE_COMMIT`)。
- `patches/` のパッチを自動で適用します。`patches/dynmap-fixed-urls.patch` は、`standalone/config.js` を取得せず、固定の経路を使うように変更します。パッチが適用できない場合、ビルドは失敗します。

タイルの拡張子は `.png` ですが、中身は WebP です。結合は問題なく行えます。

## Docker Build

```pwsh
docker build -t toro-server/toro-map-downloader -f main.dockerfile .
```

## 公開(リリース)

`v*.*.*` 形式のタグを push すると、GitHub Actions がイメージを `ghcr.io/toro-server/toro-map-downloader` へ公開します(`latest`、バージョン、コミットの短縮 ID の各タグ)。
main へのマージだけでは公開されません。Actions から手動で実行することもできます。