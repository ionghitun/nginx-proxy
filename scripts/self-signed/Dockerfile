ARG SELF_SIGNED_VERSION
FROM sebastienheyd/self-signed-proxy-companion:${SELF_SIGNED_VERSION}

RUN apk add --no-cache inotify-tools

COPY ./self-signed/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
