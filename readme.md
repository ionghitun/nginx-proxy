# Nginx-proxy

Example using docker-compose for https://github.com/nginx-proxy/nginx-proxy with https://github.com/nginx-proxy/docker-letsencrypt-nginx-proxy-companion.

## Instalation notes

`$ git clone git@github.com:ionghitun/nginx-proxy.git`

`$ docker-compose up -d`

## Dependencies

- docker

## Documentation:

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
                
In `web/Dockerfile` you can include a conf where you define your servers`

_Happy coding!_
