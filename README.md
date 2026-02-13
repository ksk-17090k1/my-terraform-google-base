# terraform-template-google
## 1. 概要
これは，Terraform Google Provider 用の社内向け GitHub Repository Template の管理場所のリポジトリである．<br>
このテンプレートで，サービスインフラ用の Terraform 向け GitHub Repository や CI/CD を作成・構築出来る．


## 2. 想定される利用
### 2.1. 推奨パターン
主に，システムのインフラ新規構築における，次の様な場面でのテンプレートを用いた初期設定を推奨する．<br>

- 新規システムのインフラ環境の構築
- 既存システムでの新環境の構築
- 既存システムの構成のリプレイス

テンプレートに基づく一気通貫の作業のため，上記の様な全体的に新規でインフラ構築を行う様なパターン<br>
において，GitHub・Terraform に関する初期設定や IaC 化を進める方がテンプレート利用として最適である．

### 2.2. 注意事項
このテンプレートについて特に明記すべきことは無いが，既存システムにおいて IaC 化が進んでいない場合は<br>
インポートを要するし，リポジトリ構成を整備する場合はファイル群の移動・リネーム等の作業が必要になる．


## 3. ディレクトリ構成
以下は，テンプレートリポジトリ内のディレクトリ構成のツリー図である．

```
terraform-template-google
├── .github
│   ├── pull_request_template.md                 # GitHub PR のテンプレート
│   └── workflows
│       ├── ci.yml.tmpl                          # CI の設定ファイル
│       ├── ci-manual-prd.yml.tmpl               # 手動実行用の本番環境向け CI の設定ファイル
│       ├── cd-prd.yml.tmpl                      # 本番環境向け CD の設定ファイル
│       ├── cd-stg.yml.tmpl                      # 検証環境向け CD の設定ファイル
│       ├── cd-dev.yml.tmpl                      # 開発環境向け CD の設定ファイル
│       └── diff-check.yml.tmpl                  # 状態差分の定期チェックの設定ファイル
├── .tfcmt
│   └── github.yml                               # tfcmt の設定ファイル
├── .tfnotify
│   └── slack.yml                                # tfnotify の設定ファイル
├── .gitignore
├── README.md                                    # テンプレートリポジトリの README
├── README.md.tmpl                               # 利用側リポジトリの README テンプレート
├── template.ini                                 # テンプレート情報の書き換え用の設定
├── docs
│   ├── ops
│   │   ├── terraform-resource-ops.md            # Terraform の import・move・remove 等の対応
│   │   └── terraform-upgrade-ops.md             # Terraform 関連のバージョンアップグレードの対応
│   ├── setups
│   │   ├── slack-channel-setups.md              # Slack Channel の初期設定
│   │   ├── git-repository-setups.md             # 利用側の Git リポジトリの初期設定
│   │   ├── local-tool-setups.md                 # ローカルで利用するツールの設定
│   │   └── terraform-setups.md                  # Terraform に関する初期設定
│   └── diagram
│       ├── google-architecture                  # サービス向け Google Cloud インフラの構成図
│       │   └── google-architecture.drawio
│       └── github-actions                       # GitHub Actions のワークフロー図
│           ├── github-actions.drawio
│           ├── github-actions-ci-manual.jpg
│           ├── github-actions-ci.jpg
│           ├── github-actions-cd.jpg
│           └── github-actions-diff-check.jpg
├── bin
│   ├── template-init.sh                         # テンプレート情報の置換に関するスクリプト
│   ├── template-update.sh                       # テンプレート情報のバージョン更新に関するスクリプト (メンテナー向け)
│   ├── readme-prepare.sh                        # 利用側リポジトリの README 生成用のスクリプト
│   ├── gcloud-api-enable.sh                     # Google Cloud のサービス API 有効化のスクリプト
│   ├── tfbackend-prepare.sh                     # Terraform Backend の構築用スクリプト
│   ├── terraform-upgrade.sh                     # Terraform のバージョン置換用のスクリプト
│   ├── tfprovider-upgrade.sh                    # Terraform Provider のバージョン置換用のスクリプト
│   └── git-merge.sh                             # Git のマージに関するスクリプト (自動実行の CI で用いられる)
├── func                                         # Cloud Functions の関数コード
├── tmpl                                         # Google Cloud のリソース設定に関するテンプレート
└── src                                          # サービスインフラ用の Terraform ソースコード
```


## 4. 利用準備
次の手順に沿って，Terraform 向け GitHub Repository の作成・整備と，Slack の通知先の設定作業を行う．

