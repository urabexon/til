# fps が出ないときは、まず about:blank で requestAnimationFrame の周期を測る

アプリが 50 fps で止まり、描画解像度を 4 分の 1 にしても変わらなかった。
何も描いていない about:blank で rAF を 120 回数えたら 51 Hz だった。
つまりアプリの負荷ではなく、ブラウザの描画タイミングが 50 Hz に制限されていた
（外部ディスプレイのリフレッシュレート、または Chrome の省エネモード）。

```js
(async () => { let n = 0; const t = performance.now();
  await new Promise(r => { const f = () => (++n < 120 ? requestAnimationFrame(f) : r()); requestAnimationFrame(f); });
  console.log(Math.round(120000 / (performance.now() - t)), 'Hz'); })();
```

headless Chrome は 60 Hz に固定されるので、この種の差は自動テストでは再現しない。

検証: Chrome 154, macOS 14, MacBook Air + 外部ディスプレイ
