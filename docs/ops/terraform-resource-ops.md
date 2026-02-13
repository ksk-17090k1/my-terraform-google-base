# Terraform のリソース管理操作
## 1. リソースキーのリネーム
以下の流れで対応する．進め方の詳細は，[参考情報の項目4.1](#41-リソースキーのリネーム) を確認すること．

### 1.1. moved block の設定適用
| No | 作業 | 内容 |
|---|---|---|
| 1 | `moved.tf` の作成 | `moved.tf` を作り，`moved block` を実装する |
| 2 | リソースキーの修正 | 該当の `TF` ファイルで，リソースキーを修正する |
| 3 | 差分の確認・反映 | `CI` で差分を確認し，修正後に `CD` で適用する |

### 1.2. moved block の設定破棄
| No | 作業 | 内容 |
|---|---|---|
| 1 | `moved.tf` の削除 | `moved.tf` を削除する |
| 2 | 差分の確認・反映 | `CI` で差分を確認し，修正後に `CD` で適用する |


## 2. リソース設定のインポート
以下の流れで対応する．進め方の詳細は，[参考情報の項目4.2](#42-リソース設定のインポート) を確認すること．

### 2.1. import block の設定適用
| No | 作業 | 内容 |
|---|---|---|
| 1 | `import.tf` の作成 | `import.tf` を作り，`import block` を実装する<br>※ 設定は，[公式資料のリソース別情報](https://registry.terraform.io/providers/hashicorp/google/latest/docs) を確認すること |
| 2 | リソース設定の実装 | 対象リソースの設定を実装する<br>※ [参考情報の項目4.2](#42-リソース設定のインポート) の No.2 の方法で対応しても良い |
| 3 | 差分の確認・反映 | `CI` で差分を確認し，修正後に `CD` で適用する |

### 2.2. import block の設定破棄
| No | 作業 | 内容 |
|---|---|---|
| 1 | `import.tf` の削除 | `import.tf` を削除する |
| 2 | 差分の確認・反映 | `CI` で差分を確認し，修正後に `CD` で適用する |


## 3. リソース設定の除外
以下の流れで対応する．進め方の詳細は，[参考情報の項目4.3](#43-リソース設定の除外) を確認すること．

### 注意
state のみを削除する場合は，removed block の `lifecycle` で `destroy` を `false` にする．<br>
`destroy` を `true` にすると，state だけでなくリソースも共に削除されてしまうためである．

```terraform
removed {
  from = module.example

  lifecycle {
    destroy = false
  }
}
```

### 3.1. removed block の設定適用
| No | 作業 | 内容 |
|---|---|---|
| 1 | `removed.tf` の作成 | `removed.tf` を作り，`removed block` を実装する |
| 2 | リソースキーの修正 | 該当の `TF` ファイルで，リソースキーを修正する |
| 3 | 差分の確認・反映 | `CI` で差分を確認し，修正後に `CD` で適用する |


### 3.2. removed block の設定破棄
| No | 作業 | 内容 |
|---|---|---|
| 1 | `removed.tf` の削除 | `removed.tf` を削除する |
| 2 | 差分の確認・反映 | `CI` で差分を確認し，修正後に `CD` で適用する |


## 4. 参考情報
以下は，参考情報の一覧である．

### 4.1. リソースキーのリネーム
| No | 概要 | リンク |
|---|---|---|
| 1 | `Refactoring` | <https://developer.hashicorp.com/terraform/language/modules/develop/refactoring> |
| 2 | `Use configuration to move resources` | <https://developer.hashicorp.com/terraform/tutorials/configuration-language/move-config> |

### 4.2. リソース設定のインポート
| No | 概要 | リンク |
|---|---|---|
| 1 | `Import` | <https://developer.hashicorp.com/terraform/language/import> |
| 2 | `Generating configuration` | <https://developer.hashicorp.com/terraform/language/import/generating-configuration> |
| 3 | `Import Terraform configuration` | <https://developer.hashicorp.com/terraform/tutorials/state/state-import> |

### 4.3. リソース設定の除外
| No | 概要 | リンク |
|---|---|---|
| 1 | `Removing Resources` | <https://developer.hashicorp.com/terraform/language/resources/syntax#removing-resources> |
| 2 | `Removing Modules` | <https://developer.hashicorp.com/terraform/language/modules/syntax#removing-modules> |
