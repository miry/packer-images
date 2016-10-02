#!/usr/bin/env bash

echo -n "Input root user password: "
read -s root_password
echo

echo -n "Input centos user password: "
read -s user_password
echo

cat http/ks.cfg.sample | replace \$USER_KEY "$(cat ~/.ssh/id_rsa.pub)" | replace \$ROOT_PASSWORD "${root_password}" | replace \$USER_PASSWORD "${user_password}" > http/ks.cfg

fusion_app_path="/Applications/VMware Fusion.app"
if [ -d $HOME/Applications/VMware\ Fusion.app ]
then
  fusion_app_path="$HOME/Applications/VMware Fusion.app"
fi

packer build -var centos_password="$user_password" -var fusion_app_path=${fusion_app_path} centos7.json
