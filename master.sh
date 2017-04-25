#!/bin/sh 

# This script installs a master using kubeadm.

if [[ $UID -ne 0 ]]; then
   echo "$0 must be run as root."
   exit 1
fi

apt-get update -qq && apt-get install -y apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update -qq

# Install docker.
apt-get install -y docker-engine
apt-get install -y kubelet kubeadm kubectl kubernetes-cni

kubeadm init
