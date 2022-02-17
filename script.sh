#!/bin/bash

yum update -y

 amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2

 yum install -y httpd mariadb-server

 systemctl start httpd


systemctl enable httpd

usermod -a -G apache ec2-user

chown -R ec2-user:apache /var/www

chgrp -R apache /var/www

chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;

find /var/www -type f -exec sudo chmod 0664 {} \;

systemctl restart httpd

systemctl start mariadb

mysql_secure_installation

systemctl enable mariadb

yum install php-mbstring php-xml -y

systemctl restart httpd

systemctl restart php-fpm

cd /var/www/html

wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz

mkdir phpMyAdmin && tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpMyAdmin --strip-components 1

rm phpMyAdmin-latest-all-languages.tar.gz