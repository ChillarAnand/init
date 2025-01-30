## init

This repo contains initial setup files.


### Mac

System bootstrap

```sh
curl https://raw.githubusercontent.com/ChillarAnand/init/main/mac.sh | bash
```


### Ubuntu

Server bootstrap

```sh
curl https://raw.githubusercontent.com/ChillarAnand/init/main/ubuntu.sh | bash
```

Without sudo

```sh
curl https://raw.githubusercontent.com/ChillarAnand/init/main/ubuntu_nosudo.sh | bash
```


Custom zshrc

```
wget https://raw.githubusercontent.com/ChillarAnand/init/main/zshrc.sh
mv "$HOME/.zshrc" "$HOME/.zshrc.bkp"
ln -s zshrc.sh "$HOME/.zshrc"
```


### Install docker on linux

```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo sh -eux <<EOF
apt-get install -y uidmap
EOF
dockerd-rootless-setuptool.sh install
```


### Docker

Docker bootstrap

```sh
curl https://raw.githubusercontent.com/ChillarAnand/init/main/docker_init.sh | bash
```
