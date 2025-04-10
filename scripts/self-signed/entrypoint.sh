#!/bin/sh

echo "[startup] Fixing existing .local certs..."
find /etc/nginx/certs -type f \( -name "*.local.crt" -o -name "*.local.key" \) -exec chmod 644 {} \;

# Start watcher in background
inotifywait -m -e create -e modify /etc/nginx/certs |
while read dir action file; do
  case "$file" in
    *.local.crt|*.local.key)
      echo "[watcher] Detected $file — applying chmod 644"
      chmod 644 "/etc/nginx/certs/$file"
      ;;
  esac
done &

# 🔁 Now exec the original entrypoint (inherits CMD from image)
exec "$@"
