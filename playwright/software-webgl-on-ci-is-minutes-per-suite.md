# GitHub の Linux ランナーは WebGL をソフトウェア描画するので、重い e2e はフルで回せない

GPU が無いので Chrome は SwiftShader で描く。1440×900 にポストプロセス 6 段の
アプリだと 1 フレームに数秒かかり、52 件のスイートが 24 分で、しかも途中でタイムアウトする。

手元で同じ条件を作るには Chrome に `--disable-gpu --use-gl=angle --use-angle=swiftshader` を渡す。

落としどころは、起動・キー操作・フォールバックなどの煙テストにタグ（`@smoke`）を付けて
CI はそれだけ回し（`--grep @smoke`、1 ワーカー、低い内部解像度）、
描画の見た目に関わるテストは手元で回す運用。

検証: Playwright 1.63, ubuntu-latest, 2026-10
