#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
echo "=== Instalando MySQL ==="
apt-get install -y mysql-server
echo "=== Configurando MySQL para acceso remoto ==="
# Cambiar bind-address
sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql
echo "=== Creando base de datos y usuario ==="
mysql <<EOF
-- Crear base de datos
CREATE DATABASE IF NOT EXISTS wordpress_db DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
-- Crear usuario con acceso desde red privada
CREATE USER IF NOT EXISTS 'wp_user'@'192.168.56.%' IDENTIFIED BY
'wp_secure_pass';
-- Otorgar permisos
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wp_user'@'192.168.56.%';
FLUSH PRIVILEGES;
-- Verificar
SHOW DATABASES;
SELECT User, Host FROM mysql.user;
EOF
echo "=== MySQL configurado correctamente ==="
echo "Base de datos: wordpress_db"
echo "Usuario: wp_user (acceso desde 192.168.56.%)"