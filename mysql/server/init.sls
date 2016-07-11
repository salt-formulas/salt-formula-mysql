{%- from "mysql/map.jinja" import server with context %}
include:
- mysql.server.service
- mysql.server.database
