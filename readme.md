# Nginx-proxy

Example using docker-compose for https://github.com/nginx-proxy/nginx-proxy
with https://github.com/nginx-proxy/docker-letsencrypt-nginx-proxy-companion.

## Instalation notes

`$ git clone git@github.com:ionghitun/nginx-proxy.git`

`$ docker-compose up -d`

## Dependencies

- docker

## Documentation:

Don't forget to create network: `docker network create nginx-proxy`.

In `conf/custom.conf` you can add any custom configuration for nginx.

Example on how to use on containers:

    services:
        web:
            ...
            ports:
                - 80
            ...
            environment:
                VIRTUAL_HOST: example.com
                VIRTUAL_PORT: 80
                LETSENCRYPT_HOST: example.com
                LETSENCRYPT_EMAIL: mail@example.com
            ...
            networks:
                ...
                - nginx-proxy

You can use multiple domains/subdomains:

    services:
        web:
            ...
            build:
                context: ./
                dockerfile: web/Dockerfile
            ports:
                - 80
            ...
            environment:
                VIRTUAL_HOST: example.com,sub.example.com,example2.com
                VIRTUAL_PORT: 80
                LETSENCRYPT_HOST: example.com,sub.example.com,example2.com
                LETSENCRYPT_EMAIL: mail@example.com
            ...
            networks:
                ...
                - nginx-proxy

In `web/Dockerfile` you can include a conf where you define your servers, wildcards are not yet supported by letsencrypt
companion.

When using in local environment the ssl certificates won't be created and a fallback to http will be created
automatically.

_Happy coding!_
