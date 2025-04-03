#!/bin/sh
echo "*** Starting... ***"

cd scripts || exit

STACK_NAME=$(grep -oP '^STACK_NAME=\K.*' .env)

docker compose -p "$STACK_NAME" down

echo "*** Started ***"
