# TSL の `hash()` を画面座標に使うとフィルムグレインが縞になる

`hash(uv + time)` のような使い方だと、横縞がはっきり出る。
`hash()` は float 1 本を受け取る設計で、2 次元の座標を 1 本に畳む前提がない。

古典的な `fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453)` に戻すと縞は消えた。

```ts
const pixel = uv().mul(screenSize).add(time.fract().mul(173));
const noise = fract(sin(dot(pixel, vec2(12.9898, 78.233))).mul(43758.5453)).sub(0.5);
```

検証: three.js 0.186.1, WebGPU
