# Git Repository に関する初期設定
## 1. 不要な設定の雛形の削除
開発環境を構築しない場合は，下表の開発環境向けのファイル・フォルダ・設定を削除する．<br>
また，状態差分の定期チェックが不要な場合は，下表の `diff-check.yml.tmpl` も削除する．

| 種別 | 対象 |
|---|---|
| フォルダ | `src/dev` |
| ファイル | `.github/workflows/diff-check.yml.tmpl`<br>`.github/workflows/cd-dev.yml.tmpl` |
| 設定 | `.github/workflows/ci.yml.tmpl` |


## 2. テンプレート情報の書き換え
初めに [template.ini の設定](#21-templateini-の設定) の作業を，次に [スクリプトの実行](#22-スクリプトの実行) の作業を行う．

### 2.1. template.ini の設定
以下を参考に，`template.ini` の内容を修正する．<br>
開発環境向けインフラを構築しない場合は，`dev` を含む設定を削除する．

#### (1) 注意
| No | 項目 | 内容 |
|---|---|---|
| 1 | バージョン設定の方針 | バージョン設定では，新しいバージョン値がデフォルトで用意されている<br>最新の機能が使いたい等であれば，バージョンの設定値を変更しても良い |
| 2 | Terraform Backend の命名方針 | 命名規則例は，説明表の備考を確認すること |
| 3 | Slack App の管理・利用の方針 | 開発部等の一定粒度の単位で管理・共用する |
| 4 | CI/CD 用の GitHub App の管理・利用の方針 | GitHub Enterprise App として開発組織の全体で共用する<br>利用の際，テク戦 SRE チームに情報を問い合わせること |

#### (2) 設定内容
| 項目 | 説明 | 備考 |
|---|---|---|
| `service_kebab_name` | サービス名を表す文字列のケバブケース |  |
| `service_snake_name` | サービス名を表す文字列のスネークケース |  |
| `slack_tfnotify_bot_name` | Terraform CD の実行通知用の Slack App BOT の名前 |  |
| `terraform_version` | terraform の バージョン | 管理リポジトリ：<br>https://github.com/hashicorp/terraform |
| `terraform_google_provider_version` | Terraform Google Provider のバージョン | 管理リポジトリ：<br>https://github.com/hashicorp/terraform-provider-google |
| `prd_tfbackend_name` | `src` の本番向け Terraform Backend の名前 | 命名規則例：<br>`example-svc-prd-terraform-backend` |
| `stg_tfbackend_name` | `src` の検証向け Terraform Backend の名前 | 命名規則例：<br>`example-svc-stg-terraform-backend` |
| `dev_tfbackend_name` | `src` の開発向け Terraform Backend の名前 | 命名規則例：<br>`example-svc-dev-terraform-backend` |
| `google_cloud_prd_project_id` | 本番向け Google Cloud Project の ID |  |
| `google_cloud_stg_project_id` | 検証向け Google Cloud Project の ID |  |
| `google_cloud_dev_project_id` | 開発向け Google Cloud Project の ID |  |
| `github_organization_name` | GitHub Organization の名前 |  |
| `github_repository_name` | GitHub Repository の名前 |  |
| `github_actions_tfcmt_version` | tfcmt のバージョン | 管理リポジトリ：<br>https://github.com/suzuki-shunsuke/tfcmt |
| `github_actions_tfnotify_version` | tfnotify のバージョン | 管理リポジトリ：<br>https://github.com/suzuki-shunsuke/tfnotify |
| `github_actions_tfaction_version` | Terraform 向けの GitHub Composite Actions のバージョン | 管理リポジトリ：<br>https://github.com/lv-technology-strategy/github-actions-modules |
| `github_secret_lvgs_github_app_id` | CI/CD 向けの GitHub App の ID の GitHub Secret Key |  |
| `github_secret_lvgs_github_app_private_key` | CI/CD 向けの GitHub App の秘密鍵の GitHub Secret Key |  |
| `github_secret_slack_app_oauth_token_key` | CD 向けの Slack App OAuth Token の GitHub Secret Key |  |
| `github_secret_prd_slack_channel_id_key` | 本番向け CD で用いられる Slack Channel ID の GitHub Secret Key |  |
| `github_secret_stg_slack_channel_id_key` | 検証向け CD で用いられる Slack Channel ID の GitHub Secret Key |  |
| `github_secret_dev_slack_channel_id_key` | 開発向け CD で用いられる Slack Channel ID の GitHub Secret Key |  |
| `github_secret_prd_gcp_iam_service_account_key` | 本番向け CD に関する IAM Service Account の GitHub Secret Key |  |
| `github_secret_stg_gcp_iam_service_account_key` | 検証向け CD に関する IAM Service Account の GitHub Secret Key |  |
| `github_secret_dev_gcp_iam_service_account_key` | 開発向け CD に関する IAM Service Account の GitHub Secret Key |  |
| `github_secret_prd_gcp_iam_workload_identity_key` | 本番向け CD に関する IAM Workload Identity Provider の GitHub Secret Key |  |
| `github_secret_stg_gcp_iam_workload_identity_key` | 検証向け CD に関する IAM Workload Identity Provider の GitHub Secret Key |  |
| `github_secret_dev_gcp_iam_workload_identity_key` | 開発向け CD に関する IAM Workload Identity Provider の GitHub Secret Key |  |

### 2.2. スクリプトの実行
リポジトリのルートディレクトリで次を実行し，`<...>` の部分を置換する．

```sh
$ bash ./bin/template-init.sh
```
