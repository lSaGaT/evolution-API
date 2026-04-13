FROM node:20

WORKDIR /app

RUN apt-get update && apt-get install -y git

# Clonar repo
RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

# Instalar deps
RUN npm install

# 🔥 AQUI É A CORREÇÃO
RUN npx prisma generate

# (opcional mas recomendado)
RUN npx prisma db push || true

EXPOSE 8080

CMD ["npm", "run", "start"]
