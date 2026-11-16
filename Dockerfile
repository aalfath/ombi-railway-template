# Ombi v4.53.10 (latest stable release), packaged by LinuxServer.io,
# the image Ombi's own Docker docs use. Pinned by tag and digest.
FROM linuxserver/ombi:v4.53.10-ls277@sha256:617c872fd5a05b1cabbb052c58974cf8dd90d972d18417d28cf137fd7579a17b

# s6 service that creates the admin on first boot (see the script for details)
COPY rootfs/ /

# Ombi always listens on 3579; data (SQLite databases, logs) lives in /config
ENV OMBI_ADMIN_USERNAME=admin
EXPOSE 3579
