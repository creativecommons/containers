# CC Debian trixie

Creative Commons (CC) Debian 13 (trixie) with runit Docker image.


## Overview

The goal of the CC Debian trixie image is to provide a consistent platform
for application images.

- **Docker `FROM` image:** [`debian:trixie-slim`][docker-trixie]
- **Docker `ENTRYPOINT`:** `["/usr/bin/dumb-init", "/etc/container/setup.sh"]`
- **Docker `CMD`:** _unset, ignored_
- **Notable inclusions:**
  1. `dumb-init` to manage processes (init, PID 1)
  2. `locales` set to `en_US.utf8` except for `LC_TIME` set to `en_DK` for
     better (ISO 8601) datetime formatting
  2. `runit` to manage services
  3. `socklog` to send syslog messages to init stdout (Docker log)
- **Required variables:**
  - _none_

> [!NOTE]
> `CMD` is ignored by this image. Instead service(s) must be installed and
> enabled per runit.

[docker-trixie]: https://hub.docker.com/_/debian


### Images

The images are deployed via GitHub Actions to the GitHub Container Registry
(GHCR):
- [`trixie`][image]
  - Built from `main` branch: [`../.github/workflows/trixie.yml`][build]
- [`trixie-dev`][image-dev]
  - Built from pull requests:
    [`../.github/workflows/trixie-dev.yml`][build-dev]

[image]: https://github.com/creativecommons/containers/pkgs/container/trixie
[build]: ../.github/workflows/trixie.yml
[image-dev]: https://github.com/creativecommons/containers/pkgs/container/trixie-dev
[build-dev]: ../.github/workflows/trixie-dev.yml


## setup.sh configuration

When the image starts up, the `/etc/container/setup.sh`
([`setup.sh`](setup.sh)) script does three important things:
1. Provides helper functions and variables
2. Sources configurations scripts in `/etc/container/conf.d/` that end with
   `.sh`
3. Execs Runit's `runsvdir` to begin service management

Configuration scripts in `/etc/container/conf.d/` _must_ be writtin for Dash
(the Debian Almquist shell).  Using a `#!/bin/sh` shebang will ensure
Shellcheck issues warnings about syntax that is not compliant with POSIX.
- [dash(1) — dash — Debian buster — Debian Manpages][man-dash]

[man-dash]: https://manpages.debian.org/buster/dash/dash.1.en.html


## Documentation


### Debian

- [debian - Official Image | Docker Hub][docker-trixie]
- [Release Notes for Debian 13 (trixie) — release-notes
  documentation][trixie-release]

[docker-trixie]: https://hub.docker.com/_/debian
[trixie-release]: https://www.debian.org/releases/trixie/release-notes/index.en.html


### Runit services

Runit service related documentation:
- [How do I create a new service directory - runit - frequently asked
  questions][runit-create]
- [Service Directories - Services and Daemons - runit - The Void Linux
  Handbook][void-services]
- [runsv(8) — runit — Debian trixie — Debian Manpages][man-runsv]

[runit-create]: https://smarden.org/runit/faq#create
[void-services]: https://docs.voidlinux.org/config/services/index.html#service-directories
[man-runsv]: https://manpages.debian.org/trixie/runit/runsv.8.en.html
