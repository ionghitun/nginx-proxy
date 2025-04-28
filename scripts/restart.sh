#!/bin/sh
echo
echo "===== Restarting... ====="
echo

cd scripts || exit
if command -v docker-compose >/dev/null 2>&1; then
    docker-compose restart
else
    docker compose restart
fi

echo
echo "===== Done! ====="
echo
