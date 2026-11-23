#!/bin/sh
# Comptabile with Dash (the Debian Almquist shell)
#
# This file is sourced by /etc/container/setup.sh
# (It shouldn't be executed directly)
_APP='cron'
_CRON_CONF=/etc/default/cron

print_bold 'Begin configuration'

print_msg 'Ensure all strings are literal (single quotes)'
print_msg 'Enable LSB compliant names for /etc/cron.d files'
print_msg 'Log start of all cron jobs and failed jobs (exit status != 0)'
sed --regexp-extended \
    -e"s|^(READ_ENV=)\"yes\"|\1'yes'|" \
    -e"s|^(EXTRA_OPTS=)\"\"|\1'-l -L 5'|" \
    --in-place "${_CRON_CONF}"

print_bold 'End configuration  '
unset _APP
