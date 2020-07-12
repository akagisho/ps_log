#!/usr/bin/env bash

set -e

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

curl -o /usr/local/sbin/ps_log.sh \
  https://raw.githubusercontent.com/akagisho/ps_log/master/ps_log.sh

chmod -v +x /usr/local/sbin/ps_log.sh

mkdir -pv /var/log/ps_log

echo '*/3 * * * * root cd /var/log/ps_log && /usr/local/sbin/ps_log.sh' \
  > /etc/cron.d/ps_log
