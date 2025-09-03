# Keycloak IA Legal

Configuración completa de Keycloak para la aplicación Front IA Legal, incluyendo autenticación y autorización para aplicaciones móviles React Native.

## 🚀 Inicio Rápido

### Prerrequisitos
- Docker y Docker Compose instalados
- Puerto 8080 disponible
- Puerto 5432 disponible (PostgreSQL)

### Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone <repository-url>
   cd keycloak-IALegal
   ```

2. **Iniciar Keycloak**:
   ```bash
   ./scripts/start.sh
   ```

3. **Acceder a la consola de administración**:
   - URL: http://localhost:8080/admin
   - Usuario: `admin`
   - Contraseña: `admin123`

## 📋 Configuración

### Realm: `ia-legal`
- **Nombre**: IA Legal Realm
- **Configuración**: Importada automáticamente desde `realm-config/ia-legal-realm.json`
- **Idioma por defecto**: Español
- **Soporte de idiomas**: Español e Inglés

### Cliente: `front-ia-client`
- **Client ID**: `front-ia-client`
- **Client Secret**: `front-ia-secret-2024`
- **Tipo**: Confidential Client
- **Protocolo**: OpenID Connect
- **Flujos habilitados**: Authorization Code Flow
- **Redirect URIs configuradas**:
  - `exp://192.168.*:8081` (Expo development)
  - `exp://localhost:8081`
  - `http://localhost:8081`
  - `https://auth.expo.io/@*/front-ia`
  - `exp://exp.host/@*/front-ia`
  - `front-ia://auth`

### Usuarios Predefinidos

#### Administrador
- **Usuario**: `admin`
- **Contraseña**: `admin123`
- **Email**: `admin@ialegal.com`
- **Roles**: `ia-admin`
- **Grupo**: `ia-admins`

#### Usuario de Prueba
- **Usuario**: `testuser`
- **Contraseña**: `test123`
- **Email**: `testuser@ialegal.com`
- **Roles**: `ia-user`
- **Grupo**: `ia-users`

### Roles y Permisos

#### Roles del Realm
- `ia-admin`: Administrador con permisos completos
- `ia-user`: Usuario básico con permisos limitados

#### Grupos
- `ia-admins`: Grupo de administradores
- `ia-users`: Grupo de usuarios básicos

## 🛠️ Scripts de Administración

### Iniciar Keycloak
```bash
./scripts/start.sh
```
Inicia todos los contenedores y espera a que Keycloak esté listo.

### Detener Keycloak
```bash
./scripts/stop.sh
```
Detiene todos los contenedores sin eliminar datos.

### Reset Completo
```bash
./scripts/reset.sh
```
⚠️ **CUIDADO**: Elimina todos los datos y configuraciones.

### Crear Backup
```bash
./scripts/backup.sh
```
Crea un backup completo de la base de datos y configuración.

## 🔧 Configuración de la Aplicación Front IA

### Variables de Entorno
Asegúrate de configurar estas variables en tu aplicación React Native:

```env
EXPO_PUBLIC_KEYCLOAK_URL=http://localhost:8080
EXPO_PUBLIC_KEYCLOAK_REALM=ia-legal
EXPO_PUBLIC_KEYCLOAK_CLIENT_ID=front-ia-client
```

### Ejemplo de Configuración
El archivo `config.ts` en tu aplicación debería verse así:

```typescript
export const KEYCLOAK_CONFIG = {
  url: process.env.EXPO_PUBLIC_KEYCLOAK_URL || 'http://localhost:8080',
  realm: process.env.EXPO_PUBLIC_KEYCLOAK_REALM || 'ia-legal',
  clientId: process.env.EXPO_PUBLIC_KEYCLOAK_CLIENT_ID || 'front-ia-client'
};
```

## 🌐 URLs Importantes

### Administración
- **Admin Console**: http://localhost:8080/admin
- **Realm Settings**: http://localhost:8080/admin/master/console/#/ia-legal/realm-settings

### Endpoints del Realm
- **Realm**: http://localhost:8080/realms/ia-legal
- **OpenID Configuration**: http://localhost:8080/realms/ia-legal/.well-known/openid_configuration
- **Auth Endpoint**: http://localhost:8080/realms/ia-legal/protocol/openid-connect/auth
- **Token Endpoint**: http://localhost:8080/realms/ia-legal/protocol/openid-connect/token
- **UserInfo Endpoint**: http://localhost:8080/realms/ia-legal/protocol/openid-connect/userinfo
- **Logout Endpoint**: http://localhost:8080/realms/ia-legal/protocol/openid-connect/logout

## 🔐 Seguridad

### Configuraciones de Seguridad
- **Brute Force Protection**: Habilitado
- **Max Login Failures**: 30
- **SSL Required**: Solo para conexiones externas
- **Remember Me**: Habilitado
- **Reset Password**: Habilitado

### Tokens
- **Access Token Lifespan**: 5 minutos (default)
- **Refresh Token Lifespan**: 30 minutos (default)
- **SSO Session Idle**: 30 minutos (default)

## 📁 Estructura del Proyecto

```
keycloak-IALegal/
├── docker-compose.yml          # Configuración de Docker
├── realm-config/
│   └── ia-legal-realm.json    # Configuración del realm
├── themes/                     # Temas personalizados (futuro)
├── scripts/
│   ├── start.sh               # Iniciar Keycloak
│   ├── stop.sh                # Detener Keycloak
│   ├── reset.sh               # Reset completo
│   └── backup.sh              # Crear backup
├── backups/                    # Directorio de backups
└── README.md                   # Esta documentación
```

## 🐳 Docker Compose

### Servicios
- **PostgreSQL**: Base de datos para Keycloak
- **Keycloak**: Servidor de autenticación y autorización

### Volúmenes
- `postgres_data`: Datos persistentes de PostgreSQL
- `./realm-config`: Configuración del realm (montado)
- `./themes`: Temas personalizados (montado)

## 🔍 Troubleshooting

### Keycloak no inicia
1. Verificar que los puertos 8080 y 5432 estén disponibles
2. Verificar que Docker esté corriendo
3. Revisar los logs: `docker-compose logs -f`

### Error de conexión desde la app
1. Verificar que Keycloak esté corriendo: http://localhost:8080
2. Verificar la configuración de redirect URIs en el cliente
3. Verificar las variables de entorno en la aplicación

### Reset de configuración
Si necesitas volver a la configuración inicial:
```bash
./scripts/reset.sh
./scripts/start.sh
```

## 📞 Soporte

Para problemas o preguntas:
1. Revisar los logs de Docker: `docker-compose logs`
2. Verificar la configuración en la Admin Console
3. Consultar la documentación oficial de Keycloak

## 🚀 Próximos Pasos

1. **Configurar SSL/TLS** para producción
2. **Personalizar temas** para la marca IA Legal
3. **Configurar proveedores de identidad externos** (Google, Facebook, etc.)
4. **Implementar roles más granulares** según necesidades del negocio
5. **Configurar notificaciones por email**

