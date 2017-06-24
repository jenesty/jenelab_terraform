### 概要
ジェネラボで行っているAWSハンズオンで使用するterraformです。
Terraform v0.9.4で作成しています。
事前にTerraform v0.9.4をインストールしてください。

### 事前準備
* 事前にAWSのアクセスキー、シークレットキーを設定してください。
* クレデンシャル(~/.aws/credentials)を設定してください。
```
設定例)
[default]
aws_access_key_id = ***
aws_secret_access_key = ***
region = ap-northeast-1
```
* 事前に起動させたいAMIを作成し、variables.tfに設定してください。
```
#
# ec2
#
variable "web_settings" {
  type = "map"
  default = {
    ec2_count = "2"
    ec2_type = "t2.micro"
    ami_id = "ここに設定する"
  }
}
```

### Terraformインストール(Mac)
```
$ brew install tfenv
$ tfenv install 0.9.4
$ tfenv use 0.9.4
```

### 使用方法
```
$ cd /path/to/the/terraform_dir

terraformのテスト実行
$ terraform plan

terraformの適用
$ terraform apply

terraformで作成したリソースの削除
$ terraform destroy
```

### 注意
terraform destroyを実行するとAWS上のリソースが削除されます。
確認の上、実行してください。