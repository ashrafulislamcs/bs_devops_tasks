FROM node:14-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production
COPY . .
CMD [ "node", "index.js" ]
EXPOSE 3033
