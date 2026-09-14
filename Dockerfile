FROM alpine:latest
RUN apk add --no-cache bash ca-certificates
WORKDIR /app
COPY entrypoint.sh config.template.json ./
RUN chmod +x entrypoint.sh
CMD ["/app/entrypoint.sh"]
