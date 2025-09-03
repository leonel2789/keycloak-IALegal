#!/bin/bash

# Script para hacer backup de la configuración de Keycloak
BACKUP_DIR="./backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "💾 Creando backup de Keycloak IA Legal..."

# Cambiar al directorio del script
cd "$(dirname "$0")/.."

# Verificar que los contenedores estén corriendo
if ! docker ps | grep keycloak > /dev/null; then
    echo "❌ Error: Keycloak no está corriendo. Inicia los contenedores primero."
    exit 1
fi

# Backup de la base de datos
echo "📦 Creando backup de la base de datos..."
docker exec keycloak-ialegal-postgres-1 pg_dump -U keycloak keycloak > "$BACKUP_DIR/database.sql"

# Backup de la configuración del realm
echo "📦 Copiando configuración del realm..."
cp -r realm-config "$BACKUP_DIR/"

# Crear un archivo de información del backup
cat > "$BACKUP_DIR/backup_info.txt" << EOF
Backup de Keycloak IA Legal
==========================
Fecha: $(date)
Realm: ia-legal
Cliente: front-ia-client

Contenido del backup:
- database.sql: Backup completo de la base de datos PostgreSQL
- realm-config/: Configuración del realm y cliente

Para restaurar:
1. Detener Keycloak: ./scripts/stop.sh
2. Resetear: ./scripts/reset.sh
3. Copiar realm-config de vuelta
4. Iniciar: ./scripts/start.sh
5. Importar database.sql si es necesario
EOF

echo "✅ Backup creado exitosamente en: $BACKUP_DIR"
echo "📋 Contenido del backup:"
ls -la "$BACKUP_DIR"