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


### Images

The images are deployed via GitHub Actions to the GitHub Container Registry
(GHCR):
- [`trixie-msmtp`][image]
  - Built from `main` branch: [`../.github/workflows/trixie-msmtp.yml`][build]
- [`trixie-msmtp-dev`][image-dev]
  - Built from pull requests:
    [`../.github/workflows/trixie-msmtp-dev.yml`][build-dev]

[image]: https://github.com/creativecommons/containers/pkgs/container/trixie-msmtp
[build]: ../.github/workflows/trixie.yml
[image-dev]: https://github.com/creativecommons/containers/pkgs/container/trixie-msmtp-dev
[build-dev]: ../.github/workflows/trixie-msmtp-dev.yml


### Parent images

1. [`trixie`](../trixie/), includes documentation on:
   - setup.sh configuration
   - Debian
   - Runit services


## Documentation


### msmtp

- [msmtp - about][msmtp]
  - [msmtp manual in HTML format][msmtp-man]
- [msmtp(1) — msmtp — Debian trixie — Debian Manpages][msmtp-debman]

[msmtp]: https://marlam.de/msmtp/
[msmtp-man]: https://marlam.de/msmtp/msmtp.html
[msmtp-debman]: https://manpages.debian.org/trixie/msmtp/msmtp.1.en.html
