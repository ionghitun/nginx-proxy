#!/bin/sh
echo
echo "===== Stopping... ====="
echo

cd scripts || exit
if command -v docker-compose >/dev/null 2>&1; then
    docker-compose down
else
    docker compose down
fi

echo
echo "===== Done! ====="
echo
