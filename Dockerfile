FROM node:20-slim
WORKDIR /app

RUN apt-get update && apt-get install -y git openssl && rm -rf /var/lib/apt/lists/*

# Clonar repo
RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

# Instalar deps
RUN npm install

# Gerar Prisma client (PostgreSQL é o padrão no Render)
RUN npx prisma generate --schema ./prisma/postgresql-schema.prisma

# Build TypeScript
RUN npm run build 2>/dev/null || true

ENV PORT=8080
ENV DATABASE_PROVIDER=postgresql
EXPOSE 8080

CMD ["npm", "run", "start:prod"]
