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