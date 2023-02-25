#!/bin/bash

yum update -y upgrade -y
yum install -y httpd php php-mysqlnd mysql git&&
systemctl enable --now httpd
git clone https://github.com/HristoDimitrovv/web-app &&
cp -v swo-bgapp/web/* /var/www/html/