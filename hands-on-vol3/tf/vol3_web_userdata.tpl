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
cd /tmp
sudo wget http://ja.wordpress.org/latest-ja.tar.gz
sudo tar zxvf latest-ja.tar.gz
sudo cp -rp ./wordpress/* /var/www/html/
sudo chown -R apache:apache /var/www/html/

# wordpress設定ファイルをsampleからコピー
cd /var/www/html
sudo cp -p wp-config-sample.php wp-config.php

# wordpressの設定変更
sudo sed -i -e 's/database_name_here/wordpress/' wp-config.php
sudo sed -i -e 's/username_here/wordpress/' wp-config.php
sudo sed -i -e 's/password_here/${rds_password}/' wp-config.php
sudo sed -i -e 's/localhost/${rds_endpoint}/' wp-config.php

# SSL用設定
sudo sed -i "26i\if (isset(\$_SERVER['HTTP_X_FORWARDED_PROTO']) && \$_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') \$_SERVER['HTTPS'] = 'on';" wp-config.php

# plugin
wget https://downloads.wordpress.org/plugin/nephila-clavata.0.2.5.zip && unzip nephila-clavata.0.2.5.zip
mv nephila-clavata /var/www/html/wp-content/plugins/
sudo chown -R apache:apache /var/www/html/wp-content/plugins/nephila-clavata

# Apacheの再起動
sudo service httpd restart