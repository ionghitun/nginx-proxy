#!/bin/sh
cd scripts || exit

echo "Want to update images before rebuilding? (y/n) [default: y]: "
read UPDATE_IMAGES
UPDATE_IMAGES=${UPDATE_IMAGES:-y}

COMPOSE_PROFILES=$(grep -oP '^COMPOSE_PROFILES=\K.*' .env)

if [ "$UPDATE_IMAGES" = "y" ] || [ "$UPDATE_IMAGES" = "Y" ]; then
    echo
    echo "===== Updating image... ====="
    echo

    NGINX_PROXY_VERSION=$(grep -oP '^NGINX_PROXY_VERSION=\K.*' .env)
    ACME_COMPANION_VERSION=$(grep -oP '^ACME_COMPANION_VERSION=\K.*' .env)
    SELF_SIGNED_VERSION=$(grep -oP '^SELF_SIGNED_VERSION=\K.*' .env)

    docker pull "nginxproxy/nginx-proxy:$NGINX_PROXY_VERSION"

    if [ "$COMPOSE_PROFILES" = "acme" ]; then
        docker pull "nginxproxy/acme-companion:$ACME_COMPANION_VERSION"
    elif [ "$COMPOSE_PROFILES" = "self-signed" ]; then
        docker pull "sebastienheyd/self-signed-proxy-companion:$SELF_SIGNED_VERSION"
        docker pull alpine:latest
    fi
fi

echo
echo "===== Building and starting container... ====="
echo

docker compose build --no-cache
docker compose up -d

echo
echo "===== Done! ====="
echo
