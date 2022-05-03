#!/usr/bin/env bash

check_exit_failure()
{
    if [ $? -ne 0 ]
    then
        echo "$1" 1>&2
        exit 1
    fi
}

kind create cluster --name nuage-malin --config=/app/kubernetes/cluster.yml
check_exit_failure "Fail to create cluster"

docker network connect kind `docker ps --format "table {{.Names}}" | grep eip-deploy_jenkins`
check_exit_failure "Fail to connect kind network"
echo "Kind network connected to Jenkins"

kubectl config set clusters.kind-nuage-malin.server https://nuage-malin-control-plane:6443
check_exit_failure "Fail to set cluster server URL"