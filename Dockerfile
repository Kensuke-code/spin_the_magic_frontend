FROM node:18.18.2-alpine3.18

ARG API_URL

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0 \
    API_URL=${API_URL}
WORKDIR /app

EXPOSE 3000