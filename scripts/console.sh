#!/bin/sh
cd scripts || exit
STACK_NAME=$(grep -oP '^STACK_NAME=\K.*' .env)

docker exec -it "${STACK_NAME}-nginx-proxy" bash
