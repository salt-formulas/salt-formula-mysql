mysql:
  server:
    enabled: true
    version: '5.5'
    force_encoding: utf8
    admin:
      user: admin
      password: password
    bind:
      address: 0.0.0.0
      port: 3306
      protocol: tcp
    database:
      nova:
        encoding: utf8
        users:
        - name: nova
          password: password
          host: '%'
          rights: all
        - name: nova
          password: password
          host: 127.0.0.1
          rights: all