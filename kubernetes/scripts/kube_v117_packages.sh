#!/usr/bin/env bash

set -x
set -euo pipefail

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo setenforce 0 || true

export PACKAGE_VERSION=${CENTOS_KUBE_VERSION:=1.16.2-0}
sudo yum install -y kubeadm-${PACKAGE_VERSION} kubelet-${PACKAGE_VERSION} kubectl-${PACKAGE_VERSION} \
                    kubernetes-cni cri-o cri-tools ipvsadm \
                    ceph-common # To use Rook : Persistent Storage

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system

# https://www.unix.com/man-page/centos/5/modules-load.d/
echo -e "ip_vs\nip_vs_rr\nip_vs_wrr\nip_vs_sh\nnf_conntrack_ipv4" | sudo tee -a /etc/modules-load.d/99-ip_vs.conf

# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/sec-persistent_module_loading
cat <<EOF | sudo tee /etc/sysconfig/modules/ip_vc.modules
#!/bin/sh

#
# Kuberentes Load the ip vs module for load native balancers
#
/sbin/modinfo -F filename ip_vs >/dev/null 2>&1
if [ $? -eq 0 ]
then
  modprobe ip_vs ip_vs_rr ip_vs_wrr ip_vs_sh nf_conntrack_ipv4 >/dev/null 2>&1
fi

EOF

sudo chmod +x /etc/sysconfig/modules/ip_vc.modules

sudo systemctl enable kubelet
sudo systemctl enable docker

# Install kube images
sudo systemctl restart docker

readonly require_version=${KUBE_VERSION:=v1.17.0-alpha.2}
if [ "$require_version" = "" ]; then
  exit 0
fi

readonly version=$(kubeadm version -o short)

if [[ "$version" = "$require_version" ]]; then
  exit 0
fi

sudo wget -q -O $(which kubeadm) https://storage.googleapis.com/kubernetes-release/release/$KUBE_VERSION/bin/linux/amd64/kubeadm
sudo wget -q -O $(which kubectl) https://storage.googleapis.com/kubernetes-release/release/$KUBE_VERSION/bin/linux/amd64/kubectl
sudo wget -q -O $(which kubelet) https://storage.googleapis.com/kubernetes-release/release/$KUBE_VERSION/bin/linux/amd64/kubelet

kubeadm version -o short
kubectl version --client
kubelet --version

sudo kubeadm config images pull --kubernetes-version "$require_version"
