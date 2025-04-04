#!/bin/sh
echo "*** Starting... ***"

cd scripts || exit

docker compose -p nginx-proxy up -d

echo "*** Started ***"
