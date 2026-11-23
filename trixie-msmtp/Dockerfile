# https://docs.docker.com/engine/reference/builder/

# GHCR actions use build_context
# https://github.com/creativecommons/containers/pkgs/container/trixie
# hadolint ignore=DL3006
FROM trixie

# https://docs.docker.com/build/building/best-practices/#apt-get
# - apt and dpkg are configured in parent CC Debian trixie image
# - Retrieve new lists of packages, distribution upgrade, install new
#   packages, erase downloaded archive files, and erase package lists
RUN set -o errexit -o nounset \
    && apt-get update --quiet \
    && apt-get dist-upgrade --quiet --yes \
    && apt-get install --quiet --yes \
        msmtp-mta \
    && apt-get clean --quiet \
    && rm --recursive --force /var/lib/apt/lists/*

# msmtp configuration
COPY --parents conf.d/* /etc/container/

# ⚠️  NOTE:
#    - CMD is ignored. Services must be installed and enabled per runit.
#    - USER must be root so that ENTRYPOINT is run as root.
