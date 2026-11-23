# CC Apache2/PHP

Creative Commons (CC) Apache2/PHP


## Overview

The goal of the CC Apache2/PHP image is to provide a consistent platform for
application images.

- **Docker `FROM` image:**
  [`ghcr.io/creativecommons/trixie-msmtp:latest`](../trixie-msmtp/)
- **Docker `ENTRYPOINT`:** `["/usr/bin/dumb-init", "/etc/container/setup.sh"]`
- **Docker `CMD`:** _unset, ignored_
- **Notable inclusions:**
  1. `apache2` to serve web pages
  2. `cron` to manage scheduled tasks
  3. `logrotate` to manage Apache2 logs
  4. `php` to support PHP applications
- **Required variables:**
  - `APACHE2_SERVER_ADMIN`
  - `APACHE2_SERVER_NAME`
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
- [`apache2php`][image]
  - Built from `main` branch: [`../.github/workflows/apache2php.yml`][build]
- [`apache2php-dev`][image-dev]
  - Built from pull requests:
    [`../.github/workflows/apache2php-dev.yml`][build-dev]

[image]: https://github.com/creativecommons/containers/pkgs/container/apache2php
[build]: ../.github/workflows/trixi.yml
[image-dev]: https://github.com/creativecommons/containers/pkgs/container/apache2php-dev
[build-dev]: ../.github/workflows/apache2php-dev.yml


### Parent images

1. [`trixie`](../trixie/), includes documentation on:
   - setup.sh configuration
   - Debian
   - Runit services
2. [`trixie-msmtp`](../trixie-msmtp/), includes documentation on:
   - msmtp


## Documentation


### Apache2

- [Custom Log Formats - mod_log_config - Apache HTTP Server Version
  2.4][custom-log]
- [mod_remoteip - Apache HTTP Server Version 2.4][mod-remoteip]
- [TLS Configurator](https://configurator.tlsref.org/) (not used by this image
  since it doesn't handle TLS, but it is a very helpful reference)

[custom-log]: https://httpd.apache.org/docs/current/mod/mod_log_config.html#formats
[mod-remoteip]: https://httpd.apache.org/docs/2.4/mod/mod_remoteip.html


### Cron

- [cron(8) — cron — Debian trixie — Debian Manpages][man-cron]

[man-cron]: https://manpages.debian.org/trixie/cron/cron.8.en.html


### Logrotate

- [logrotate(8) — logrotate — Debian trixie — Debian Manpages][man-logrot]

[man-logrot]: https://manpages.debian.org/trixie/logrotate/logrotate.8.en.html


### PHP

- [PHP: Securing Session INI Settings - Manual][securing-session]

[securing-session]: https://www.php.net/manual/en/session.security.ini.php
