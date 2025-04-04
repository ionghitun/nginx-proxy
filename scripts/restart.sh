#!/bin/sh
echo "*** Restarting... ***"

cd scripts || exit

docker compose -p nginx-proxy restart

echo "*** Restarted ***"
