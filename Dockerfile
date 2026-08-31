FROM node:20-alpine

RUN apk add --no-cache git socat curl bash

WORKDIR /app

# Instala DeepSeek Harness (versión más reciente)
RUN npm install -g @deepseek-ai/dsh@0.1.2-alpha.1

# Copia el script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8081 9081

CMD ["/start.sh"]
