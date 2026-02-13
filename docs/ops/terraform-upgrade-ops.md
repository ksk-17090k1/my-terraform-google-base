# Terraform 関連のアップグレード
## 1. ローカルツールの対応
tfenv を用いて，Terraform のバージョンを切り替える．<br>
ここで，`${version}` は設定予定の Terraform のバージョンである．

```sh
$ tfenv install ${version}
$ tfenv use ${version}
```


## 2. バージョン設定の書き換え
以下のいずれか，または両方に沿って対応する．

### 2.1. Terraform
以下のコマンドを実行して，バージョン設定を置換する．<br>
ここで，`${version}` は設定予定の Terraform のバージョンである．

```sh
$ bash ./bin/terraform-upgrade.sh ${version}
```

### 2.2. Terraform Provider
以下のコマンドを実行して，バージョン設定を置換する．<br>
ここで，`${version}` は設定予定の Terraform Provider のバージョンである．

```sh
$ bash ./bin/tfprovider-upgrade.sh ${version}
```


## 3. .terraform.lock.hcl の更新
### 3.1. 認証設定
[ローカル環境の認証設定](./../../README.md#42-認証設定) に沿って対応する．

### 3.2. ファイル更新
リポジトリのルートディレクトリで次を実行する．<br>
ここで，`${env}` は `dev`・`stg`・`prd` のどれかである．

```sh
$ cd ./src/${env}/
$ terraform init -upgrade
$ rm -rf .terraform
```


## 4. tfstate ファイルの更新
[ローカル](./../../README.md#4-ローカル環境)・CI/CD でインフラ状態差分の確認・適用を行い，tfstate ファイルを更新する．


## 5. 参考情報
以下は，参考情報の一覧である．

| No | 概要 | リンク |
|---|---|---|
| 1 | `Terraform Changelog` | <https://github.com/hashicorp/terraform/blob/main/CHANGELOG.md> |
| 2 | `Terraform Google Provider Changelog` | <https://github.com/hashicorp/terraform-provider-google/blob/main/CHANGELOG.md> |
