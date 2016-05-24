{%- from "mysql/map.jinja" import server with context -%}
#!/bin/bash -e

salt-call --local --retcode-passthrough state.highstate
service {{ server.service }} stop || true

su mysql --shell=/bin/sh -c '/usr/sbin/mysqld'

{#-
vim: syntax=jinja
-#}
