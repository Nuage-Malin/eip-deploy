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

# Run docker images
docker compose --env-file=./env/maestro.env --profile launch up -d
check_exit_failure "Fail to run"