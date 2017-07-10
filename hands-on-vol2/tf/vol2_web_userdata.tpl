#!/bin/bash
cd /tmp
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

# パッケージインストール
sudo yum install -y httpd php php-devel php-mysql php-mbstring php-gd mysql

# apacheの設定変更
sudo sed -i -e 's/ServerTokens OS/ServerTokens Prod/' /etc/httpd/conf/httpd.conf
sudo sed -i -e 's/ServerSignature On/ServerSignature Off/' /etc/httpd/conf/httpd.conf
sudo sed -i -e 's/Options FollowSymLinks/Options -Indexes FollowSymLinks/' /etc/httpd/conf/httpd.conf

# phpの設定変更
sudo sed -i -e 's/;mbstring.language/mbstring.language/' /etc/php.ini
sudo sed -i -e 's/;mbstring.internal_encoding = EUC-JP/mbstring.internal_encoding = UTF-8/' /etc/php.ini
sudo sed -i -e 's/;mbstring.http_input/mbstring.http_input/' /etc/php.ini
sudo sed -i -e 's/;mbstring.detect_order/mbstring.detect_order/' /etc/php.ini
sudo sed -i -e 's/;date.timezone =/date.timezone = Asia\/Tokyo/' /etc/php.ini

# Apahceの設定チェック
sudo service httpd configtest

# Apacheの自動起動設定
sudo chkconfig httpd on

# wordpressをダウンロードして、展開
cd /var/www/html
sudo wget http://ja.wordpress.org/latest-ja.tar.gz
sudo tar zxvf latest-ja.tar.gz


# ディレクトリ名をwpに変更し、ディレクトリのオーナーをapacheに変更
sudo mv wordpress wp
sudo chown -R apache:apache wp
cd wp
sudo cp -p wp-config-sample.php wp-config.php

# wordpressの設定変更
sudo sed -i -e 's/database_name_here/wordpress/' wp-config.php
sudo sed -i -e 's/username_here/wordpress/' wp-config.php
sudo sed -i -e 's/password_here/${wp_password}/' wp-config.php
sudo sed -i -e 's/localhost/${rds_endpoint}/' wp-config.php

# Apacheの再起動
sudo service httpd restart