- [4.1. リポジトリの作成](#41-リポジトリの作成)
- [4.2. GitHub・Slack の初期設定](#42-githubslack-の初期設定)
- [4.3. README の生成処理の実行](#43-readmemd-の更新)

これらの対応後は，Terraform 向け GitHub Repository の README に記載される次の `初期設定` を対応する．

- [ローカルで利用するツールの設定](./docs/setups/local-tool-setups.md) 
- [Terraform に関する初期設定](./docs/setups/terraform-setups.md)

### 4.1. リポジトリの作成
[リポジトリ](https://github.com/lv-technology-strategy/terraform-template-google) の `Use this template` から `Create a new repository` を選択し，リポジトリの作成画面に移る．<br>
下表に沿って設定し，確認の上で `Create repository` を押す．詳細は，GitHub の [公式資料](https://docs.github.com/ja/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) を確認頂きたい．

| 設定項目 | 内容 |
|---|---|
| Include all branches | チェックを `入れず`，そのままにする |
| Owner | 作成先の `Organization` を選択する |
| Repository name | 作成対象のリポジトリの `名前` を記入する |
| Description | リポジトリを表す `端的な説明` を記載する |
| Visibility | 基本的に，`Internal` を選択する |

### 4.2. GitHub・Slack の初期設定
下表の No.1 から順に，資料に沿って GitHub・Slack に関する初期設定を対応する．

| No | 項目 | リンク |
|---|---|---|
| 1 | `GitHub Repository に関する初期設定` | [docs/setups/git-repository-setups.md](./docs/setups/git-repository-setups.md) |
| 2 | `Slack Channel 関連の初期設定` | [docs/setups/slack-channel-setups.md](./docs/setups/slack-channel-setups.md) |

### 4.3. README.md の更新
次のコマンドを実行して，Terraform 向け GitHub Repository の `README.md` を生成する．

```sh
$ bash ./bin/readme-prepare.sh
```

その後，リポジトリの初期設定に関する雛形ファイルやスクリプトファイルを削除する．

- `README_org.md`
- `template.ini`
- `bin/template-init.sh`
- `bin/template-update.sh`
- `bin/readme-prepare.sh`


## 5. メンテナンス対応
以下は，現在のこのリポジトリにおけるメンテナンス対応の説明である．

### 5.1. 開発フロー
開発フローは主に次の通りである．テンプレートについてはテク戦 SRE が全て対応する．<br>
また，Git ブランチ戦略は [GitHub Flow](https://zenn.dev/fumi_mizu/articles/dd3fb628a182f5) を採用しており，リリースはタグで管理している．

| No | 作業 | 担当 |
|---|---|---|
| 1 | 開発・改善の要望出し | テク戦 SRE |
| 2 | テンプレートの修正対応 | テク戦 SRE |
| 4 | PR レビューの依頼 | テク戦 SRE |
| 5 | PR の承認・マージ | テク戦 SRE |
| 6 | リリース発行の実施 | テク戦 SRE |

### 5.2. セットアップ
#### 5.2.1. bash
Mac OS の場合，bash のバージョンが古いため，以下を実行する．

```sh
$ brew install bash
```

その後，ターミナルを起動し直して下記を実行し，バージョンを確認する．

```sh
$ bash --version
```

#### 5.2.2. GitHub CLI
以下を実行し，GitHub CLI をインストールする．

```sh 
$ brew install gh
```

### 5.3. バージョン更新
#### 5.3.1. GitHub の認証設定
以下のコマンドの実行とブラウザでの操作を通して，GitHub の認証設定を行う．

```sh
$ gh auth login -p https -h github.com -w
```

#### 5.3.2. スクリプトの実行
下記のコマンドを実行して，`template.ini` 内のバージョン記載を更新する．

```sh
$ bash ./bin/template-update.sh
```

### 5.4. リリース対応
バージョン記載，コードや資料の修正等の反映後，以下の手順に沿ってリリースを対応する．

#### 5.4.1. 実装例の更新
VS Code で，このローカルリポジトリのフォルダに対し，`フォルダ内を検索する` を利用する．<br>
その際に，下表の条件で一斉に置換する．`${git_tag}` には作成予定の Git タグを指定する．

その後，コミット・プッシュを行い PR を作成する．PR のマージ後にリリース作成へ移る．

| 項目 | 値 |
|---|---|
| 検索条件の文字列 | `ref=.*` |
| 置換後の文字列 | `ref=${git_tag}"` |
| 除外するファイル | `.git` |

#### 5.4.2. リリースの作成
[Releases](https://github.com/lv-technology-strategy/terraform-template-google/releases) ページの `Draft a new release` を押す．その後，下表に沿って項目を設定する．<br>
作成画面では，下表を参考に選択・記入を行い，`Save draft` を押して下書き保存をする．<br>

タグ名は，セマンティックバージョニングに沿ってコード修正の内容に合わせて指定する．<br>
特に何も無ければ，`Generate release notes` を押して下表の 3・4 の記載を埋めて良い．

選択・記載の内容に問題が特に無ければ，`Publish release` を押してリリースを発行する．

| No | 項目 | 内容 |
|---|---|---|
| 1 | `Choose a tag` | `vx.x.x` の様な形式の文字列を記載する<br>(例：`v1.0.1`，`v1.1.10`，`v1.2.5`) |
| 2 | `Target` | `main` が選択されていることを確認する<br>(`main` がデフォルトブランチのため，特に何もしない) |
| 3 | `Release title` | `Choose a tag` の値と同じ文字列を記載する |
| 4 | `Describe this release` | リリースの変更点を簡単に記入する |
