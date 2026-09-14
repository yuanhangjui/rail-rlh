FROM alpine:latest
RUN apk add --no-cache curl unzip ca-certificates
RUN curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o /tmp/x.zip && unzip /tmp/x.zip -d /usr/local/bin && chmod +x /usr/local/bin/xray
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
EXPOSE 443
CMD ["/app/entrypoint.sh"]
