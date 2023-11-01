FROM node:16.13.1-alpine

ARG API_URL

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0 \
    API_URL=${API_URL}
WORKDIR /app

EXPOSE 3000