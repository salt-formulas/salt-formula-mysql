
include:
{%- if pillar.mysql.server is defined %}
- mysql.server
{%- endif %}
{%- if pillar.mysql.client is defined %}
- mysql.client
{%- endif %}
