#!/usr/bin/env bash

check_exit_failure()
{
    if [ $? -ne 0 ]
    then
        echo "$1" 1>&2
        exit 1
    fi
}

# Create Kubernetes cluster
kind create cluster --name nuage-malin --config=/app/kubernetes/cluster.yml
check_exit_failure "Fail to create cluster"

# Connect docker networks
docker network connect eip-deploy_kubernetes nuage-malin-control-plane
check_exit_failure "Fail to connect kubernetes network to the cluster"
echo "Kubernetes network connected to the cluster"
docker network connect eip-deploy_registry nuage-malin-control-plane
check_exit_failure "Fail to connect registry network to the cluster"
echo "Registry network connected to the cluster"

# Set Kubernetes config
kubectl config set clusters.kind-nuage-malin.server https://nuage-malin-control-plane:6443
check_exit_failure "Fail to set cluster server URL"