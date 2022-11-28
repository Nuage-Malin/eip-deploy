#!/usr/bin/env sh

check_exit_failure()
{
    if [ $? -ne 0 ]
    then
        echo "$1" 1>&2
        exit 1
    fi
}

# Build docker images
docker compose build
check_exit_failure "Fail to build"

# Run docker images
docker compose up -d
check_exit_failure "Fail to run"

# Connect to networks
docker network create users-back:maestro
docker network connect users-back:maestro maestro