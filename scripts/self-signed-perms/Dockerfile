FROM alpine:latest

RUN apk add --no-cache inotify-tools bash

COPY self-signed-perms/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Set the entrypoint to run the script
ENTRYPOINT ["/entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]
