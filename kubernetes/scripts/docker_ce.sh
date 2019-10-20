#!/usr/bin/env bash

set -euo pipefail

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum list docker-ce --showduplicates | sort -r
sudo yum install -y docker-ce docker-ce-cli containerd.io

# https://kubernetes.io/docs/setup/cri/
sudo mkdir /etc/docker
cat  <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF
sudo mkdir -p /etc/systemd/system/docker.service.d

sync
