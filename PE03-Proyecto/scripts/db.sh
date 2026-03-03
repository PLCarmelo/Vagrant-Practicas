#!/bin/bash
# Evitar que MySQL pida interacción durante la instalación
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get install -y mysql-server

# Permitir que MySQL escuche peticiones desde cualquier IP (0.0.0.0)
sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

# Crear la base de datos para la aplicación
sudo mysql -e "CREATE DATABASE IF NOT EXISTS web_db;"

# Crear usuario con permisos remotos y método de contraseña nativo para PHP
sudo mysql -e "CREATE USER IF NOT EXISTS 'webuser'@'%' IDENTIFIED WITH mysql_native_password BY 'password';"
sudo mysql -e "ALTER USER 'webuser'@'%' IDENTIFIED WITH mysql_native_password BY 'password';"

# Asignar privilegios totales al usuario sobre la base de datos creada
sudo mysql -e "GRANT ALL PRIVILEGES ON web_db.* TO 'webuser'@'%';"
sudo mysql -e "FLUSH PRIVILEGES;" # Aplicar cambios inmediatamente
