FROM node:22-bookworm-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    socat \
    && rm -rf /var/lib/apt/lists/*

RUN corepack enable

RUN npm install -g @deepseek-ai/dsh@0.1.0-rc.7

RUN dsh --version || true

EXPOSE 3080

CMD ["dsh", "web", "--port", "3080"]
