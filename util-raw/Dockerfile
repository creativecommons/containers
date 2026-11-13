# https://docs.docker.com/engine/reference/builder/

# https://gunicorn.org/guides/docker/
# hadolint ignore=DL3007
FROM ghcr.io/benoitc/gunicorn:latest

# https://docs.docker.com/build/building/best-practices/#apt-get
# 1. Configure apt to avoid optional packages
# 2. Configure debconf to use noninteractive frontend
# 3. Retrieve new lists of packages, distribution upgrade, install new
#    packages, erase downloaded archive files, erase package lists, and update
#    certificate authority certificates
USER root
COPY docker-slim /etc/apt/apt.conf.d/docker-slim
RUN set -o errexit -o nounset \
    && sed --regexp-extended --in-place \
        -e's/^(Templates:.+)$/\1\n# Debconf will select the default answer/' \
        -e's/(default answer)$/\1\nFrontend: noninteractive/' \
        /etc/debconf.conf \
    && apt-get update --quiet \
    && apt-get dist-upgrade --quiet --yes \
    && apt-get install --quiet --yes \
        dumb-init \
    && apt-get clean --quiet \
    && rm --recursive --force /var/lib/apt/lists/*
USER gunicorn

WORKDIR /app
COPY --chown=gunicorn:gunicorn app.py .
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "app:app"]
