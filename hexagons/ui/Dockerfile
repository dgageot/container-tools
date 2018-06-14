FROM node:12.1.0-alpine

WORKDIR /app
EXPOSE 8080 35729
ENV NODE_ENV development
CMD ["node", "app.js"]

COPY package*.json ./
RUN npm install
COPY . .
