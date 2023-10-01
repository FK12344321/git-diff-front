FROM node:20-alpine3.17

WORKDIR /app
COPY . /app/

RUN npm install
RUN npm run build

EXPOSE 8080

CMD ["npm", "run", "start"]