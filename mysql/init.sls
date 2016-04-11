
include:
{%- if pillar.mysql.server is defined %}
- mysql.server
{%- endif %}
