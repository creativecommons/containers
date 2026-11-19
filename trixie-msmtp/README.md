# CC Debian trixie with msmtp

Creative Commons (CC) Debian 13 (trixie) with msmtp Docker image


## Overview

The goal of the CC Debian trixie with msmtp image is to provide a consistent
platform for application images.

- **Docker `FROM` image:**
  [`ghcr.io/creativecommons/trixie:latest`](../trixie/)
- **Docker `ENTRYPOINT`:** `["/usr/bin/dumb-init", "/etc/container/setup.sh"]`
- **Docker `CMD`:** _unset, ignored_
- **Notable inclusions:**
  1. `msmtp` to allow sending emails
- **Required variables:**
  - `MSMTP_FROM_EMAIL`
  - `MSMTP_MAILNAME`
  - `MSMTP_ROOT_EMAIL`
  - `MSMTP_SERVER_HOST`
  - `MSMTP_SERVER_PASSWORD`
  - `MSMTP_SERVER_USER`

> [!NOTE]
> `CMD` is ignored by this image. Instead service(s) must be installed and
> enabled per runit.

[docker-trixie]: https://hub.docker.com/_/debian


## Configuration

See [`../trixie/README.md`](../trixie/README.md).


### msmtp

- [`conf.d/msmtp.sh`](conf.d/msmtp.sh)


### Services

See [`../trixie/README.md`](../trixie/README.md).


## Deployment

The image is deployed via GitHub Actions to the GitHub Container Registry
(GHCR). See the workflows for details:
- `main` branch: [`../.github/workflows/trixie-msmtp.yml`][build]
- all other branches: [`../.github/workflows/trixie-msmtp-dev.yml`][build-dev]

[build]: ../.github/workflows/trixi-msmtp.yml
[build]: ../.github/workflows/trixie-msmtp-dev.yml


## Extending

See [`../trixie/README.md`](../trixie/README.md).


### Application services

See [`../trixie/README.md`](../trixie/README.md).


## Additional references

See [`../trixie/README.md`](../trixie/README.md).


### msmtp

- [msmtp - about][msmtp]
  - [msmtp manual in HTML format][msmtp-man]
- [msmtp(1) — msmtp — Debian trixie — Debian Manpages][msmtp-debman]


[msmtp]: https://marlam.de/msmtp/
[msmtp-man]: https://marlam.de/msmtp/msmtp.html
[msmtp-debman]: https://manpages.debian.org/trixie/msmtp/msmtp.1.en.html
