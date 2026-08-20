# bash のコマンド置換は NUL バイトを捨てる

`-z` オプションで NUL 区切り出力を得ても、`$( )` を通した時点で NUL が消える。

```sh
# 壊れる: NUL が失われ、1行として扱われる
entries=$(git ls-files -z)

while IFS= read -r -d '' e; do ...; done <<EOF
$(git ls-files -z)
EOF
```

bash は `command substitution: ignored null byte in input` を出すこともあるが、
黙って落とす場合もある。

## 正解はプロセス置換

```sh
while IFS= read -r -d '' path; do
  ...
done < <(git ls-files -z)
```

パイプ（`git ls-files -z | while ...`）ではなくプロセス置換にすると、
**ループがサブシェルではなく現在のシェルで走る**ので、
ループ内で増やしたカウンタや変数がループ後も残る。

検証: bash 3.2.57 (macOS 標準)
