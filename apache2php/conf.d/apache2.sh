#!/bin/sh
# Comptabile with Dash (the Debian Almquist shell)
#
# This file is sourced by /etc/container/setup.sh
# (It shouldn't be executed directly)
_APP='apache2'
_SECURITY_CONF=/etc/apache2/conf-available/security.conf

_append() {
    echo "${@}" >> "${_SECURITY_CONF}"
}

print_bold 'Begin configuration'

_REQ_VARS='
    APACHE2_SERVER_NAME
    APACHE2_SERVER_ADMIN
'
require_vars
unset _REQ_VARS

print_msg 'Limit information exposure (ServerTokens, ServerSignature)'
print_msg 'Forbid access to version control directories'
sed --regexp-extended \
    -e's|^(ServerTokens) OS|\1 Minor|' \
    -e's|^#(ServerSignature Off)|\1|' \
    -e's|^(ServerSignature On)|#\1|' \
    -e's|^#(RedirectMatch 404 /\\.git)|\1|' \
    -e's|^#(RedirectMatch 404 /\\.svn)|\1|' \
    --in-place "${_SECURITY_CONF}"

print_msg 'Forbid access to macOS-specific directories and files'
print_msg 'Prevent MIME type sniffing (X-Content-Type-Options)'
print_msg 'Prevent embedding (X-Frame-Options)'
_append '
#
# Forbid access to macOS-specific directories and files
RedirectMatch 404 .DS_Store
RedirectMatch 404 __MACOSX

#
# Prevent embedding
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Content-Type-Options
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Frame-Options
Header set X-Content-Type-Options: nosniff;
Header set X-Frame-Options deny;'

print_bold 'End configuration  '
unset _APP
