#!/bin/bash 

set -ex

# The script to run a Kubernetes worker using kubeadm.

TOKEN=$1
MASTER=$2

if [[ ${UID} -ne 0 ]]; then
  echo "You must be root to run $0"
  exit 1
fi 

apt-get update -qq 
apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update

apt-get install -y docker-engine kubeadm kubelet kubeadm kubectl kubernetes-cni

if [[ -n "${TOKEN}" && -n "${MASTER}" ]]; then
  kubeadm join --token ${TOKEN} ${MASTER}
fi 
