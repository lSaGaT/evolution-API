FROM node:20

WORKDIR /app

# Clonar Evolution API
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

# Instalar dependências
RUN npm install

# Build (se necessário)
RUN npm run build || true

EXPOSE 8080

CMD ["npm", "run", "start"]
