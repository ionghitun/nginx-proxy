# Nginx-proxy

Docker-compose for https://github.com/nginx-proxy/nginx-proxy with https://github.com/nginx-proxy/acme-companion.

## Introduction

This is a wrapper for nginx proxy and acme companion so anyone can easily develop multiple projects locally with vhosts
using docker, but also live ready.

### Installation notes

- Clone project
- copy `scripts/.env.example` to `scripts/.env` and use `id -u <user>` and `id -g <user>` to populate some of the fields.
- change other env variables to your needs
- Create global `nginx-proxy` network: `docker network create nginx-proxy`
- run `sh scripts/start.sh` to start the project
- run `sh scripts/stop.sh` to stop the project
- run `sh scripts/build.sh` to build or rebuild the project
- run `sh scripts/restart.sh` to restart containers

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

When using self-signed companion you need to add `SELF_SIGNED_HOST: "example.com"` environment variable as well

- In `web/Dockerfile` you can include a conf where you define your servers, wildcards are not yet supported by acme
  companion.
- Self-signed companion should be used only on a local environment.
- To use self-signed companion change `COMPOSE_PROFILES` to `self-signed` in .env

## Trust self-signed certificates

To avoid the alert "your connection is not private" please check self-signed repo: https://github.com/sebastienheyd/docker-self-signed-proxy-companion

## Use certificates with vite server

In order to use certification in an application you need to change ownership to `<user>:<group>` for folder `certs` after certificates generation and map certs as read only volume
where you want to use certs.

_Happy coding!_
