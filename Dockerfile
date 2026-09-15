FROM alpine:3.20

RUN apk add --no-cache bash curl unzip ca-certificates openssl

WORKDIR /app

COPY entrypoint.sh .
COPY config.json.template .

RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]
