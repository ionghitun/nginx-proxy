#!/bin/sh
echo
echo "===== Starting... ====="
echo

cd scripts || exit
docker compose up -d

echo
echo "===== Done! ====="
echo
