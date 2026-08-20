# PATH 上の `git-*` は自動的に git のサブコマンドになる

`PATH` にある実行ファイルのうち `git-<名前>` という名前のものは、
`git <名前>` として呼べる。git 側に登録は要らない。

```sh
$ cp git-brink /usr/local/bin/
$ git brink --version
git-brink 0.1.0
```

## 拡張子を付けると壊れる

git は **`git-<名前>` の完全一致**で探すので、`.sh` を付けると見つからない。

```sh
$ ls /usr/local/bin/git-brink.sh
$ git brink --version
git: 'brink' is not a git command. See 'git --help'.
```

`git brink.sh` なら動くが、サブコマンドとして自然に呼べる利点が消える。
PATH に置く実行ファイルに拡張子を付けない慣習（`ls`, `curl`, `git` など）とも
一致するので、付けないのが正解。実装言語を変えても名前を変えずに済む。

検証: git 2.x / macOS
