#!/usr/bin/env bash

set -euo pipefail

CENTOS_VERSION=${CENTOS_VERSION:-1908}

echo -n "Input root user password: "
read -s root_password
echo

echo -n "Input centos user password: "
read -s user_password
echo

ssh_pub=$(cat ~/.ssh/id_*.pub | head -n 1)

cat http/ks.cfg.sample | sed "s/\$USER_KEY/${ssh_pub}/g; s/\$ROOT_PASSWORD/${root_password}/g; s/\$CENTOS_PASSWORD/${user_password}/g" > http/ks.cfg

packer build -var version="${CENTOS_VERSION}" -var centos_password="$user_password" -only=qemu image.json
