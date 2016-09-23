{%- from "mysql/map.jinja" import server, mysql_connection_args with context %}

mysql_salt_config:
  file.managed:
    - name: /etc/salt/minion.d/mysql.conf
    - template: jinja
    - source: salt://mysql/files/salt-minion.conf
    - mode: 600

{%- if server.enabled %}

include:
- mysql.common

{%- if server.ssl.enabled %}

/etc/mysql/server-cert.pem:
  file.managed:
  {%- if server.ssl.cert is defined %}
  - contents_pillar: mysql:server:ssl:cert
  {%- else %}
  - source: salt://pki/{{ server.ssl.authority }}/certs/{{ server.ssl.certificate }}.cert.pem
  {%- endif %}
  - require:
    - pkg: mysql_packages
  - watch_in:
    - service: mysql_service

/etc/mysql/server-key.pem:
  file.managed:
  {%- if server.ssl.cert is defined %}
  - contents_pillar: mysql:server:ssl:key
  {%- else %}
  - source: salt://pki/{{ server.ssl.authority }}/certs/{{ server.ssl.certificate }}.key.pem
  {%- endif %}
  - require:
    - pkg: mysql_packages
  - watch_in:
    - service: mysql_service

{%- if server.replication.role in ['slave', 'both'] %}

/etc/mysql/client-cert.pem:
  file.managed:
  {%- if server.ssl.client_cert is defined %}
  - contents_pillar: mysql:server:ssl:client_cert
  {%- else %}
  - source: salt://pki/{{ server.ssl.authority }}/certs/{{ server.ssl.client_certificate }}.cert.pem
  {%- endif %}
  - require:
    - pkg: mysql_packages
  - watch_in:
    - service: mysql_service

/etc/mysql/client-key.pem:
  file.managed:
  {%- if server.ssl.client_key is defined %}
  - contents_pillar: mysql:server:ssl:client_key
  {%- else %}
  - source: salt://pki/{{ server.ssl.authority }}/certs/{{ server.ssl.client_certificate }}.key.pem
  {%- endif %}
  - require:
    - pkg: mysql_packages
  - watch_in:
    - service: mysql_service

{%- endif %}

/etc/mysql/cacert.pem:
  file.managed:
  {%- if server.ssl.cacert is defined %}
  - contents_pillar: mysql:server:ssl:cacert
  {%- else %}
  - source: salt://pki/{{ server.ssl.authority }}/{{ server.ssl.authority }}-chain.cert.pem
  {%- endif %}
  - require:
    - pkg: mysql_packages
  - watch_in:
    - service: mysql_service

{%- endif %}


{%- if server.replication.role in ['master', 'both'] %}

{{ server.replication.user }}:
  mysql_user.present:
  - host: '%'
  - password: {{ server.replication.password }}
  - connection_user: {{ mysql_connection_args.user }}
  - connection_pass: {{ mysql_connection_args.password }}
  - connection_charset: {{ mysql_connection_args.charset }}
  - watch_in:
    - service: mysql_service

{{ server.replication.user }}_replication_grants:
  mysql_grants.present:
  - grant: replication slave
  - database: '*.*'
  - user: {{ server.replication.user }}
  - host: '%'
  - connection_user: {{ mysql_connection_args.user }}
  - connection_pass: {{ mysql_connection_args.password }}
  - connection_charset: {{ mysql_connection_args.charset }}
  - watch_in:
    - service: mysql_service

{%- endif %}

{%- if server.replication.role in ['slave', 'both'] %}

{%- if not salt['mysql.get_slave_status'] is defined %}

{%- include "mysql/server/_connect_replication_slave.sls" %}

{%- elif salt['mysql.get_slave_status']() == [] %}

{%- include "mysql/server/_connect_replication_slave.sls" %}

{%- else %}

{%- if salt['mysql.get_slave_status']().get('Slave_SQL_Running', 'No') == 'Yes' and salt['mysql.get_slave_status']().get('Slave_IO_Running', 'No') == 'Yes' %}

{%- else %}

{%- include "mysql/server/_connect_replication_slave.sls" %}

{%- endif %}

{%- endif %}

{%- endif %}

{%- endif %}
