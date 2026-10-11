# `renderer.info.render.timestamp` は解決するまで累積する

WebGPURenderer を `trackTimestamp: true` で作ると、`await renderer.resolveTimestampsAsync('render')`
の後に `renderer.info.render.timestamp` に GPU 時間（ms）が入る。

ただしこの値は**前回の解決からの合計**で、1 フレーム分ではない。
10 フレームごとに解決していたら、60 fps で動いているアプリで 100 ms 超が出て面食らった。
解決の間隔で割ると 1 フレームあたりの値になる。

```ts
const batch = framesSinceResolve; framesSinceResolve = 0;
await renderer.resolveTimestampsAsync('render');
const gpuMs = renderer.info.render.timestamp / batch;
```

VRAM は `renderer.info.memory.total`（バイト）で、こちらは累積ではない。

検証: three.js 0.186.1, WebGPU, Chrome 154
