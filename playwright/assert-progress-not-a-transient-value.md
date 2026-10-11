# 進行中の値を「ちょうど 0」と決め打ちすると遅い CI で落ちる

デモ再生をクリックした直後に `toHaveAttribute('data-cue', '0')` としていたら、
手元では通るのに CI（ソフトウェア描画で 10 fps）では既にキュー 5 まで進んでいて落ちた。

「ある瞬間の値」ではなく「単調に進むこと」を検証する。

```ts
const first = Number(await html.getAttribute('data-cue'));
await expect
  .poll(async () => Number(await html.getAttribute('data-cue')), { timeout: 15_000 })
  .toBeGreaterThan(first);
```

検証: Playwright 1.63, GitHub Actions ubuntu-latest
