#!/bin/sh
echo "*** Rebuild start ***"

cd scripts || exit

# Prompt user for input
echo "Want to update images before rebuild? (y/n) [default: y]: "
read UPDATE_IMAGES
UPDATE_IMAGES=${UPDATE_IMAGES:-y}

# Check user input in a POSIX-compatible way
if [ "$UPDATE_IMAGES" = "y" ] || [ "$UPDATE_IMAGES" = "Y" ]; then
    NGINX_PROXY_VERSION=$(grep -oP '^NGINX_PROXY_VERSION=\K.*' .env)
    ACME_COMPANION_VERSION=$(grep -oP '^ACME_COMPANION_VERSION=\K.*' .env)
    SELF_SIGNED_VERSION=$(grep -oP '^SELF_SIGNED_VERSION=\K.*' .env)

    docker pull "nginxproxy/nginx-proxy:$NGINX_PROXY_VERSION"
    docker pull "nginxproxy/acme-companion:$ACME_COMPANION_VERSION"
    docker pull "sebastienheyd/self-signed-proxy-companion:$SELF_SIGNED_VERSION"
fi

echo "*** Rebuilding application ***"
docker compose -p nginx-proxy build --no-cache
docker compose -p nginx-proxy up -d

echo "*** Rebuild ended ***"
