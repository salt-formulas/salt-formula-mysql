
{%- set setup_replication_query = "START MASTER;" %}

/tmp/setup_replication_query:
  file.managed:
  - contents: {{ setup_replication_query }}

{%- set setup_replication_result = salt['mysql.query']('mysql', setup_replication_query) %}

/tmp/setup_replication_result:
  file.managed:
  - contents: {{ setup_replication_result }}
