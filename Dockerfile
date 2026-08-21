FROM node:22-bookworm-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN corepack enable

EXPOSE 3080

CMD ["sh", "-lc", "npx @deepseek-ai/dsh web --host 0.0.0.0 --port 3080"]
