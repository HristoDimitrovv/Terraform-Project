#!/bin/bash

yum update -y upgrade -y
yum install -y httpd php php-mysqlnd git mysql &&
systemctl enable --now httpd
git clone https://github.com/HristoDimitrovv/swo-bgapp.git &&
echo -e "<?php" > swo-bgapp/web/config.php 
echo -e "\$database = \"${DATABASE}\";" >> swo-bgapp/web/config.php
echo -e  "\$user = \"${DB_USERNAME}\";" >> swo-bgapp/web/config.php
echo -e "\$password = \"${DB_PASSWORD}\";" >> swo-bgapp/web/config.php
echo -e "\$host = \"${DB_HOSTNAME}\";" >> swo-bgapp/web/config.php
echo -e "?>" >> swo-bgapp/web/config.php
cp -v swo-bgapp/web/* /var/www/html/ &&
mysql --skip-ssl -u $DB_USERNAME -p$DB_PASSWORD -h $DB_HOSTNAME < swo-bgapp/db/db_setup.sql