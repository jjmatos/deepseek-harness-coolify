FROM node:20-alpine

RUN apk add --no-cache git socat curl bash

WORKDIR /app

RUN npm install -g @deepseek-ai/dsh@latest

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8081 9081

CMD ["/start.sh"]
