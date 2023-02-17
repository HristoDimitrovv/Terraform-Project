#!/bin/bash

yum update -y upgrade -y
yum install -y httpd php php-mysqlnd git mysql &&
systemctl enable --now httpd
git clone https://github.com/HristoDimitrovv/swo-bgapp.git &&
cp -v swo-bgapp/web/* /var/www/html/ &&