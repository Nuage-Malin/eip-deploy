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
docker compose --env-file vault.env build
check_exit_failure "Fail to build"

# Create networks
docker network create maestro:vault
if [ $? -ne 0 ]; then
    echo "maestro:vault network already exists"
fi

# Run docker images
docker compose --env-file vault.env up -d
check_exit_failure "Fail to run"