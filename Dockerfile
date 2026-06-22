FROM node:20-alpine3.19 AS builder
WORKDIR /opt/server
COPY catalogue-v3/package.json .
COPY catalogue-v3/*.js .
RUN npm install

FROM node:20-alpine3.19
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
ENV MONGO="true" \
    MONGO_URL="mongodb://mongodb:27017/catalogue"
WORKDIR /opt/server
USER roboshop
COPY --from=builder /opt/server /opt/server
CMD ["node","server.js"]