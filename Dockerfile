FROM node:20

WORKDIR /app

RUN apt-get update && apt-get install -y git

# Clonar repo
RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

# Instalar deps
RUN npm install

# 🔥 Corrigido: apontando schema
RUN npx prisma generate --schema=./src/prisma/schema.prisma || npx prisma generate --schema=./prisma/schema.prisma

# (opcional)
RUN npx prisma db push || true

ENV PORT=8080

EXPOSE 8080

CMD ["npm", "run", "start"]
