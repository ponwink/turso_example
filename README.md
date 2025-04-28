# Turso ✕ Flutter 

TursoとFlutterを用いたサンプルです。

## 使い方

### 1. TursoのDBにテーブルを作成

TursoのDB作成までは割愛します。  
下記のテーブルを作成しましょう。

> テーブル名: memos  
> カラム
> - id INTEGER PRIMARY KEY AUTOINCREMENT
> - memo TEXT
> - created TEXT

テーブルを作成したDBに接続する、URLとTOKENを発行しましょう。  
手順はQuickStart参照してください。

https://docs.turso.tech/sdk/flutter/quickstart


### 2. プロジェクト準備

このプロジェクトをクローンしましょう。

```shell
$ git clone [プロジェクトのURL]
```

プロジェクトルートに `.env` ファイルを設置しましょう。中身は下記の通りです。  
値は、Tursoから取得したURLとTOKENを設定します。

```:.env
TURSO_URL=
TURSO_AUTH_TOKEN=
```
