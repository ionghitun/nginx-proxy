#!/bin/sh
echo
echo "===== Stopping... ====="
echo

cd scripts || exit
docker compose down

echo
echo "===== Done! ====="
echo
