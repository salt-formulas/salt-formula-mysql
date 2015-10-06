#!/bin/sh

cd /root/mysql

{%- for database in pillar.mysql.server.databases %}
{%- if database.name == database_name %}

{%- set age = database.initial_data.get("age", "0") %}
{%- set host = database.initial_data.get("host", grains.id ) %}
{%- set name = database.initial_data.get("database", database.name) %}
{%- set source_name = name + ".sql.gz" %}
{%- set dest_name = database.name + ".sql.gz" %}
{%- set target = "/root/mysql/data/" %}

scp backupninja@{{ database.initial_data.source }}:/srv/backupninja/{{ host }}/var/backups/mysql/mysql.{{ age }}/sqldump/{{ source_name }} {{ target }}{{ dest_name }}

gunzip -c {{ target }}{{ dest_name }} | mysql -h 127.0.0.1 -u {{ database.users[0].name }} -p{{ database.users[0].password }} {{ database.name }}

touch /root/mysql/flags/{{ database.name }}-installed

{%- endif %}
{%- endfor %} 