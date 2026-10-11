# `pkill -f "vite --port 5199"` が効かず、丸一日古いサーバーが生き残っていた

pnpm 経由で起動した vite の実コマンドラインは
`node .../vite/bin/vite.js --port 5199` で、`vite --port` という連続した文字列を含まない。
`pkill -f` は黙って何もしないので、翌日まで古いコードを配る dev サーバーが残っていた。

ポートで殺す方が確実。

```sh
kill $(lsof -t -iTCP:5199 -sTCP:LISTEN)
```

検証: macOS 14, pnpm 10, Vite 8
