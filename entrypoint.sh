#!/bin/sh
set -eu
: "${UUID:?Missing UUID Railway variable}"
: "${REALITY_PRIVATE_KEY:?Missing REALITY_PRIVATE_KEY Railway variable}"
: "${REALITY_SHORT_ID:?Missing REALITY_SHORT_ID Railway variable}"
XHTTP_PATH="${XHTTP_PATH:-/xhttp-7f29c4e1}"
REALITY_SNI="${REALITY_SNI:-www.microsoft.com}"
REALITY_DEST="${REALITY_DEST:-www.microsoft.com:443}"
export UUID REALITY_PRIVATE_KEY REALITY_SHORT_ID XHTTP_PATH REALITY_SNI REALITY_DEST
envsubst < /opt/xray/config.template.json > /opt/xray/config.json
echo "=== Xray VLESS + XHTTP + REALITY ==="
echo "XHTTP path: ${XHTTP_PATH}"
echo "REALITY SNI: ${REALITY_SNI}"
exec /opt/xray/xray run -config /opt/xray/config.json
