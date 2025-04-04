#!/bin/sh
echo "*** Starting... ***"

cd scripts || exit

docker compose -p nginx-proxy down

echo "*** Started ***"
