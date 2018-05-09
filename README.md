# pmacct package for LEDE/OpenWRT - ramips mt7620

## Usage

```
Dockerized LEDE/OpenWRT compile environment.

Usage: $1 COMMAND [OPTIONS]
  COMMAND is one of:
    build-docker-image- build docker image
    shell             - start shell in docker container

  OPTIONS:
  -o WORK_DIR         - working directory
  --skip-sudo         - call docker directly, without sudo

Example:
  ./builder.sh shell
```

First build the docker image with `./builder.sh build-docker-image`,
then put your source files in the `workdir/` directory and start the acutal
container with the LEDE build environment with `./builder.sh shell`.

The last command will open a shell in the docker container with local the
`workdir/` mounted to the directory `/workdir` in the container. Since
workdir is externally mounted, it's contents will survive container restarts.
