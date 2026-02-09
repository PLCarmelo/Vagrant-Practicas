#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
echo "=== Instalando MySQL ==="
apt-get install -y mysql-server
echo "=== Configurando MySQL ==="
# Crear base de datos y usuario
mysql <<EOF
CREATE DATABASE IF NOT EXISTS lamp_db;
CREATE USER IF NOT EXISTS 'lamp_user'@'localhost' IDENTIFIED BY
'lamp_pass';
GRANT ALL PRIVILEGES ON lamp_db.* TO 'lamp_user'@'localhost';
FLUSH PRIVILEGES;
EOF
echo "MySQL configurado correctamente"
