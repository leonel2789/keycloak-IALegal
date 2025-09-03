#!/bin/bash

# Script para resetear completamente Keycloak (elimina todos los datos)
echo "⚠️  ADVERTENCIA: Este script eliminará todos los datos de Keycloak."
echo "⚠️  Esto incluye usuarios, configuraciones y datos de la base de datos."
echo ""
read -p "¿Estás seguro de que quieres continuar? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Operación cancelada."
    exit 0
fi

# Cambiar al directorio del script
cd "$(dirname "$0")/.."

echo "🛑 Deteniendo contenedores..."
if command -v docker compose &> /dev/null; then
    docker compose down -v
else
    docker-compose down -v
fi

echo "🗑️  Eliminando volúmenes..."
docker volume rm keycloak-ialegal_postgres_data 2>/dev/null || true

echo "🧹 Limpiando imágenes no utilizadas..."
docker system prune -f

echo "✅ Reset completado. Puedes iniciar Keycloak nuevamente con ./scripts/start.sh"