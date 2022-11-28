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
if [ $1 == "production" ]
then
    USERS_BACK_PORT=$PRODUCTION_USERS_BACK docker compose up -d
else
    USERS_BACK_PORT=$DEVELOPMENT_USERS_BACK docker compose up -d
fi
check_exit_failure "Fail to run"

# Connect to networks
docker network connect users-back:maestro users-back