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
docker compose --profile launch --env-file santaclaus.env build
check_exit_failure "Fail to build"

# Create networks
docker network create maestro:santaclaus
if [ $? -ne 0 ]; then
    echo "maestro:santaclaus network already exists"
fi

# Run docker images
docker compose --profile launch --env-file santaclaus.env up -d
check_exit_failure "Fail to run"