# three.js 0.186 で `PostProcessing` は `RenderPipeline` に改名されている

`import { PostProcessing } from 'three/webgpu'` は動くが、typescript-eslint の
deprecation ルールで `PostProcessing is deprecated. Use RenderPipeline instead` になる。
API は同じで、`new RenderPipeline(renderer, outputNode)` と `.render()`。

TSL まわりはリリースごとに名前が動くので、three.js は `-E` で完全固定しておく。

検証: three.js 0.186.1, @types/three 0.186.0
