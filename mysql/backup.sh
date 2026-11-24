#!/bin/bash
set -euo pipefail
DIR=$HOME/mysql-backup/data
PW=$(cat $HOME/mysql-backup/.pw)
F=$DIR/all_$(date +%F_%H%M).sql.gz
docker exec -e MYSQL_PWD="$PW" mysql-master mysqldump -uroot \
  --all-databases --single-transaction --routines --triggers --events \
  --set-gtid-purged=OFF | gzip > "$F"
find "$DIR" -name 'all_*.sql.gz' -mtime +7 -delete
echo "$(date '+%F %T') OK $F $(du -h "$F" | cut -f1)" >> $HOME/mysql-backup/backup.log

LOG=$HOME/mysql-backup/backup.log
OSS_DST=oss://zjy-mysql-backup-bj/mysql/$(hostname)/
if /usr/local/bin/ossutil -c $HOME/.ossutilconfig cp -f "$F" "$OSS_DST" >/dev/null 2>>"$LOG"; then
  echo "$(date '+%F %T') OSS_OK ${OSS_DST}$(basename "$F")" >> "$LOG"
else
  echo "$(date '+%F %T') OSS_FAIL $F" >> "$LOG"
  exit 1
fi
