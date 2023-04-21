## init

This repo contains initial setup files.


### Mac

System bootstrap

```sh
curl https://raw.githubusercontent.com/ChillarAnand/init/main/mac_init.sh | bash
```


### Ubuntu

Server bootstrap

```sh
curl https://raw.githubusercontent.com/ChillarAnand/init/main/ubuntu.sh | bash
```


### Install docker on linux

```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
dockerd-rootless-setuptool.sh install
```


### Docker

Docker bootstrap

```sh
curl https://raw.githubusercontent.com/ChillarAnand/init/main/docker_init.sh | bash
```
