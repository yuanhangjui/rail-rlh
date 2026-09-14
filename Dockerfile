FROM alpine:3.22
RUN apk add --no-cache ca-certificates curl unzip gettext
WORKDIR /opt/xray
ARG XRAY_VERSION=26.9.9
RUN curl -fL https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip -o /tmp/xray.zip \
 && unzip -j /tmp/xray.zip xray -d /opt/xray \
 && chmod 755 /opt/xray/xray \
 && rm /tmp/xray.zip
COPY config.template.json /opt/xray/config.template.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 443
ENTRYPOINT ["/entrypoint.sh"]
