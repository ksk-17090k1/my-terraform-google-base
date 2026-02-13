# ローカルで利用するツールの設定
## 1. gcloud のインストール
次のコマンドを実行して，`gcloud` をインストールする．

```sh
$ brew install --cask google-cloud-sdk
```


## 2. tfenv・terraform のインストール
まず，次のコマンドを実行して，`tfenv` をインストールする．

```sh
$ brew install tfenv
```

その後，次のコマンドを実行して，`tfenv` で `terraform` をインストールする．<br>
バージョン切り替えの際も，`install`・`use` のコマンドで対応出来る．

```sh
$ tfenv install ${terraform_version}
$ tfenv use ${terraform_version}
```


## 3. rename のインストール
次のコマンドを実行して，`rename` をインストールする．

```sh
$ brew install rename
```


## 4. 参考情報
以下は，参考情報の一覧である．

| No | 概要 | リンク |
|---|---|---|
| 1 | `gcloud` | <https://cloud.google.com/sdk/docs/install?hl=ja> |
| 2 | `tfenv` | <https://github.com/tfutils/tfenv> |
| 3 | `rename` | <http://plasmasturm.org/code/rename/> |
| 4 | `Homebrew Formulae (gcloud)` | <https://formulae.brew.sh/cask/google-cloud-sdk> |
| 5 | `Homebrew Formulae (tfenv)` | <https://formulae.brew.sh/formula/tfenv> |
| 6 | `Homebrew Formulae (rename)` | <https://formulae.brew.sh/formula/rename> |
