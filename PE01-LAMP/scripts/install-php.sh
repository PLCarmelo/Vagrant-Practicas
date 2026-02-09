#!/bin/bash
set -e
echo "=== Actualizando repositorios e instalando PHP ==="

apt-get update 

apt-get install -y php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml

# Reiniciar Apache para cargar PHP
systemctl restart apache2