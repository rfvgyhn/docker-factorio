# Factorio Docker

[Factorio][0] headless server

Branch         | Size             | Version          
---------------|------------------|---------------
latest         | [![Size][6]][2]  | [![Version][7]][2]
stable         | [![Size][8]][2]  | [![Version][9]][2]
experimental   | [![Size][10]][2] | [![Version][11]][2]

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

The following environment variables are available. The values show the defaults used if
the var isn't specified.

* `FACTORIO_SAVE_NAME=meeseeks` the name of the save file in `/saves`
* `FACTORIO_PORT=` network port to use
* `FACTORIO_BIND_ADDRESS=` IP address (and optionally port) to bind to (`address[:port]`)
* `FACTORIO_SERVER_ID=` Path where server ID will be stored or read from
* `FACTORIO_SCENARIO=` [MOD/]NAME (e.g. `base/wave-defense` will load the wave-defense scenario from the base mod)

```
docker run -d --name factorio \
   -p 34197:34197/udp \
   -v /host/path/saves:/saves \
   -v /host/path/mods:/mods \
   -v /host/path/config:/config \
   -e FACTORIO_SAVE_NAME=rick \
   rfvgyhn/factorio
```

### Configuration

You may specify the following files by mounting the `/config` volume:

* `server-settings.json`
* `map-gen-settings.json`
* `map-settings.json`
* `server-whitelist.json`
* `server-banlist.json`

Note that since [version 0.14.12][3], several of the options that were provided
by environment variables have moved to `server-settings.json`.

The RCON password is randomly generated and stored in `/config/rconpw`

## Docker Images

The `latest` tag will always follow the latest [factorio server][1] release
(including [experimental releases][2]).

The `stable` tag will always follow the latest stable [factorio server][1] release.

Each version will also have its own tag.


[0]: https://www.factorio.com/
[1]: https://www.factorio.com/download-headless/stable
[2]: https://www.factorio.com/download-headless/experimental
[3]: https://forums.factorio.com/viewtopic.php?f=3&t=33591
[4]: https://img.shields.io/docker/stars/rfvgyhn/factorio.svg
[5]: https://img.shields.io/docker/pulls/rfvgyhn/factorio.svg
[6]: https://img.shields.io/docker/image-size/rfvgyhn/factorio/latest
[7]: https://img.shields.io/badge/v-1.1.33-blue
[8]: https://img.shields.io/docker/image-size/rfvgyhn/factorio/stable
[9]: https://img.shields.io/badge/v-1.1.33-blue
[10]: https://img.shields.io/docker/image-size/rfvgyhn/factorio/0.18.46-experimental
[11]: https://img.shields.io/badge/v-0.18.46-blue