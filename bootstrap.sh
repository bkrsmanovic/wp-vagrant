#!/usr/bin/env bash

# Apache 2.4
sudo add-apt-repository ppa:ondrej/apache2 -y
sudo apt-get update
sudo apt-get install apache2 -y

sudo add-apt-repository ppa:ondrej/php5-5.6
sudo apt-get -y update
sudo apt-get -y install php5 php5-mhash php5-mcrypt php5-curl php5-cli php5-mysql php5-gd php5-intl php5-xsl

export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server-5.5

curl -L https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/bin/wp

VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/vagrant"
  ServerName localhost
  <Directory "/vagrant">
    AllowOverride All
    Require all granted
  </Directory>
</VirtualHost>
EOF
)

echo "$VHOST" > /etc/apache2/sites-enabled/000-default.conf

mysql -u root -e "CREATE DATABASE IF NOT EXISTS wp"
mysql -u root -e "GRANT ALL PRIVILEGES ON wp.* TO 'wpuser'@'localhost' IDENTIFIED BY 'wppassword'"
mysql -u root -e "FLUSH PRIVILEGES"

sudo a2enmod rewrite

sudo service apache2 restart
