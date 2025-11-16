#!/bin/sh
cd scripts || exit

echo
printf "Do you want to update images before rebuilding? (y/n) [default: y]: "
read UPDATE_IMAGES
UPDATE_IMAGES=${UPDATE_IMAGES:-y}

COMPOSE_PROFILES=$(sed -n 's/^COMPOSE_PROFILES=//p' .env | tr -d '\r' | tr -d '"')

if [ "$UPDATE_IMAGES" = "y" ] || [ "$UPDATE_IMAGES" = "Y" ]; then
    echo
    echo "===== Updating images... ====="
    echo

    NGINX_PROXY_VERSION=$(sed -n 's/^NGINX_PROXY_VERSION=//p' .env | tr -d '\r' | tr -d '"')
    ACME_COMPANION_VERSION=$(sed -n 's/^ACME_COMPANION_VERSION=//p' .env | tr -d '\r' | tr -d '"')
    SELF_SIGNED_VERSION=$(sed -n 's/^SELF_SIGNED_VERSION=//p' .env | tr -d '\r' | tr -d '"')

    docker pull "nginxproxy/nginx-proxy:$NGINX_PROXY_VERSION"

    if [ "$COMPOSE_PROFILES" = "acme" ]; then
        docker pull "nginxproxy/acme-companion:$ACME_COMPANION_VERSION"
    elif [ "$COMPOSE_PROFILES" = "self-signed" ]; then
        docker pull "sebastienheyd/self-signed-proxy-companion:$SELF_SIGNED_VERSION"
        docker pull alpine:latest
    fi
fi

echo
echo "===== Building and starting containers... ====="
echo

if command -v docker-compose >/dev/null 2>&1; then
    docker-compose build --no-cache
    docker-compose up -d
else
    docker compose build --no-cache
    docker compose up -d
fi

echo
echo "===== Done! ====="
echo
