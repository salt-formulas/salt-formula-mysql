#!/bin/sh

{%- set age = database.initial_data.get("age", "0") %}
{%- set host = database.initial_data.get("host", grains.id ) %}
{%- set name = database.initial_data.get("database", '') %}
{%- set source_name = name + ".sql.gz" %}
{%- set dest_name = database_name + ".sql.gz" %}
{%- set path = "/var/backups/mysql/" %}

{%- if database.initial_data.source != 'localhost' %}

scp backupninja@{{ database.initial_data.source }}:/srv/backupninja/{{ host }}{{ path }}mysql.{{ age }}/sqldump/{{ source_name }} /root/mysql/data/{{ source_name }}

gunzip -c /root/mysql/data/{{ source_name }} | mysql -u{{ database.users[0].name }} -p{{ database.users[0].password }} {{ database_name }}

touch /root/mysql/flags/{{ database_name }}-installed

{%- else %}

gunzip -c {{ path }}sqldump/{{ source_name }} | mysql -u{{ database.users[0].name }} -p{{ database.users[0].password }} {{ database_name }}

touch /root/mysql/flags/{{ database_name }}-installed

{%- endif %}
