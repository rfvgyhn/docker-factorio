# Factorio Docker

[Factorio][0] headless server - v0.14.11-experimental

## Usage

### Quickstart

```
docker run -d --name factorio -p 34197:34197/udp rfvgyhn/factorio
```

### Volumes

* `/saves` mount for save files
* `/mods` mount for mods
* `/config` mount for configuration files

```
docker run -d --name factorio \
   -p 34197:34197/udp \
   -v /host/path/saves:/saves \
   -v /host/path/mods:/mods \
   -v /host/path/config:/config \
   rfvgyhn/factorio
```

### Options

The following environment variables are available. The values shown the defaults used if
the var isn't specified.

* `FACTORIO_SAVE_NAME=meeseeks` the name of the save file in `/saves`
* `FACTORIO_AUTOSAVE_INTERVAL=2` server autosave interval in minutes
* `FACTORIO_AUTOSAVE_SLOTS=3` number of autosave files to keep
* `FACTORIO_AFK_AUTOKICK_INTERVAL=0` interval after which to auto-kick players
* `FACTORIO_ALLOW_COMMANDS=false` allow (true), disallow (false) or restrict (admins-only) use of the command console. Note that running almost any console command will disable achievements.
* `FACTORIO_AUTO_PAUSE=true` pause the server when no players are on.

```
docker run -d --name factorio \
   -p 34197:34197/udp \
   -v /host/path/saves:/saves \
   -v /host/path/mods:/mods \
   -v /host/path/config:/config \
   -e FACTORIO_SAVE_NAME=rick \
   -e FACTORIO_ALLOW_COMMANDS=true \
   rfvgyhn/factorio
```

### Configuration

You may specify `server-settings.json` and `map-gen-settings.json` by mounting the 
`/config` volume.

The RCON password is randomly generated and stored in `/config/rconpw`/

## Docker Images

The `latest` tag will always follow the latest [factorio server][1] release
(including [experimental releases][2]).

The `stable` tag will always follow the latest stable [factorio server][1] release.

Each version will also have its own tag.


[0]: https://www.factorio.com/
[1]: https://www.factorio.com/download-headless/stable
[2]: https://www.factorio.com/download-headless/experimental

