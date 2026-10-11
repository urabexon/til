# zod 4 の `zod/mini` は通常版の 3 分の 1 のバンドル増で済む

three.js 製アプリに zod を入れたら gzip 後 +26 kB だった。
`import * as z from 'zod/mini'` に変えると +7.6 kB。
API はメソッドチェーン（`.min(3)`）ではなく関数（`z.array(x).check(z.minLength(3))`）になるが、
`z.infer` も `superRefine` も使える。

型は `z.infer` で導出し、手書きの型を並べて置かない。
同じスキーマをビルドスクリプト（Node）と実行時（ブラウザ）の両方から import すると、
検証コードが 1 か所になる。

検証: zod 4.6.5, Vite 8, three.js 0.186.1
