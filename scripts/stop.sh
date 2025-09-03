#!/bin/bash

# Script para detener Keycloak
echo "🛑 Deteniendo Keycloak IA Legal..."

# Cambiar al directorio del script
cd "$(dirname "$0")/.."

# Detener los contenedores
if command -v docker compose &> /dev/null; then
    docker compose down
else
    docker-compose down
fi

echo "✅ Keycloak IA Legal detenido exitosamente."