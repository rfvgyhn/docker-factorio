#!/bin/sh

passwordPath="/config/rconpw"
if [[ ! -f $passwordPath ]]; then
    password=$(pwgen 15 1)
    echo $password > $passwordPath
else
    password=$(cat $passwordPath)
fi

mapGenSettings="/config/map-gen-settings.json"
if [[ ! -f $mapGenSettings ]]; then
    mv /tmp/map-gen-settings.json $mapGenSettings
fi

mapSettings="/config/map-settings.json"
if [[ ! -f $mapSettings ]]; then
    mv /tmp/map-settings.json $mapSettings
fi

serverSettings="/config/server-settings.json"
if [[ ! -f $serverSettings ]]; then
    mv /tmp/server-settings.json $serverSettings
fi

saveFile="/saves/$FACTORIO_SAVE_NAME.zip"
if [[ ! -f $saveFile ]]; then
    factorio --create $saveFile --map-gen-settings $mapGenSettings --map-settings $mapSettings
fi

params="--start-server $saveFile"
params="$params --mod-directory /mods"
params="$params --rcon-password $password"
params="$params --rcon-port 27015"
params="$params --server-settings $serverSettings"

if [[ ! -z "$FACTORIO_PORT" ]]; then
    params = "$params --port $FACTORIO_PORT"
fi
if [[ ! -z "$FACTORIO_BIND_ADDRESS" ]]; then
    params = "$params --bind $FACTORIO_BIND_ADDRESS"
fi
if [[ ! -z "$FACTORIO_SERVER_ID" ]]; then
    params = "$params --server-id $FACTORIO_SERVER_ID"
fi

serverWhitelist="/config/server-whitelist.json"
if [[ ! -z $serverWhitelist ]]; then
    params = "$params --server-whitelist $serverWhitelist"
fi

serverBanlist="/config/server-banlist.json"
if [[ ! -z $serverWhitelist ]]; then
    params = "$params --server-banlist $serverBanlist"
fi

exec factorio $params