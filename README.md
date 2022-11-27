# Nginx-proxy

Docker-compose for https://github.com/nginx-proxy/nginx-proxy with https://github.com/nginx-proxy/acme-companion.

## Introduction

This is a wrapper for nginx proxy and acme companion so anyone can easily develop multiple projects locally with vhosts using docker, but also live ready.

### Installation notes

- Clone project
- Create global nginx-proxy network: `docker network create nginx-proxy`
- Build container using `docker-compose up -d`

### Documentation:

- In `conf/custom.conf` you can add any custom configuration for nginx.

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

- In `web/Dockerfile` you can include a conf where you define your servers, wildcards are not yet supported by acme companion.
- When using in local environment the ssl certificates won't be created and a fallback to http will be created automatically.

_Happy coding!_
