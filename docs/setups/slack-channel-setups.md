# Slack Channel 関連の初期設定
Slack の Channel・Webhook に関する設定を行う．設定済みの場合は，作業をスキップする．


## 1. Slack Channel の作成
[#ra-slack](https://app.slack.com/client/T7KQHUNQ3/CCSFYLT8B) で，チャンネル概要に記載の手順に沿って下表のチャンネル作成を依頼する．<br>
開発環境を構築しない場合は，開発環境向けのアラート通知先のチャンネルは作成しない．

※ 依頼例：<https://lvgs.slack.com/archives/CCSFYLT8B/p1696405326538289>

| 概要 | 命名規則例 | 備考 |
|---|---|---|
| アプリ・インフラの本番向けデプロイの通知先 | `xl-deploy-prd-example-svc` |  |
| アプリ・インフラの検証向けデプロイの通知先 | `xl-deploy-stg-example-svc` |  |
| アプリ・インフラの開発向けデプロイの通知先 | `xl-deploy-dev-example-svc` |  |


## 2. Webhook URL の発行
[#ra-req-slack](https://app.slack.com/client/T7KQHUNQ3/C02KDA7L59N) チャンネルで，ワークフローの `incoming-webhook 作成依頼` で URL 発行を依頼する．<br>
ここで，Webhook の連携先チャンネルは，`環境毎のアプリ・インフラのデプロイ通知先` のチャンネルである．

チャンネルで Webhook 連携が設定済みか，またはそもそも設定不要な場合はこの手順をスキップする．


## 3. Slack App の作成
### 3.1. 手順
次の手順・対象を確認の上で，Slack App の作成を行う．

App の管理コストを抑えるため，各 App は開発部等の一定粒度の単位で管理・共用すること．<br>
そのため，この方針に沿って既存の App をそのまま利用する場合はこの手順をスキップする．

#### (1) App の作成手順
1. [アプリを作成する](https://zenn.dev/kou_pg_0131/articles/slack-api-post-message#%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B)
    - `From scratch` の作成タイプを選択する
    - App Name で，`template.ini` で指定した名前を入力する
    - Slack Workspace で，`Leverages BizDevOps` を選択する
2. [スコープを設定する](https://zenn.dev/kou_pg_0131/articles/slack-api-post-message#%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97%E3%82%92%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B)
    - Bot Token Scopes で，`chat:write`・`chat:write.public` を追加する
    - User Token Scope の設定はスキップする
3. [アプリをワークスペースにインストールする](https://zenn.dev/kou_pg_0131/articles/slack-api-post-message#%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%B9%E3%83%9A%E3%83%BC%E3%82%B9%E3%81%AB%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B)
    - `Install to Workspace` を押すと，Slack の `# ra-slack` へ通知される
    - 上記のスレッドで情シスとやり取りし，インストールを承認してもらう

#### (2) 作成対象の App
| 名前 | 用途 |
|---|---|
| `example-svc-tfnotify` | Terraform CD の実行通知用の Slack App |

### 3.2. 注意
#### 3.2.1. トークンの控え
以下の手順で利用するため，作成手順の3において Bot User OAuth Token を控えておく．

- [Terraform に関する初期設定](./terraform-setups.md)

#### 3.2.2. 申請の追加根拠
情シスへの Slack App の申請依頼で，権限を理由に申請が通らない場合は次を共有する．

- 1つの App で環境チャンネルへの通知を想定しており，`chat:write.public` が必要である
- `chat:write.public` の仕様で `chat:write.public` に併せて `chat:write` も必要である
    - https://api.slack.com/scopes/chat:write.public
    - https://auto-worker.com/blog/?p=825
