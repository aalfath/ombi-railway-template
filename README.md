# Ombi on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/ombi?utm_medium=integration&utm_source=button&utm_campaign=ombi)

Railway template for [Ombi](https://ombi.io), the self-hosted media request manager for Plex, Emby and Jellyfin users. Your users ask for movies, TV shows and music in Ombi, and Ombi sends approved requests to Sonarr, Radarr or Lidarr.

## What it deploys

- **Ombi v4.53.10** (latest stable release), from LinuxServer.io's image `linuxserver/ombi:v4.53.10-ls277`, pinned by digest in the [`Dockerfile`](Dockerfile). That is the image Ombi's own Docker docs use.
- One service with a public Railway domain on port 3579 and a volume at `/config` that holds Ombi's SQLite databases (`Ombi.db`, `OmbiSettings.db`, `OmbiExternal.db`) and logs.
- Health check: `/api/v1/Status`.

## First login

Ombi's setup wizard is public until an admin exists. So that nobody else can claim your instance, this template creates the admin on the first boot (an s6 service in [`rootfs/`](rootfs/etc/s6-overlay/s6-rc.d/svc-ombi-bootstrap/run)) and sets the application URL to the Railway domain. Sign in with:

- **Username:** the `OMBI_ADMIN_USERNAME` variable (default `admin`)
- **Password:** the generated `OMBI_ADMIN_PASSWORD` variable (Railway service > Variables)

Then open Settings and connect your media server (Plex, Emby or Jellyfin) and Sonarr, Radarr or Lidarr. Change the password from your Ombi profile if you like: the variables are only read on the first boot, while no admin exists.

## Variables

| Variable | Default | Purpose |
|---|---|---|
| `PORT` | `3579` | Port Ombi listens on (fixed by the image); Railway's domain and health check use it |
| `OMBI_ADMIN_USERNAME` | `admin` | Admin user created on first boot |
| `OMBI_ADMIN_PASSWORD` | `${{secret(24)}}` | Admin password created on first boot |

Optional: `TZ` (for example `Europe/Berlin`) for log and schedule times. Email, Discord and other notifications are set in Ombi's UI.

## Updates

Railway notifies everyone who deployed this template when a change is merged to `main` here, and you choose when to apply it. Each update bumps the pinned image; see [`CHANGELOG.md`](CHANGELOG.md) before applying one. Ombi migrates its databases on start, so back up the `/config` volume first (Railway volume backups).

## Run it locally

```sh
docker build -t ombi-railway .
docker run -p 3579:3579 -v ombi-config:/config -e OMBI_ADMIN_PASSWORD=change-me ombi-railway
```

Ombi is licensed under GPL-2.0. This wrapper only adds the first-boot admin setup.
