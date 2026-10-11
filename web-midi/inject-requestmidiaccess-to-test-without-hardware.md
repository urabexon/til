# Web MIDI は `requestMIDIAccess` を差し替え可能にしておくと実機なしでテストできる

`connect(request = browserRequest())` のように取得関数を引数にしておき、
テストでは `inputs` の Map と `onmidimessage` を持つ偽の MIDIAccess を渡す。
`onstatechange` を手で呼べば抜き差しも再現できる。

e2e では `page.addInitScript` で `navigator.requestMIDIAccess` を上書きし、
`page.evaluate` から偽デバイスの `onmidimessage` を叩く。

TypeScript の lib.dom は `navigator.requestMIDIAccess` を常に定義済みとして型付けしているので、
非対応ブラウザの分岐は `(navigator as Partial<Navigator>).requestMIDIAccess` で書く。

検証: Chrome 154、Vitest 5、Playwright 1.63、実機は未接続
