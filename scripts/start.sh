#!/bin/bash

# Script para iniciar Keycloak con configuración completa
echo "🚀 Iniciando Keycloak IA Legal..."

# Verificar que Docker esté corriendo
if ! docker info > /dev/null 2>&1; then
    echo "❌ Error: Docker no está corriendo. Por favor inicia Docker primero."
    exit 1
fi

# Verificar que docker-compose esté disponible
if ! command -v docker-compose &> /dev/null && ! command -v docker compose &> /dev/null; then
    echo "❌ Error: docker-compose no está instalado."
    exit 1
fi

# Cambiar al directorio del script
cd "$(dirname "$0")/.."

# Construir e iniciar los contenedores
echo "📦 Construyendo e iniciando contenedores..."
if command -v docker compose &> /dev/null; then
    docker compose up -d --build
else
    docker-compose up -d --build
fi

# Esperar a que Keycloak esté listo
echo "⏳ Esperando a que Keycloak esté listo..."
sleep 30

# Verificar que Keycloak esté corriendo
echo "🔍 Verificando estado de Keycloak..."
for i in {1..30}; do
    if curl -f http://localhost:8080/health/ready > /dev/null 2>&1; then
        echo "✅ Keycloak está listo!"
        break
    elif [ $i -eq 30 ]; then
        echo "❌ Timeout: Keycloak no respondió después de 5 minutos"
        exit 1
    else
        echo "⏳ Intentando conectar... ($i/30)"
        sleep 10
    fi
done

echo ""
echo "🎉 ¡Keycloak IA Legal iniciado exitosamente!"
echo ""
echo "📋 Información de acceso:"
echo "   🌐 Admin Console: http://localhost:8080/admin"
echo "   👤 Usuario: admin"
echo "   🔑 Contraseña: admin123"
echo ""
echo "📋 Realm IA Legal:"
echo "   🌐 URL: http://localhost:8080/realms/ia-legal"
echo "   👤 Usuario de prueba: testuser"
echo "   🔑 Contraseña: test123"
echo ""
echo "📋 Cliente configurado:"
echo "   🆔 Client ID: front-ia-client"
echo "   🔑 Client Secret: front-ia-secret-2024"
echo ""