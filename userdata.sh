#!/bin/bash

yum update -y upgrade -y
yum install -y httpd php php-mysqlnd git &&
systemctl enable --now httpd
git clone https://github.com/shekeriev/bgapp &&
cp -v bgapp/web/* /var/www/html/
