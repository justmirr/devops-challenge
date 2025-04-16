FROM node:23-alpine

WORKDIR /usr/src/app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY package*.json ./

RUN npm install --only=production

COPY . .

RUN chown -R appuser:appgroup /usr/src/app

USER appuser

EXPOSE 3000

CMD ["npm", "start"]