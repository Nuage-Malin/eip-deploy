#!/usr/bin/env sh

networks=("users-back_mongo" \
          "users-back:maestro" \
          "maestro:santaclaus" \
          "maestro:vault" \
          "maestro:bugle" \
          "santaclaus:bugle" \
          "chouf:maestro" \
          "chouf:bugle" \
          "chouf:santaclaus")

for network in "${networks[@]}"; do
    docker network create $network
done