#!/bin/bash
# Removing taint
kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-

mkdir -p /tmp/.init
mv /root/*.yaml /tmp/.init/

# kubectl create -f /tmp/.init/ingress-controller.yaml
kubectl create -f /tmp/.init/applications.yaml
kubectl create -f /tmp/.init/ingress-resource.yaml
kubectl create -f /tmp/.init/deploy.yaml