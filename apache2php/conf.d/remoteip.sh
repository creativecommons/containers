#!/bin/sh
# Comptabile with Dash (the Debian Almquist shell)
#
# This file is sourced by /etc/container/setup.sh
# (It shouldn't be executed directly)
_APP='remoteip'
_REMOTEIP_CONF=/etc/apache2/conf-available/remoteip.conf

_append() {
    echo "${@}" >> "${_REMOTEIP_CONF}"
}

print_bold 'Begin configuration'

if [ -n "${RAILWAY_SERVICE_NAME:-}" ]
then
    # Production (Railway)
    _PREFIX=''
    _NOTE=''
else
    # Development (Docker Compose)
    _PREFIX='#-'
    _NOTE="[dev disabled] "
fi

_append "# https://httpd.apache.org/docs/current/mod/mod_log_config.html#formats
LogFormat \"%{%F %T}t.%{msec_frac}t %a %u %>s \\\"%r\\\" \\\"%{Location}o\\\" \
%O \\\"%{Referer}i\\\" \\\"%{User-Agent}i\\\"\" remoteipcustom\
"
_append

if [ -n "${_PREFIX}" ]
then
    _append '# Production configuration disabled in development'
fi
print_msg "${_NOTE}Configure Railway (RemoteIPInternalProxy)${E0}"
_append "\
${_PREFIX}# Railway
${_PREFIX}RemoteIPInternalProxy 100.64.0.0/10\
"

print_msg \
    "${_NOTE}Configure Cloudflare (RemoteIPHeader, RemoteIPTrustedProxy)${E0}"
_append "${_PREFIX}
${_PREFIX}# Cloudflare
${_PREFIX}# Restoring original visitor IPs · Cloudflare Support docs
${_PREFIX}# https://developers.cloudflare.com/support/troubleshooting/\
restoring-visitor-ips/restoring-original-visitor-ips/
${_PREFIX}# mod_remoteip - Apache HTTP Server Version 2.4
${_PREFIX}# https://httpd.apache.org/docs/current/mod/mod_remoteip.html
${_PREFIX}RemoteIPHeader X-Real-IP\
"

# IPv4
_append "${_PREFIX}"
_IPV4="$(cat /etc/container/cloudflare-ips-v4.txt)"
_append "${_PREFIX}# https://www.cloudflare.com/ips-v4"
for _ip in ${_IPV4}
do
    _append "${_PREFIX}RemoteIPTrustedProxy ${_ip}"
done

# IPv6
_append "${_PREFIX}"
_IPV6="$(cat /etc/container/cloudflare-ips-v6.txt)"
_append "${_PREFIX}# https://www.cloudflare.com/ips-v6"
for _ip in ${_IPV6}
do
    _append "${_PREFIX}RemoteIPTrustedProxy ${_ip}"
done

_append
_append '# vim: ft=apache:'

print_msg "$(a2enconf --quiet remoteip)"
print_msg "$(a2enmod --quiet remoteip)"

if apachectl -t 1>/dev/null 2>/dev/null
then
    print_msg 'Configuration test: Syntax OK'
else
    print_error 'Configuration test errors:'
    apachectl -t
fi

print_bold 'End configuration  '
unset _APP

# vim: ft=sh
