# Nginx-Proxy Stack

This project provides a Docker Compose setup for [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy) with optional support for [acme-companion](https://github.com/nginx-proxy/acme-companion) and [self-signed-proxy-companion](https://github.com/sebastienheyd/docker-self-signed-proxy-companion). It enables easy development of multiple
projects locally with virtual hosts using Docker and is also ready for live deployment.

## Prerequisites

- Docker Engine & Docker Compose
- Git
- Linux or Windows WSL2

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ionghitun/nginx-proxy.git
   cd nginx-proxy
   ```
2. **Copy and configure environment variables**
   ```bash
   cp scripts/.env.example scripts/.env
   export USER_ID=$(id -u)
   export GROUP_ID=$(id -g)
   # Edit other variables in scripts/.env as needed
   ```
3. **Create global nginx-proxy network**
   ```bash
   docker network create nginx-proxy
   ```
4. **Start the project**
   ```bash
   sh scripts/start.sh
   ```

## Configuration

**Conf Configuration**: Edit `conf/custom.conf`

### Compose Profiles

- acme: Enables automatic SSL certificate generation using Let's Encrypt via acme-companion.
- self-signed: Enables self-signed SSL certificate generation for local development via self-signed-proxy-companion.
- leave COMPOSE_PROFILES empty to run only nginx-proxy without SSL support.

### Example: Using Virtual Hosts in Containers

To enable virtual hosting for your containers, set port, environment and network:

```yaml
services:
    ...
    nginx:
        ...
        ports:
            - 80
            - ...
        environment:
            VIRTUAL_HOST: example.com
            VIRTUAL_PORT: 80
            LETSENCRYPT_HOST: example.com
            LETSENCRYPT_EMAIL: mail@example.com
            ...
        networks:
            - nginx-proxy
            - ...
```

For multiple domains or subdomains:

```yaml
VIRTUAL_HOST: example.com,sub.example.com,example2.com
VIRTUAL_PORT: 80
LETSENCRYPT_HOST: example.com,sub.example.com,example2.com
LETSENCRYPT_EMAIL: mail@example.com
```

When using the self-signed companion, add extra the `SELF_SIGNED_HOST` environment variable, the `labels` is also important, otherwise will not work:

```yaml
environment:
    SELF_SIGNED_HOST: example.com
labels:
    - com.github.nginx-proxy.nginx-proxy.ssl_verify_client=off
```

### Trusting Self-Signed Certificates

To avoid browser warnings like "Your connection is not private" when using self-signed certificates, refer to
the [self-signed-proxy-companion](https://github.com/sebastienheyd/docker-self-signed-proxy-companion) documentation for instructions on trusting these certificates in your local
environment.

### Using Certificates with Vite Server

To use SSL certificates in applications like Vite, mount the certs directory as a read-only volume in your application container:
To have permissions to use, hosts must end in `.local`

```yaml
volumes:
    - /path/to/nginx-proxy/certs:/path/in/container/certs:ro
```

## Available scripts

```bash
./scripts/start.sh    # Start the containers
./scripts/down.sh     # Stop the containers
./scripts/build.sh    # Build or rebuild the containers
./scripts/restart.sh  # Restart the containers
```

## Troubleshooting

- **Permission Issues**: Ensure `USER_ID` and `GROUP_ID` in `scripts/.env` match your host user IDs.
- **Docker Issues**: For older versions you might want to remove `COMPOSE_BAKE` from `.env`.
- **Docker Compose Issues**: Please update and ensure you can use `docker compose`, not old version `docker-compose`

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please open issues or submit pull requests following the repository guidelines.

_Happy Coding_
