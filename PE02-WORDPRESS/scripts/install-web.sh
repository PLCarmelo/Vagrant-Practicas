#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
echo "=== Instalando Apache ==="
apt-get install -y apache2 mysql-client
echo "=== Instalando PHP y extensiones ==="
apt-get install -y php libapache2-mod-php php-mysql php-curl php-gd \
php-mbstring php-xml php-xmlrpc php-zip php-intl php-opcache
echo "=== Habilitando módulos Apache ==="
a2enmod rewrite
echo "=== Descargando WordPress ==="
cd /tmp
wget -q https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
echo "=== Instalando WordPress ==="
rm -rf /var/www/html/*
cp -r wordpress/* /var/www/html/
echo "=== Configurando permisos ==="
chown -R www-data:www-data /var/www/html
find /var/www/html/ -type d -exec chmod 755 {} \;
find /var/www/html/ -type f -exec chmod 644 {} \;
echo "=== Configurando Apache VirtualHost desde un fichero externo ==="
cp /vagrant/config/wordpress.conf /etc/apache2/sites-available/wordpress.conf
a2dissite 000-default.conf
a2ensite wordpress.conf
systemctl restart apache2
echo "=== Apache y PHP instalados ==="