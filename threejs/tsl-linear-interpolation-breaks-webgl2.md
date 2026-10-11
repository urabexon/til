# TSL の `varying().setInterpolation('linear')` は WebGL2 フォールバックを壊す

three.js の TSL で varying に `setInterpolation('linear')` を付けると、
WGSL では `@interpolate(linear)` になるが、GLSL 側では `noperspective` 修飾子が出力される。
`noperspective` は GLSL ES 3.0 に存在しないため、WebGL2 バックエンドでは
そのマテリアルを使う全ドローが `Shader Error 1282 - VALIDATE_STATUS false` で落ちる。

WebGPU で開発していると気づけない。`navigator.gpu` を `undefined` にして起動する
e2e を 1 本持っておくと、こういう「片方だけ壊れる」変更を拾える。

両レールが同じ w を持つ（画面空間で押し出した太線など）なら、
そもそも perspective 補間と linear 補間の結果は同じなので、指定自体が不要。

検証: three.js 0.186.1, Chrome 154, macOS 14
