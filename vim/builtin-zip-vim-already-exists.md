# Vim には標準で `zip.vim` がある（アーカイブ閲覧用）

```sh
$ ls /usr/share/vim/vim90/autoload/zip.vim
-rw-r--r--  1 root  wheel  15335 ...
```

`.zip` を Vim で開くと中身を一覧・編集できるのはこれのおかげ。
使う変数は `g:zip_unzipcmd` `g:zip_zipcmd` `g:zip_shq` `g:zip_nomax`
`g:zip_extractcmd`。

自作プラグインを `zip.vim` と名付けると、機能が全く別なのに
**同じ `g:zip_*` 名前空間に同居する**ことになる。

## プラグインを作るときの最低限

```vim
if exists('g:loaded_myplugin') | finish | endif
let g:loaded_myplugin = 1
let g:myplugin_option = get(g:, 'myplugin_option', 2)
```

- ロードガードを付ける（二重読み込みの防止）
- 変数は自分のプラグイン名を前置きする
- `:h` で引けるよう `doc/myplugin.txt` を置く

また `command! -range` の既定は**現在行**なので、範囲指定なしで呼ぶと1行だけが
対象になる。バッファ全体を既定にしたいなら `-range=%`。

検証: Vim 9.0 / macOS
