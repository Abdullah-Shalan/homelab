# Homelab

Infrastructure-as-Code for my self-hosted services running on Proxmox.

Each service lives in its own directory and contains everything required to deploy, configure, and maintain it.

## Repository Structure

Each service directory may contain:

- `docker-compose.yml`
- `.env.example`
- Service-specific documentation

## Goals

- Version control all self-hosted services
- Keep deployments reproducible
- Document infrastructure decisions
- Track configuration changes over time

## Services

| Service | Purpose |
|---------|---------|
| media-stack | Jellyfin and the *Arr stack |
| uptime-kuma | Service and infrastructure monitoring |
| cloudflared | Cloudflare Tunnel |
| ... | Future services |

## Usage

All containers connect to a shared external Docker bridge network named `tunnel`.

Create it once before deploying any services:

```bash
docker network create tunnel
```

Verify it exists:

```bash
docker network ls
```

You should see:

```text
NETWORK ID     NAME      DRIVER    SCOPE
xxxxxxxxxxxx   tunnel    bridge    local
```

Each service's `docker-compose.yml` references this network as an external network:

```yaml
networks:
  tunnel:
    external: true
```

Each service is deployed independently.

```bash
cd <service>
docker compose up -d
```

## Notes

- Secrets are excluded from version control.
- Each service should include its own documentation if additional setup is required.
- The repository is intended to evolve as the homelab grows.