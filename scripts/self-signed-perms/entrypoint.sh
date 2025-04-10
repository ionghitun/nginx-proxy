#!/bin/sh

echo "[startup] Fixing existing .local certs..."
find /etc/nginx/certs -type f -name '*.local.crt' -exec chown ${USER_ID}:${GROUP_ID} {} \;
find /etc/nginx/certs -type f -name '*.local.key' -exec chown ${USER_ID}:${GROUP_ID} {} \;

echo "[startup] Watching for new .local certs..."
inotifywait -m -e create -e modify --format '%w%f' /etc/nginx/certs |
while read file; do
  if echo "$file" | grep -q '\.local\.crt$'; then
    echo "[watcher] Detected new .local.crt file, setting ownership to ${USER_ID}:${GROUP_ID}"
    chown ${USER_ID}:${GROUP_ID} "$file"
  elif echo "$file" | grep -q '\.local\.key$'; then
    echo "[watcher] Detected new .local.key file, setting ownership to ${USER_ID}:${GROUP_ID}"
    chown ${USER_ID}:${GROUP_ID} "$file"
  fi
done
