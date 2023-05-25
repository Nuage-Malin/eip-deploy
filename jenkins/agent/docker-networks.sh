#!/usr/bin/env sh

networks=("users-back_mongo" \
          "users-back:maestro" \
          "maestro:santaclaus" \
          "maestro:vault" \
          "santaclaus:bugle" \
          "chouf:maestro" \
          "chouf:bugle" \
          "chouf:santaclaus")

for network in "${networks[@]}"; do
    docker network create $network
done