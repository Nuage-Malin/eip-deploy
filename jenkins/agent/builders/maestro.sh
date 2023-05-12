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
docker compose --env-file=./env/maestro.env --profile launch build
check_exit_failure "Fail to build"

# Create networks
docker network create users-back:maestro
if [ $? -ne 0 ]; then
    echo "users-back:maestro network already exists"
fi
docker network create chouf:maestro
if [ $? -ne 0 ]; then
    echo "chouf:maestro network already exists"
fi
docker network create maestro:santaclaus
if [ $? -ne 0 ]; then
    echo "maestro:santaclaus network already exists"
fi
docker network create maestro:vault
if [ $? -ne 0 ]; then
    echo "maestro:vault network already exists"
fi

# Run docker images
docker compose --env-file=./env/maestro.env --profile launch up -d
check_exit_failure "Fail to run"