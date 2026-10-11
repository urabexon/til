# 画面空間のサイズは devicePixelRatio を掛けないと Retina で半分になる

シェーダーの `screenSize`（three.js の `viewportResolution` 相当）は物理ピクセルなので、
「線幅 2 px」を物理 2 px で押し出すと Retina では CSS 1 px 相当になる。
Bloom の半径やレンズの半径も同じ。

headless Chrome は既定で deviceScaleFactor 1 なので、スクリーンショットのテストでは見えない。
Playwright なら `newContext({ deviceScaleFactor: 2 })` で撮り比べる。

対処は、ピクセル比を uniform に持ってリサイズ時に更新し、px 指定の値に掛けるだけ。
Bloom は `setResolutionScale(1 / dpr)` で広がりを揃えつつ負荷も下げられる。

検証: MacBook Air (dpr 2), three.js 0.186.1
