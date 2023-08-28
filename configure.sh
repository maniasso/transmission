#!/bin/sh

usage="$(basename "$0") <username> <password>"

if [ ! $# -eq 2 ]; then
    echo "$usage"
    exit 1
fi
touch /config/lock && \
pkill -f transmission-daemon && \
sleep 2 && \
#sed -Ei "s/\"rpc-password\": [^,]+/\"rpc-password\": \"$2\"/" /config/settings.json && \
#sed -Ei "s/\"rpc-username\": [^,]+/\"rpc-username\" : \"$1\"/" /config/settings.json && \
#sed -i 's/"rpc-authentication-required": true/"rpc-authentication-required": false/g' /config/settings.json

echo 'Credentials set. Restarting...' && \
rm /config/lock
