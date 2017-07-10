#!/bin/bash
cd /tmp
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

# パッケージインストール
sudo yum install -y httpd

# Apacheの自動起動設定
sudo chkconfig httpd on

# Apacheの再起動
sudo service httpd restart