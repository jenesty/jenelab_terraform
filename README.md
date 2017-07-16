## 概要
ジェネラボで行っているAWSハンズオンで使用するterraformです。
Terraform v0.9.4で作成しています。
事前にTerraform v0.9.4をインストールしてください。

## 事前準備
### クレデンシャル
事前にAWSのアクセスキー、シークレットキーを設定してください。
クレデンシャル(~/.aws/credentials)を設定してください。

```
設定例)
[default]
aws_access_key_id = ***
aws_secret_access_key = ***
region = ap-northeast-1
```

### varsの設定
変数の設定は、hands-on-vol*/tf/配下にあるvariables.tfを変更します。
以下の設定を実施しないとterraformが失敗します。"必ず"設定してください。

```
# 起動したいAmazon Linuxで作成したAMIを指定
variable "web_settings" {
  type = "map"
  default = {
    ec2_count = "2" #起動するインスタンス数
    ec2_type = "t2.micro" #起動するインスタンスタイプ 
    ami_id = "ここに設定する" #起動するAMI
  }
}

# 事前にキーペア事前を作成し、指定
variable "key_pair" {
  default = "作成したキーペア名"
}
```
## Terraformインストール(Mac)
バージョンが0.9.4でない場合、正常に動作しない可能性があります。
```
$ brew install tfenv
$ tfenv install 0.9.4
$ tfenv use 0.9.4
```

## 使用方法
```opt```ディレクトリにあるwrapperツールを使用して、```terraform```を実行します。

```
例)AWSハンズオンセミナー EC2・VPC・ELB編の環境をセットアップする
$ cd /path/to/the/terraform_dir

terraformのテスト実行
$ ./opt/plan hands-on-vol1

terraformの適用
$ ./opt/apply hands-on-vol1

terraformで作成したリソースの削除
$ ./opt/destroy hands-on-vol1
```

## 注意
```./opt/destroy```を実行するとAWS上のリソースが削除されます。
確認の上、実行してください。