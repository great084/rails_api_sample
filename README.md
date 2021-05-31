## APIの概要

フロントエンドの検証用としてRailsのAPIモードで作成したAPIになります。
ログイン認証のためのUserと、User紐づくBookデータ(1:多の関係)を格納しています。
Bookリソースに悪世するためにはアクセストークンによる認証が必要です。
トークン認証を実装するために[devise_token_auth](https://devise-token-auth.gitbook.io/devise-token-auth/) gemを利用しています。
※フロント側の動作検証時に使い勝手が良いように、access-tokenがリクエストごとに使い回せる設定にしています（devise_token_authデフォルトの設定ではリクエスト毎にaccess-tokenが更新される）

## APIの接続先URL

Heroku上で動いています（Freeeプランなので、スリープ時には復帰に2,30秒かかるかも）
`https://rails-api-book.herokuapp.com`

## 作成済みユーザ

以下のユーザが利用可能です。
| メールアドレス             | パスワード    | 備考      |
|---------------------|----------|-----------|
| test@example.com    | password | Bookデータあり |
| example@example.com | password | Bookデータなし |

## Bookモデル

| 項目名称 | ID          | 型     | 備考      |
|----------|-------------|--------|-----------|
| ユーザーID   | user_id     | bigint | Userと紐づく |
| タイトル     | title       | string | not null  |
| 著者     | author      | string | not null  |
| 説明     | description | text   | not null  |


## 実装API一覧

| 機能         | パス               | メソッド   |
|--------------|------------------|--------|
| ログイン         | /v1/auth/sign_in | POST   |
| Book一覧取得 | /v1/books        | GET    |
| Book詳細取得 | /v1/books/[:id]  | GET    |
| Book情報作成 | /v1/books/       | POST   |
| Book情報更新 | /v1/books/[:id]  | PUT    |
| Book情報削除 | /v1/books/[:id]  | DELETE |

**「HerokuURL + パス」 が各APIのエンドポイントとなります**
（Book一覧取得の場合、`https://rails-api-book.herokuapp.com/v1/books`がエントリーポイント）


## APIの利用方法の例(curlの場合)

### ログイン＆access-tokenの取得

以下のcurlコマンドを実行し、OKの場合、実行結果にヘッダーにaccess-tokenなどの認証情報が付与されます。

```
# コマンド
curl -i https://rails-api-book.herokuapp.com//v1/auth/sign_in -d '{"email": "test@example.com", "password": "password"}' -H 'content-type:application/json'

# response
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Content-Type: application/json; charset=utf-8
access-token: 3avgwPzJIEmU4K-IZvAPOQ      # Bookリソースへのアクセス時に必要
token-type: Bearer
client: MWsxjXKb5Yh2miGl8Ju12A   # Bookリソースへのアクセス時に必要
expiry: 1623681414   # Bookリソースへのアクセス時に必要
uid: test@example.com     # Bookリソースへのアクセス時に必要
ETag: W/"2e8fece501512b3f2574ff97177edda7"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: d7170550-bc0e-4111-ba7a-d360892e8d99
X-Runtime: 0.334544
Vary: Origin
Transfer-Encoding: chunked
```

### access-tokenを利用した認証付きのアクセス
次回以降のBookリソースに対するアクセスは、ログイン時にレスポンスで返ってきた`access-token`,`token-type`, `client`, `expiry`, `uid`をヘッダーに付与してAPIコールを行います。
以下はBook一覧を取得する場合の例です。

```
# コマンド
curl https://rails-api-book.herokuapp.com/v1/books -H 'access-token:3avgwPzJIEmU4K-IZvAPOQ' -H "token-type:Bearer" -H "client:MWsxjXKb5Yh2miGl8Ju12A" -H "expiry:1623681414" -H "uid:test@example.com" -i

# response
[{"id":7,"title":"スラムダンク","author":"井上タケヒコ","description":"『SLAM DUNK』（スラムダンク）は、バスケットボール 主人公の不良少年桜木花道.本作品の舞台は神奈川県.第40回平成6年度（1994年）小学館漫画賞.ジャンプ歴代最高部数653万部を達成した"},{"id":8,"title":"ヒストリエ","author":"岩明均","description":"紀元前4世紀の古代ギリシア世界を舞台に、マケドニア王国のアレクサンドロス大王（アレキサンダー大王）に仕えた書記官・エウメネスの波乱の生涯を描いている。エウメネスはプルタルコスの『英雄伝』（対比列伝）などにも登場する実在の人物である。"},{"id":9,"title":"キングダム","author":"原泰久","description":"古代中国の春秋戦国時代末期における、戦国七雄の戦争を背景とした作品。中国史上初めて天下統一を果たした始皇帝と、それを支えた将軍李信が主人公。"}]
```
