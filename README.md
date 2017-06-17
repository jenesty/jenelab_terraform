### 概要
ジェネラボで行っているAWSハンズオンで使用するterraformです。
Terraform v0.9.4で作成しています。
事前にTerraform v0.9.4をインストールしてください。

### Terraformインストール(Mac)
```
$ brew install tfenv
$ tfenv install 0.9.4
$ tfenv use 0.9.4
```

### 使用方法
```
$ cd /path/to/the/terraform_dir

# terraformのテスト実行
$ terraform plan

# terraformの適用
$ terraform apply

# terraformで作成したリソースの削除
$ terraform destroy
```