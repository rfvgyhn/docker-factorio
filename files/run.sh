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
    cp /tmp/map-gen-settings.json $mapGenSettings
fi

serverSettings="/config/server-settings.json"
if [[ ! -f $serverSettings ]]; then
    cp /tmp/server-settings.json $serverSettings
fi

rm /tmp/map-gen-settings.json
rm /tmp/server-settings.json

saveFile="/saves/$FACTORIO_SAVE_NAME.zip"
if [[ ! -f $saveFile ]]; then
    factorio --create $saveFile --map-gen-settings $mapGenSettings
fi

params="--start-server $saveFile"
params="$params --autosave-interval ${FACTORIO_AUTOSAVE_INTERVAL}"
params="$params --autosave-slots ${FACTORIO_AUTOSAVE_SLOTS}"
params="$params --afk-autokick-interval ${FACTORIO_AFK_AUTOKICK_INTERVAL}"
params="$params --allow-commands ${FACTORIO_ALLOW_COMMANDS}"
params="$params --mod-directory /mods"
params="$params --rcon-password $password"
params="$params --rcon-port 27015"
params="$params --server-settings $serverSettings"

if ! echo "$FACTORIO_AUTO_PAUSE" | grep -iq true; then
    params="$params --no-auto-pause"
fi

exec factorio $params