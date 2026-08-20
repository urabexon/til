# macOS の `/bin/bash` は今も 3.2

```sh
$ /bin/bash --version
GNU bash, version 3.2.57(1)-release (arm64-apple-darwin23)
```

ライセンス（bash 4 以降が GPLv3）の都合で更新されていない。
配布するスクリプトを `#!/usr/bin/env bash` で書くと、
利用者の環境によっては 3.2 で動くことになる。

## 3.2 で使えないもの

| 機能 | 必要バージョン |
|---|---|
| 連想配列 `declare -A` | 4.0 |
| `mapfile` / `readarray` | 4.0 |
| `${var,,}` / `${var^^}`（大小変換） | 4.0 |
| `**` によるグロブ再帰 | 4.0 |
| `wait -n` | 4.3 |

代替: 連想配列 → 区切り文字入りの文字列や `case`、
大小変換 → `tr '[:upper:]' '[:lower:]'`。

`bash -n script` は構文チェックのみなので、**3.2 で実際に走らせて確認する**。

## ついでに `timeout` も無い

GNU coreutils の `timeout` は macOS に標準で入っていない。
`brew install coreutils` で `gtimeout` になる。

検証: macOS 14 (Darwin 23.5.0)
