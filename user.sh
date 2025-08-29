#!/bin/bash

apt-get update -y
apt-get install docker.io -y

usermod -aG docker $USER
systemctl restart docker
usermod -aG docker jenkins
systemctl restart jenkins
# echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPRaIgwgBoLPDR9g+FXRTFGzCGausCblhl12r92FDN/C dev-vin@dev-vin-HP-Pavilion" > terraform-key-enc.pub
