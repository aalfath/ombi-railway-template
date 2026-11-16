# Changelog

## Unreleased (2026-11-16)

- README: Deploy on Railway button for the published template (`ombi`). No change to the app or image.

## 4.53.10 (2026-11-16)

- First release: Ombi v4.53.10 (`linuxserver/ombi:v4.53.10-ls277@sha256:617c872fd5a05b1cabbb052c58974cf8dd90d972d18417d28cf137fd7579a17b`).
- SQLite databases and logs on a volume at `/config`.
- The admin is created on first boot from `OMBI_ADMIN_USERNAME` / `OMBI_ADMIN_PASSWORD`, so the public setup wizard is never left open. The application URL is set to the Railway public domain.
