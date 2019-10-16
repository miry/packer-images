#!/usr/bin/env bash

echo -n "Input root user password: "
read -s root_password
echo

echo -n "Input centos user password: "
read -s user_password
echo

cat http/ks.cfg.sample | replace \$USER_KEY "$(cat ~/.ssh/id_*.pub)" | replace \$ROOT_PASSWORD "${root_password}" | replace \$USER_PASSWORD "${user_password}" > http/ks.cfg

packer build -var centos_password="$user_password" -only=qemu image.json
