#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx

# Sobrescribir la configuración por defecto con nuestro archivo de balanceo
# El archivo se toma de la carpeta compartida /vagrant
sudo cp /vagrant/config-files/nginx.conf /etc/nginx/sites-available/default

# Reiniciar Nginx para que empiece a repartir el tráfico
sudo systemctl restart nginx