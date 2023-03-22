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

# Create networks
docker network create users-back:maestro
if [ $? -ne 0 ]; then
    echo "users-back:maestro network already exists"
fi
docker network create chouf:maestro
if [ $? -ne 0 ]; then
    echo "chouf:maestro network already exists"
fi