# https://docs.docker.com/engine/reference/builder/

# GHCR actions use build_context
# https://github.com/creativecommons/containers/pkgs/container/trixie-msmtp
# hadolint ignore=DL3006
FROM trixie-msmtp

# PHP version
# NOTE occurrences of "NOTE: PHP version", below, where a specific PHP version
# is required (based on version supported by installed Debian version)
ARG PHP_VER=8.4

# https://docs.docker.com/build/building/best-practices/#apt-get
# - apt and dpkg are configured in parent CC Debian trixie image
# - Retrieve new lists of packages, distribution upgrade, install new
#   packages, erase downloaded archive files, erase package lists
RUN set -o errexit -o nounset \
    && apt-get update --quiet \
    && apt-get dist-upgrade --quiet --yes \
    && apt-get install --quiet --yes \
        apache2 \
        apache2-utils \
        cron \
        logrotate \
        libapache2-mod-php \
        php \
        php-common \
    && apt-get clean --quiet \
    && rm --recursive --force /var/lib/apt/lists/*

# Configuration scripts
COPY --parents cloudflare-ips-v*.txt conf.d/* /etc/container/

# Add Apache2 configurations
COPY apache2-000-default.conf /etc/apache2/sites-available/000-default.conf
COPY apache2-servervars.conf /etc/apache2/conf-available/servervars.conf

# Add Apache2 error documents
COPY --parents error /usr/local/share/apache2/

# Add PHP configuration - NOTE: PHP version
COPY php-session-security.ini \
    /etc/php/${PHP_VER}/mods-available/session-security.ini

# Enable Apache configurations and modules - NOTE: PHP version
RUN set -o errexit -o nounset \
    && a2enconf --quiet servervars \
    && a2enmod --quiet env \
    && a2enmod --quiet headers \
    && a2enmod --quiet php${PHP_VER} \
    && phpenmod session-security

COPY phpinfo.php /var/www/html/index.php
RUN set -o errexit -o nounset \
    && mv /var/www/html/index.html /var/www/html/debian_default.html

# Create Apache2 service
COPY --chmod=0555 apache2-run /etc/sv/apache2/run
RUN set -o errexit -o nounset \
    && mkdir --parents /etc/sv/apache2/log \
    && ln -s /etc/sv/socklog-unix/log/run /etc/sv/apache2/log/run \
    && update-service --add apache2

# Create Cron service
COPY --chmod=0555 cron-run /etc/sv/cron/run
RUN set -o errexit -o nounset \
    && mkdir --parents /etc/sv/cron/log \
    && ln -s /etc/sv/socklog-unix/log/run /etc/sv/cron/log/run \
    && update-service --add cron

# Expose port for Apache
EXPOSE 80

WORKDIR /var/www

# ⚠️  NOTE:
#    - CMD is ignored. Services must be installed and enabled per runit.
#    - USER must be root so that ENTRYPOINT is run as root.
