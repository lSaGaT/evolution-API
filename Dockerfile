FROM node:20-slim
WORKDIR /app

RUN apt-get update && apt-get install -y git openssl && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install

RUN npx prisma generate --schema ./prisma/postgresql-schema.prisma

RUN npm run build 2>/dev/null || true

# Cria o script de entrada
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'npx prisma migrate deploy --schema ./prisma/postgresql-schema.prisma' >> /entrypoint.sh && \
    echo 'exec npm run start:prod' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENV PORT=8080
ENV DATABASE_PROVIDER=postgresql
EXPOSE 8080

CMD ["/entrypoint.sh"]
