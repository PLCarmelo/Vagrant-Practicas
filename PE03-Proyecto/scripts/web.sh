#!/bin/bash
# Instalar Apache, PHP y el conector necesario para MySQL
sudo apt-get update
sudo apt-get install -y apache2 php libapache2-mod-php php-mysql

# Borrar el index.html por defecto para que Apache use nuestro index.php
sudo rm -f /var/www/html/index.html

# Generar el archivo PHP con diseño y lógica de colores
cat <<EOF | sudo tee /var/www/html/index.php
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cluster Web - Proyecto Final</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7f6; display: flex; justify-content: center; padding-top: 50px; }
        .card { background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); width: 400px; text-align: center; }
        .status { padding: 10px; border-radius: 6px; margin-top: 20px; font-weight: bold; }
        .success { background-color: #d4edda; color: #155724; }
        .error { background-color: #f8d7da; color: #721c24; }
        .ip-info { font-size: 0.85rem; color: #555; margin-top: 10px; font-family: monospace; }
    </style>
</head>
<body>
    <div class="card">
        <?php
        \$hostname = gethostname(); // Obtiene el nombre de la VM (web1, web2 o web3)
        \$ip_address = \$_SERVER['SERVER_ADDR']; // Obtiene la IP de esta máquina
        
        // Asignación de colores por nombre de servidor
        \$colors = [
            'web1' => '#3498db', # Azul
            'web2' => '#e67e22', # Naranja
            'web3' => '#27ae60'  # Verde
        ];
        \$headerColor = isset(\$colors[\$hostname]) ? \$colors[\$hostname] : '#2c3e50';
        ?>
        
        <h1 style="color: <?php echo \$headerColor; ?>;">Nodo: <?php echo \$hostname; ?></h1>
        <div class="ip-info">IP Interna: <?php echo \$ip_address; ?></div>
        
        <div style="border-top: 4px solid <?php echo \$headerColor; ?>; margin-top:15px; padding-top: 15px;">
        <?php
        // Intentar conectar a la base de datos centralizada
        \$conn = new mysqli('192.168.56.20', 'webuser', 'password', 'web_db');
        if (\$conn->connect_error) {
            echo "<div class='status error'>❌ Error de conexión DB</div>";
        } else {
            echo "<div class='status success'>✅ DB Conectada</div>";
        }
        ?>
        </div>
    </div>
</body>
</html>
EOF

sudo systemctl restart apache2