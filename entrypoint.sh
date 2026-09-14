#!/bin/sh
set -eu

UUID=${UUID:-b9c8b83a-37c1-49fa-8732-edaaefcba362}
REALITY_SHORT_ID=${REALITY_SHORT_ID:-b466fa92}
XHTTP_PATH=${XHTTP_PATH:-/xhttp-7f29c4e1}
REALITY_SNI=${REALITY_SNI:-www.microsoft.com}

if [ -z "${REALITY_PRIVATE_KEY:-}" ]; then
 echo "Generating REALITY key pair..."
 /opt/xray/xray x25519 | tee /tmp/reality-key.txt
 REALITY_PRIVATE_KEY=$(grep "Private key" /tmp/reality-key.txt | awk '{print $3}')
 REALITY_PUBLIC_KEY=$(grep "Public key" /tmp/reality-key.txt | awk '{print $3}')
 echo "SAVE THESE KEYS"
 echo "Private Key: $REALITY_PRIVATE_KEY"
 echo "Public Key: $REALITY_PUBLIC_KEY"
else
 REALITY_PUBLIC_KEY=""
fi

export UUID REALITY_PRIVATE_KEY REALITY_SHORT_ID XHTTP_PATH REALITY_SNI
envsubst < /opt/xray/config.template.json > /opt/xray/config.json
exec /opt/xray/xray run -config /opt/xray/config.json
