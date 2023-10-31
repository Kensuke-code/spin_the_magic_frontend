FROM node:18.18.2-alpine3.18

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0

WORKDIR /app

EXPOSE 3000