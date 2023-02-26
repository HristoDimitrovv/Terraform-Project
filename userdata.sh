#!/bin/bash

yum update -y upgrade -y
yum install -y httpd php php-mysqlnd mysql git&&
systemctl enable --now httpd
git clone https://github.com/HristoDimitrovv/web-app &&
sed -i "s/\$database = .*/\$database = \"${DATABASE}\";/" web-app/web/config.php
sed -i "s/\$user = .*/\$user = \"${DB_USERNAME}\";/" web-app/web/config.php
sed -i "s/\$password = .*/\$password = \"${DB_PASSWORD}\";/" web-app/web/config.php
sed -i "s/\$host = .*/\$host = \"${DB_HOSTNAME}\";/" web-app/web/config.php
cp -v web-app/web/* /var/www/html/