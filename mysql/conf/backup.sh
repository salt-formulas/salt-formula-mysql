#!/bin/sh

DATE=$(date +%Y%m%d)

{%- if pillar.mysql.server.databases is defined %}
{%- for database in pillar.mysql.server.databases %}
mkdir -p /root/mysql/backup/{{ database.name }}
mysqldump --defaults-file=/etc/mysql/debian.cnf {{ database.name }} > /root/mysql/backup/{{ database.name }}/${DATE}.sql
cp /root/mysql/backup/{{ database.name }}/${DATE}.sql /root/mysql/backup/{{ database.name }}/last.sql
{%- endfor %}
{%- endif %}

# purge old dumps
find /root/mysql/backup/ -name "*.sql*" -mtime +8 -exec rm -vf {} \;