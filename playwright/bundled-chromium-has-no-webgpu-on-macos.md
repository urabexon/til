# Playwright 同梱の Chromium は macOS で WebGPU が使えない。`channel: 'chrome'` を使う

同梱 Chromium は `navigator.gpu` があっても adapter が取れず、three.js は WebGL2 に落ちる。
インストール済みの Google Chrome を使うと headless でも WebGPU が動く。

```ts
use: { ...devices['Desktop Chrome'], channel: 'chrome' }
```

CI の Linux ランナーでも `pnpm exec playwright install --with-deps chrome` で同じチャンネルを入れる。

`browser.newContext()` に `channel` は渡せない（launch のオプション）。

検証: Playwright 1.63, Chrome 154, macOS 14
