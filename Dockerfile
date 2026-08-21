FROM node:22-bookworm-slim

WORKDIR /app

# Instalar herramientas de diagnóstico
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Habilitar corepack
RUN corepack enable

# Instalar dsh globalmente (evita problemas con npx en runtime)
RUN npm install -g @deepseek-ai/dsh@0.1.0-rc.7

# Verificar instalación
RUN dsh --version || true

EXPOSE 3080

# Ejecutar directamente el comando
CMD ["dsh", "web", "--host", "0.0.0.0", "--port", "3080"]
