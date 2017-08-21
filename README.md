## 概要
ジェネラボで行っているAWSハンズオンで使用するterraformのリポジトリです。
```git clone```して使用してください。

## 事前準備
### IAMユーザの作成
任意の名前でユーザを作成してください。設定は以下の通りです。
* アクセスの種類：「プログラムによるアクセス」
* アクセス権限：「既存のポリシーを直接アタッチ」
* ポリシー名：「AdministratorAccess」

### gitインストール
#### Mac
```
$ brew install git
$ git --version
```

#### Windows
```
https://git-for-windows.github.io/ よりインストーラをダウンロードして実行する。

下記以外は基本的にNextの押下で良い。

設定変更箇所：
 - 「Adjusting your PATH environment」で「Use Git from the Windows Command Prompt」を選択
 - 「Configuring the line ending conversions」で「Checkout as-is, commit as-is」を選択
 - 「Configuring extra options」で「Enable file system caching」と「Enable Git Credential Manager」を選択

インストール完了後コマンドプロンプトから以下のコマンドを実行し、バージョンが表示されればOK
> git --version

```

### クレデンシャル設定
IAMユーザを作成すると、アクセスキー、シークレットキーが発行されます。
発行されたアクセスキー、シークレットキーをローカルPCのクレデンシャルファイル(~/.aws/credentials)に設定してください。
```
設定例)
[default]
aws_access_key_id = アクセスキー
aws_secret_access_key = シークレットキー
region = ap-northeast-1
```

### S3バケットの作成
AWS S3にtfstate格納用のbucketを作成します。
S3 bucket名は任意ですが、S3 bacuket名は世界でただ1つだけしか名前を付けられない(重複不可である)ため、
ご自身で作成した頂く必要があります。その他S3 bucketの設定はデフォルトでOKです。
S3 bucket作成後、```common_vars/vars.tf```の```bucket```を
ご自身で作成したS3 bucket名に変更してください。
 ```
 terraform {
   backend "s3" {
     bucket = "ご自身で作成したS3 bucket名"
     region = "ap-northeast-1"
     key    = "terraform.tfstate"
     #lock_table = "terraform-state-lock"
   }
 }
 ```

### キーペアの発行
EC2インスタンス接続用の鍵であるキーペアを作成します。
キーペアはEC2インスタンスのメニューから作成できます。キーペア名は任意です。
キーペア作成後、```common_vars/vars.tf```の```key_pair```をご自身で作成したキーペア名に変更してください。
```
variable "key_pair" {
  default = "ご自身で作成したキーペア名"
}
```

## Terraformインストール
AWSハンズオンセミナーの環境構築ではTerraform v0.9.4をインストールしてください。
バージョンが0.9.4でない場合、正常に動作しない可能性があります。
※もし0.9.4以外のバージョンをインストールしてしまった場合は0.9.4に切り替えて実行して下さい

### Mac
Macへのterraformインストールではtfenvというバージョン管理ツールを推奨します。
terraformはバージョンアップが頻繁に行われるため、tfenvを使用してterraformをインストールすると
使用しているバージョンを固定したり必要に応じて新しいバージョンへ切り替えられるため非常に便利です。

```
$ brew install tfenv
$ tfenv install 0.9.4
$ tfenv use 0.9.4

$ terraform version
Terraform v0.9.4 と表示されればOK
```

### Windows
```
https://www.terraform.io/downloads.html から`terraform_x.xx.x_windows_amd64.zip`をダウンロードし展開する。
`C:\bin\`など任意のフォルダを作成し、terraform.exeを配置&PATHを通す。

$ terraform version
Terraform v0.9.4 と表示されればOK
```


## 使用方法
```
例)AWSハンズオンセミナー EC2・VPC・ELB編の環境をセットアップする場合

# terraformをgit cloneしたディレクトリに移動
$ cd /path/to/the/terraform_dir
```

### Mac
```
# terraformのテスト実行
$ ./opt/plan hands-on-vol1

# terraformの適用(このコマンドでAWS上にリソースが作成されます)
$ ./opt/apply hands-on-vol1

# terraformで作成したリソースの削除(作業完了後実行してください)
$ ./opt/destroy hands-on-vol1
```

### Windows
```
# terraformのテスト実行
> opt/plan_win hands-on-vol1

# terraformの適用(このコマンドでAWS上にリソースが作成されます)
> opt/apply_win hands-on-vol1

# terraformで作成したリソースの削除(作業完了後実行してください)
> opt/destroy_win hands-on-vol1

※destroy_winが上手く動かない場合は一旦[Ctrl]+[C]キーで終了して再実行して下さい。

```

## 注意
```./opt/destroy```を実行するとAWS上のリソースが削除されます。
表示されるメッセージを確認の上、実行してください。
※yesで実行されます
