# PE02 - Despliegue de Infraestructura WordPress Multi-máquina 🚀

Este proyecto implementa una arquitectura profesional de dos niveles (Decoupled Architecture) para **WordPress**. Se han utilizado **Vagrant** y **VirtualBox** para automatizar la creación de un entorno donde el servidor web y la base de datos residen en máquinas virtuales independientes, comunicadas de forma segura a través de una red privada.

## 🏗️ Arquitectura del Sistema

La infraestructura separa los servicios para garantizar mayor seguridad y escalabilidad. El tráfico web entra por el puerto 8080 del host y se redirige al servidor web interno.


### Detalles de Infraestructura
| Componente | Especificación Técnica | IP Privada |
| :--- | :--- | :--- |
| **Nodo Web** (`web-server`) | Apache 2.4, PHP 7.4+, WordPress | `192.168.56.10` |
| **Nodo DB** (`db-server`) | MySQL 8.0 (Escuchando en 0.0.0.0) | `192.168.56.20` |
| **Red Privada** | Host-Only Ethernet Adapter | `192.168.56.0/24` |
| **Redirección** | Host:8080 -> Web:80 | N/A |


## 📁 Estructura del Proyecto

El proyecto se organiza de forma modular para facilitar el mantenimiento de la Infraestructura como Código (IaC):

PE02-LAMP/
├── Vagrantfile                # Orquestador de las máquinas virtuales
├── README.md                  # Documentación del proyecto (este archivo)
├── config/
│   └── wordpress.conf         # Configuración del VirtualHost de Apache
└── scripts/                   # Scripts de automatización (Provisioning)
    ├── common.sh              # Configuración base y resolución de nombres
    ├── install-db.sh          # Instalación y securización de MySQL
    ├── install-web.sh         # Instalación de Apache, PHP y librerías
    └── configure-wordpress.sh # Despliegue y configuración de WordPress

## 🛠️ Detalle del Provisioning (Automatización)

El despliegue está totalmente automatizado mediante scripts de Bash que configuran cada componente:

* **`common.sh`**: Configura la resolución de nombres local editando el archivo `/etc/hosts`. Esto permite que ambas máquinas virtuales se reconozcan por nombre (`web-server` y `db-server`) sin necesidad de un servidor DNS externo.
* **`install-db.sh`**: Realiza la instalación de MySQL Server 8.0. Configura el servicio para aceptar conexiones externas cambiando el `bind-address` a `0.0.0.0` y crea la base de datos junto con el usuario con privilegios remotos.
* **`install-web.sh`**: Instala el stack de servidor web (Apache 2.4 y PHP 7.4+). Además, automatiza el despliegue del archivo de configuración `wordpress.conf` para gestionar el VirtualHost.
* **`configure-wordpress.sh`**: Se encarga de la lógica de aplicación. Descarga la última versión de WordPress, genera el archivo `wp-config.php` vinculándolo a la IP del servidor de base de datos y ajusta los permisos de archivos para el usuario `www-data`.


## 🔐 Credenciales y Acceso

### 🗄️ Base de Datos
| Parámetro | Valor |
| :--- | :--- |
| **BD Name** | `wordpress_db` |
| **Usuario** | `wp_user` |
| **Password** | `wp_secure_pass` |
| **Host permitido** | `192.168.56.%` (Rango red privada) |

### 🌐 Administrador WordPress
| Parámetro | Valor |
| :--- | :--- |
| **URL de Acceso** | [http://localhost:8080/wp-admin](http://localhost:8080/wp-admin) |
| **Usuario** | `admin` |
| **Contraseña** | `Inves123.` |

