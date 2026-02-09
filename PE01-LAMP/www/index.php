<!DOCTYPE html>
<html lang="es">
<head>
 <meta charset="UTF-8">
 <title>Servidor LAMP</title>
 <style>
 body { font-family: Arial; margin: 40px; }
 .success { color: green; }
 .error { color: red; }
 table { border-collapse: collapse; margin: 20px 0; }
 td, th { border: 1px solid #ddd; padding: 8px; }
 </style>
</head>
<body>
 <h1>🖥 Servidor LAMP Funcionando</h1>

 <h2>Información del Servidor</h2>
 <table>
 <tr><td>Hostname</td><td><?php echo gethostname(); ?></td></tr>
 <tr><td>IP</td><td><?php echo $_SERVER['SERVER_ADDR']; ?></td>
</tr>
 <tr><td>SO</td><td><?php echo php_uname(); ?></td></tr>
 </table>

 <h2>Versiones Software</h2>
 <table>
 <tr><td>Apache</td><td><?php echo apache_get_version(); ?></td>
</tr>
 <tr><td>PHP</td><td><?php echo phpversion(); ?></td></tr>
 <tr><td>MySQL</td><td>
 <?php
 try {
 $conn = new PDO("mysql:host=localhost", "root", "");
 echo $conn->query('SELECT VERSION()')->fetchColumn();
 } catch (PDOException $e) {
 echo "N/A";
 }
 ?>
 </td></tr>
 </table>

 <h2>Conexión a Base de Datos</h2>
 <?php
 try {
 $conn = new PDO(
 "mysql:host=localhost;dbname=lamp_db",
 "lamp_user",
 "lamp_pass"
 );
 echo '<p class="success">✅ Conexión exitosa a lamp_db</p>';
 } catch (PDOException $e) {
 echo '<p class="error">❌ Error: ' . $e->getMessage() . '</p>';
 }
 ?>

 <h2>Extensiones PHP</h2>
 <p><?php echo implode(', ', get_loaded_extensions()); ?></p>

 <hr>
 <p><a href="info.php">Ver phpinfo() completo</a></p>
</body>
</html>