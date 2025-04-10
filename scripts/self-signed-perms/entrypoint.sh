#!/bin/sh

echo "[startup] Fixing existing .local certs..."
find /etc/nginx/certs -type f -name '*.local.crt' -exec chmod 644 {} \;
find /etc/nginx/certs -type f -name '*.local.key' -exec chmod 600 {} \;

echo "[startup] Watching for new .local certs..."
inotifywait -m -e create -e modify --format '%w%f' /etc/nginx/certs |
while read file; do
  if echo "$file" | grep -q '\.local\.crt$'; then
    echo "[watcher] Detected new .local.crt file, setting permissions to 644"
    chmod 644 "$file"
  elif echo "$file" | grep -q '\.local\.key$'; then
    echo "[watcher] Detected new .local.key file, setting permissions to 600"
    chmod 600 "$file"
  fi
done
