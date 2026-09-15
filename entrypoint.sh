#!/bin/bash
set -e

mkdir -p /opt/xray

# Download Xray binary
if [ ! -f /usr/local/bin/xray ]; then
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
    unzip -o /tmp/xray.zip -d /tmp/xray
    mv /tmp/xray/xray /usr/local/bin/xray
    chmod +x /usr/local/bin/xray
fi

UUID=${UUID:-$(cat /proc/sys/kernel/random/uuid)}
SERVER_NAME=${SERVER_NAME:-www.microsoft.com}
SHORT_ID=${SHORT_ID:-$(openssl rand -hex 4)}

if [ -z "$REALITY_PRIVATE_KEY" ]; then
    echo "Missing REALITY_PRIVATE_KEY"
    echo "Generate with:"
    echo "xray x25519"
    exit 1
fi

sed \
-e "s|__UUID__|$UUID|g" \
-e "s|__SERVER_NAME__|$SERVER_NAME|g" \
-e "s|__SHORT_ID__|$SHORT_ID|g" \
-e "s|__PRIVATE_KEY__|$REALITY_PRIVATE_KEY|g" \
config.json.template > /opt/xray/config.json

echo "Xray starting"
echo "UUID=$UUID"
echo "SERVER_NAME=$SERVER_NAME"
echo "SHORT_ID=$SHORT_ID"

exec /usr/local/bin/xray run -config /opt/xray/config.json
