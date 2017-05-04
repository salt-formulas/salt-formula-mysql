{%- from "mysql/map.jinja" import client with context %}
{%- if client.enabled %}

{%- for server_name, server in client.get('server', {}).iteritems() %}

{%- set connection_args = {'host': server.admin.host,
                           'port': server.admin.get('port', '3306'),
                           'user': server.admin.user,
                           'pass': server.admin.get('password', ''),
                           'charset': server.admin.get('encoding', 'utf8'),
                           'db': server.admin.get('database', 'mysql')
} %}

backup_mysql_dirs:
  file.directory:
  - names:
    - /root/mysql/scripts
    - /root/mysql/flags
    - /root/mysql/data
  - mode: 700
  - user: root
  - group: root
  - makedirs: true

{%- for database_name, database in server.get('database', {}).iteritems() %}

mysql_{{ server_name }}_database_{{ database_name }}:
  mysql_database.present:
  - name: {{ database_name }}
  - character_set: {{ database.get('encoding', 'utf8') }}
  - connection_host: {{ connection_args.host }}
  - connection_port: {{ connection_args.port }}
  - connection_user: {{ connection_args.user }}
  - connection_pass: {{ connection_args.pass }}
  - connection_charset: {{ connection_args.charset }}
  - connection_db: {{ connection_args.db }}

{%- for user in database.get('users', ()) %}

mysql_{{ server_name }}_user_{{ user.name }}_{{ database_name }}_{{ user.host }}:
  mysql_user.present:
  - name: '{{ user.name }}'
  - host: '{{ user.host }}'
  - password: {{ user.password }}
  - connection_host: {{ connection_args.host }}
  - connection_port: {{ connection_args.port }}
  - connection_user: {{ connection_args.user }}
  - connection_pass: {{ connection_args.pass }}
  - connection_charset: {{ connection_args.charset }}
  - connection_db: {{ connection_args.db }}

mysql_{{ server_name }}_grants_{{ database_name }}_{{ user.name }}_{{ user.host }}:
  mysql_grants.present:
  - grant: {{ user.rights }}
  - database: '{{ database_name }}.*'
  - user: '{{ user.name }}'
  - host: '{{ user.host }}'
  - require:
    - mysql_user: mysql_{{ server_name }}_user_{{ user.name }}_{{ database_name }}_{{ user.host }}
    - mysql_database: mysql_{{ server_name }}_database_{{ database_name }}
  - connection_host: {{ connection_args.host }}
  - connection_port: {{ connection_args.port }}
  - connection_user: {{ connection_args.user }}
  - connection_pass: {{ connection_args.pass }}
  - connection_charset: {{ connection_args.charset }}
  - connection_db: {{ connection_args.db }}

{%- endfor %}

{%- if database.initial_data is defined %}

/root/mysql/scripts/restore_{{ database_name }}.sh:
  file.managed:
  - source: salt://mysql/conf/restore.sh
  - mode: 770
  - template: jinja
  - defaults:
    database_name: {{ database_name }}
    database: {{ database }}
  - require:
    - mysql_database: mysql_{{ server_name }}_database_{{ database_name }}

restore_mysql_database_{{ database_name }}:
  cmd.run:
  - name: /root/mysql/scripts/restore_{{ database_name }}.sh
  - unless: "[ -f /root/mysql/flags/{{ database_name }}-installed ]"
  - cwd: /root
  - require:
    - file: /root/mysql/scripts/restore_{{ database_name }}.sh

{%- endif %}

{%- endfor %}

{%- for user in server.get('users', []) %}

mysql_{{ server_name }}_user_{{ user.name }}_{{ user.host }}:
  mysql_user.present:
  - host: '{{ user.host }}'
  - name: '{{ user.name }}'
  {%- if user.password is defined %}
  - password: {{ user.password }}
  {%- else %}
  - allow_passwordless: True
  {%- endif %}
  - connection_host: {{ connection_args.host }}
  - connection_port: {{ connection_args.port }}
  - connection_user: {{ connection_args.user }}
  - connection_pass: {{ connection_args.pass }}
  - connection_charset: {{ connection_args.charset }}
  - connection_db: {{ connection_args.db }}

{%- endfor %}

{%- endfor %}

{%- endif %}
