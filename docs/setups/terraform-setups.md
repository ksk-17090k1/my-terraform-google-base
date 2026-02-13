# Terraform に関する初期設定
## 1. プロジェクトでの API の有効化
サービスインフラ環境のリソース管理に関わるサービス API の有効化のみを行う．<br>
既にサービス API を有効にしている場合は，この手順をスキップして次の項目に移る．

### 1.1. 認証設定
次のコマンドを実行し，Google Cloud のログイン認証とプロジェクト設定を行う．<br>
ここで，`${project_id}` はリソースのプロビジョニング先のプロジェクト ID である．

```sh
$ gcloud auth login --no-launch-browser
$ gcloud config set project ${project_id}
```

### 1.2. スクリプトの配列設定の修正
[bin/gcloud-api-enable.sh](./../../bin/gcloud-api-enable.sh) の以下の箇所で，必要であればこの設定を修正する．

<details><summary>スクリプトの配列設定</summary>

```sh
google_apis=(
  "cloudbuild.googleapis.com"
  "cloudfunctions.googleapis.com"
  "cloudkms.googleapis.com"
  "cloudscheduler.googleapis.com"
  "compute.googleapis.com"
  "dns.googleapis.com"
  "iam.googleapis.com"
  "iamcredentials.googleapis.com"
  "logging.googleapis.com"
  "monitoring.googleapis.com"
  "pubsub.googleapis.com"
  "run.googleapis.com"
  "secretmanager.googleapis.com"
  "servicenetworking.googleapis.com"
  "sqladmin.googleapis.com"
  "storage.googleapis.com"
  "storage-api.googleapis.com"
  "storage-component.googleapis.com"
  "vpcaccess.googleapis.com"
)
```

</details>

必要な API が無い場合は，次のコマンドを実行して `googleapis-available.txt` を生成する．<br>
この txt ファイルをもとに，先述の sh ファイルの `google_apis` 内の追加・削除等を対応する．

```sh
$ gcloud services list --available --format="json" | \
  jq -r ".[].name" | \
  sed -e "s/.*\/services\///g" > googleapis-available.txt
```

サービスインフラ環境用の API が過不足無くあれば，この手順をスキップし次の項目に移る．

### 1.3. サービス API の有効化
次のコマンドを実行し，Terraform・Google Cloud の設定に必要な API を有効にする．

```sh
$ bash ./bin/gcloud-api-enable.sh
```


## 2. Terraform Backend の構築
### 2.1. 認証設定
項目 [1.1](#11-認証設定) を対応する．対応済みの場合は後続作業に移る．

### 2.2. Terraform Backend の作成
リポジトリのルートディレクトリで次を実行し，Terraform Backend を構築する．

```sh
$ bash ./bin/tfbackend-prepare.sh ${env} ${rsrc_name} ${region}
```

必須なものは，サービスインフラ向けの Terraform Backend のインフラリソースである．

ここで，`${project_id}`，`${env}`，`${rsrc_name}`，`${region}` は下表の通りである．<br>
開発環境が不要の場合，開発環境向けのコマンドの実行は不要である．

| 項目 | 値 |
|---|---|
| `${project_id}` | Google Cloud のプロジェクト ID |
| `${env}` | サービス環境値 (例：`dev`，`stg`，`prd`) |
| `${rsrc_name}` | Cloud Storage Bucket のリソース名<br><br>※ 下記のファイルからリソース名を確認すること<br>- `src/${env}/backend.tf` |
| `${region}` | リソース作成先のリージョン名 (例：`asia-northeast1`) |


## 3. CI/CD の設定
以下の項目 [3.1](#31-github-secrets-の設定)，[3.2](#32-ファイル名のリネーム) は，設定済みのものについては作業をスキップする．

### 3.1. GitHub Secrets の設定
下表に関する GitHub Secrets を，共用の場合は Organizations Secrets として設定する．<br>
共用不可でリポジトリ毎で設定する必要がある場合は，Repository Secrets として設定する．

開発環境が不要の場合は，開発環境用の Secrets の設定対応は不要である．

| 項目 | 値 |
|---|---|
| `<github_secret_lvgs_github_app_id>` | テク戦管理下の `GitHub Enterprise App の ID`<br>利用の際，テク戦 SRE チームに情報を問い合わせること |
| `<github_secret_lvgs_github_app_private_key>` | テク戦管理下の `GitHub Enterprise App の秘密鍵の中身`<br>利用の際，テク戦 SRE チームに情報を問い合わせること<br><br>※ 全てをコピーして Secret へ埋め込む |
| `<github_secret_slack_app_oauth_token_key>` | [Slack Channel 関連の初期設定](./slack-channel-setups.md) で控えた，Terraform CD の実行通知用の Slack App の `Bot User OAuth Token` |
| `<github_secret_prd_gcp_iam_service_account_key>` | 本番環境用の Terraform CI/CD 向け `IAM Service Account のメールアドレス` |
| `<github_secret_prd_gcp_iam_workload_identity_key>` | 本番環境用の Terraform CI/CD 向け `IAM Workload Identity Provider` (設定形式は [技術記事](https://zenn.dev/cloud_ace/articles/fcb1f0abf8d67c#3.-github-actions-%E3%81%AE%E8%A8%AD%E5%AE%9A)を参考) |
| `<github_secret_prd_slack_channel_id_key>` | [Slack Channel 関連の初期設定](./slack-channel-setups.md) で作成した，本番向けデプロイ通知先の `Slack Channel ID` |
| `<github_secret_stg_gcp_iam_service_account_key>` | 検証環境用の Terraform CI/CD 向け `IAM Service Account のメールアドレス` |
| `<github_secret_stg_gcp_iam_workload_identity_key>` | 検証環境用の Terraform CI/CD 向け `IAM Workload Identity Provider` (設定形式は [技術記事](https://zenn.dev/cloud_ace/articles/fcb1f0abf8d67c#3.-github-actions-%E3%81%AE%E8%A8%AD%E5%AE%9A)を参考) |
| `<github_secret_stg_slack_channel_id_key>` | [Slack Channel 関連の初期設定](./slack-channel-setups.md) で作成した，検証向けデプロイ通知先の `Slack Channel ID` |
| `<github_secret_dev_gcp_iam_service_account_key>` | 開発環境用の Terraform CI/CD 向け `IAM Service Account のメールアドレス` |
| `<github_secret_dev_gcp_iam_workload_identity_key>` | 開発環境用のTerraform CI/CD向け `IAM Workload Identity Provider` (設定形式は [技術記事](https://zenn.dev/cloud_ace/articles/fcb1f0abf8d67c#3.-github-actions-%E3%81%AE%E8%A8%AD%E5%AE%9A)を参考) |
| `<github_secret_dev_slack_channel_id_key>` | [Slack Channel 関連の初期設定](./slack-channel-setups.md) で作成した，開発向けデプロイ通知先の `Slack Channel ID` |

### 3.2. ファイル名のリネーム
次を実行して，`.github/workflows` 内のファイルをリネームする．

```sh
$ rename 's/\.tmpl$//' ./.github/workflows/*.tmpl
```
