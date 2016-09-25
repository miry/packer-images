#!/usr/bin/env bash

set -x

token=$1

yum update -y
#yum install -y openssl-devel readline ncurses gcc net-tools wget curl lsof

curl -Ls https://get.cloud.docker.com/ | sudo -H sh -s ${token}
