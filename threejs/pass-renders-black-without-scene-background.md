# TSL の `pass(scene, camera)` は `scene.background` が無いと黒で塗る

`renderer.setClearColor()` を設定していても、ポストプロセスの `pass()` 経由だと
クリアカラーは効かず、背景が黒になる。`scene.background = new Color(0x112130)` を
明示すると期待どおりになる。直接 `renderer.render()` していたときは出なかった差。

検証: three.js 0.186.1, RenderPipeline + bloom + fxaa
