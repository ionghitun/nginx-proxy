ARG SELF_SIGNED_VERSION
FROM sebastienheyd/self-signed-proxy-companion:${SELF_SIGNED_VERSION}

RUN apk add --no-cache inotify-tools

RUN chmod +x /app/entrypoint.sh

COPY ./self-signed/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
