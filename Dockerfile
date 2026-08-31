FROM node:22-bookworm-slim

ENV NODE_ENV=production
ENV npm_config_build_from_source=true

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      git \
      socat \
      python3 \
      make \
      g++ && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Instala DSH y fuerza la compilación del módulo nativo node-pty para linux/arm64.
RUN npm install -g --foreground-scripts @deepseek-ai/dsh@latest && \
    DSH_DIR="$(npm root -g)/@deepseek-ai/dsh" && \
    cd "$DSH_DIR/node_modules/node-pty" && \
    npm rebuild --foreground-scripts

COPY start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 8081 9081

CMD ["/start.sh"]
