# Servidor LAMP con Vagrant
Servidor Linux + Apache + MySQL + PHP completamente automatizado.
## Requisitos
- VirtualBox 7.0+
- Vagrant 2.4+
- 2 GB RAM libres
- 5 GB disco
## Instalación
\`\`\`bash
git clone <tu-repo>
cd PE01-LAMP
vagrant up
\`\`\`
## Acceso
- **Web**: http://localhost:8080
- **IP privada**: http://192.168.56.100
- **SSH**: `vagrant ssh`
## Credenciales
### MySQL
- Usuario: `lamp_user`
- Password: `lamp_pass`
- Base de datos: `lamp_db`
## Estructura
- `Vagrantfile`: Configuración de la VM
- `scripts/`: Scripts de provisioning
- `www/`: Contenido web
## Capturas
![Captura 1](screenshots/web.png)
![Captura 2](screenshots/phpinfo.png)
