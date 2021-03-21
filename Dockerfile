FROM node:15.12 as builder
WORKDIR /tmp/nodejs-app

RUN apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get -y install nano && \
  apt-get clean

COPY nodejs-app .

RUN npm install


# Final docker image
FROM node:15.12.0-alpine3.10
LABEL maintainer="OiSiS"
WORKDIR /usr/src/nodejs-app

COPY --from=builder /tmp/nodejs-app .

EXPOSE 8000/tcp

CMD ["npm", "run", "dev"]
