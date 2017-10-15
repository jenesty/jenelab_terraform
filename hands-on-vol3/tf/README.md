## 概要
「AWSハンズオンセミナー S3・Route53・ACM・CloudWatch 編」の環境をセットアップするためのterraformです。

## 事前準備
### マネジメントコンソールでの作業
現状、terrafromではできない設定はマネジメントコンソール上から行う必要があります。
terraformをapplyする前に
* 使用するドメインのDomainの発行
* 発行したDomainのACMの発行
をマネジメントコンソール上から実施してください。

詳細は「AWSハンズオンセミナー S3・Route53・ACM・CloudWatch 編」の
* 第1章：Route 53のドメイン取得
* 第5章：SSL証明書の取得
を参照してください。

### 変数の変更
```common_vars/vars.tf```にある以下の項目を変更します。

* s3_bucket
wordpressの画像を保存する用のBacketを設定します。世界中でユニークである必要があります。

* route53_zone
取得したドメインを設定します。

* route53_zoneid
取得したドメインのzoneidを設定します。
確認方法は、マネジメントコンソールから「Route53」→「Hosted Zones」に移動し、
取得したドメインにチェック→「Hosted Zone ID」で確認できます。

* route53_record
取得したドメインにAレコードを設定しています。
実際にアクセスしたいURLを設定します。

## 事後作業
terraformのapply完了後、URLにアクセスするとwordpressの初期インストール画面が表示されます。
適宜設定を行って、wordpressの管理画面にログインしてください。
また、wordpressのプラグインである「Nephila clavata (絡新婦)」を設定する場合は、
「AWSハンズオンセミナー S3・Route53・ACM・CloudWatch 編」の
「第3章：wordpressのプラグイン設定」を参照してください。