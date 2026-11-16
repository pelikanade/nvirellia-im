# nvirellia.im

Personal profile sheet and live status/resource dashboard for `nvirellia.im`, written in Go with zero external dependencies.

## Docker Compose Deployment

1. (Optional) Create `.env` from `.env.example` to configure upstream feeds:

   ```bash
   cp .env.example .env
   ```

   Without any upstream variables set, the site runs and serves the Profile tab.

2. Build and start the service:

   ```bash
   docker compose up -d --build
   ```

   By default, `compose.yaml` binds `127.0.0.1:8080` on the host (override with `PORT` in `.env`) and maps `host.docker.internal` to the host gateway.

3. Verify health:

   ```bash
   curl -fsS http://127.0.0.1:8080/healthz
   ```

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `PORT` | `8080` | Host port bound on `127.0.0.1` in `compose.yaml` |
| `LISTEN_ADDR` | `:8080` | In-container listen address |
| `FEED_TTL` | `30s` | Cache duration for Magpie, Gatus, and Prometheus snapshots |
| `MAGPIE_URL` | _(unset)_ | Base URL of the Magpie instance (omits Resources tab if unset) |
| `MAGPIE_WEB_KEY` | _(unset)_ | Required when `MAGPIE_URL` is set |
| `GATUS_URL` | _(unset)_ | Base URL of the Gatus API for uptime checks |
| `PROMETHEUS_URL` | _(unset)_ | Base URL of the Prometheus HTTP API for node probes |
| `PROMETHEUS_JOB` | `node` | Scrape job name for `node_exporter` targets |
| `FLAKE_REPO` | `pelikanade/flake` | GitHub `owner/repo` whose `main` head is compared against `nixos_flake_info` |
| `GITHUB_API_URL` | `https://api.github.com` | GitHub API base URL |
