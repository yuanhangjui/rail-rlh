#!/bin/bash
set -e

mkdir -p /data

UUID=${UUID:?UUID required}
SHORT_ID=${SHORT_ID:-12345678}
SERVER_NAME=${SERVER_NAME:-www.microsoft.com}

if [ -z "$REALITY_PRIVATE_KEY" ]; then
  if [ -f /data/reality_private.key ]; then
    REALITY_PRIVATE_KEY=$(cat /data/reality_private.key)
  else
    echo "Generating REALITY key pair..."
    echo "NOTE: install xray binary before production use."
    exit 1
  fi
fi

sed -e "s|UUID_VALUE|$UUID|g" -e "s|PRIVATE_KEY_VALUE|$REALITY_PRIVATE_KEY|g" -e "s|SHORT_ID_VALUE|$SHORT_ID|g" -e "s|SERVER_NAME_VALUE|$SERVER_NAME|g" config.template.json > config.json

exec xray run -c config.json
