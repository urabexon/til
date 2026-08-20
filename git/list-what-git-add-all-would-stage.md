# `git add -A` が実際に何を追加するかを事前に列挙する

`git ls-files --others --exclude-standard` が、
**未追跡かつ ignore されていないパス** ＝ `git add -A` が新規に追加するもの、
をそのまま返す。

```sh
git ls-files --others --exclude-standard -z
```

`git status --porcelain` をパースするより正確で速い。
`-z` を付けると NUL 区切りになり、空白や改行を含むファイル名でも壊れない。

## 巨大なリポジトリでは `--directory` が必須

`.gitignore` の無いリポジトリ（例: 事故で `$HOME` がリポジトリになった場合）では、
上のコマンドは `Library/` や全 `node_modules` を歩き回るため数分かかる。

```sh
git ls-files --others --exclude-standard --directory --no-empty-directory -z
```

`--directory` は**丸ごと未追跡のディレクトリを1エントリに畳む**ので、
git はその中へ降りない。実測で 5分超 → 3秒 になった。

畳まれた中身が必要なら、自分で浅く（`find -maxdepth 2` など）降りる。
全部を git に歩かせるより速い。

検証: git 2.x / macOS, ホームディレクトリ（未追跡 197 エントリ）
