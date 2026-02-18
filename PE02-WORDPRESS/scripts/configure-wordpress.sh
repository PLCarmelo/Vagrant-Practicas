#!/bin/bash
set -e
echo "=== Configurando WordPress ==="
cd /var/www/html
# Crear wp-config.php
cp wp-config-sample.php wp-config.php
# Configurar credenciales de base de datos
sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/" wp-config.php
sed -i "s/password_here/$DB_PASS/" wp-config.php
sed -i "s/localhost/$DB_HOST/" wp-config.php
# Generar salt keys
SALT_KEYS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
# Reemplazar las claves de ejemplo con las generadas
php <<ENDPHP
<?php
\$config = file_get_contents('/var/www/html/wp-config.php');
// Definir las claves a reemplazar
\$keys = array(
'AUTH_KEY',
'SECURE_AUTH_KEY',
'LOGGED_IN_KEY',
'NONCE_KEY',
'AUTH_SALT',
'SECURE_AUTH_SALT',
'LOGGED_IN_SALT',
'NONCE_SALT'
);
// Reemplazar cada clave con una vacía primero
foreach (\$keys as \$key) {
\$config = preg_replace(
"/define\(\s*'{$key}',\s*'[^']*'\s*\);/",
"define('{$key}', '$(openssl rand -base64 32)');",
\$config
);
}
file_put_contents('/var/www/html/wp-config.php', \$config);
?>
ENDPHP
# Añadir configuraciones adicionales
cat >> wp-config.php <<'EOF'
/* Configuración adicional */
define('WP_DEBUG', false);
define('WP_AUTO_UPDATE_CORE', false);
define('DISALLOW_FILE_EDIT', true);
/* Dirección del sitio */
define('WP_SITEURL', 'http://192.168.56.10');
define('WP_HOME', 'http://192.168.56.10');
EOF
echo "=== Verificando conexión a base de datos ==="
php -r "
try {
\$pdo = new PDO('mysql:host=$DB_HOST;dbname=$DB_NAME', '$DB_USER',
'$DB_PASS');
echo 'Conexión a BD exitosa!';
} catch (PDOException \$e) {
echo 'Error: ' . \$e->getMessage();
exit(1);
}
"
chown www-data:www-data wp-config.php
echo "=== WordPress configurado correctamente ==="
echo ""
echo "Accede a: http://localhost:8080"
echo "O directamente: http://192.168.56.10"