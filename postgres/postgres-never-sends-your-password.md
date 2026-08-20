# PostgreSQL 14 以降はパスワードを平文で送っていない

接続文字列にパスワードを書いていても、**ネットワーク上をパスワード自体は流れない**。
PostgreSQL 14 から `password_encryption` の既定値が `scram-sha-256` になった。

SCRAM（Salted Challenge Response Authentication Mechanism, RFC 5802）は
チャレンジ＆レスポンス方式で、

1. サーバがランダムなナンス（チャレンジ）を返す
2. クライアントがパスワード由来の鍵でそれを処理した証明を返す
3. サーバは保存済みの値で同じ計算をして照合する

パスワードそのものは往復しない。同じ仕組みは MongoDB、
IMAP/SMTP/XMPP の SASL でも既定になっている。

## 確認方法

```sql
SHOW password_encryption;   -- scram-sha-256
SELECT rolname, rolpassword FROM pg_authid;  -- SCRAM-SHA-256$4096:...
```

`pg_hba.conf` が `trust` や `md5` なら話は別なので、そちらも見る。

関連: チャレンジ認証の系譜（CHAP → SRP → OPAQUE → passkeys）
