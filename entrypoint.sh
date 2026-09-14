#!/bin/sh
set -e
: "${UUID:?需要 UUID}"
: "${PRIVATE_KEY:?需要 REALITY PRIVATE_KEY}"
: "${SHORT_ID:?需要 SHORT_ID}"

mkdir -p /opt/xray
cat > /opt/xray/config.json <<EOF
{
 "inbounds":[{
  "port":443,
  "protocol":"vless",
  "settings":{
   "clients":[{"id":"${UUID}","flow":"xtls-rprx-vision"}],
   "decryption":"none"
  },
  "streamSettings":{
   "network":"tcp",
   "security":"reality",
   "realitySettings":{
    "dest":"www.microsoft.com:443",
    "privateKey":"${PRIVATE_KEY}",
    "shortIds":["${SHORT_ID}"]
   }
  }
 }],
 "outbounds":[{"protocol":"freedom"}]
}
EOF

exec /usr/local/bin/xray -config /opt/xray/config.json
