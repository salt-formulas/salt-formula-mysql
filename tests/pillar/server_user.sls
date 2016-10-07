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
    users:
    - name: user01
      host: "*"
      password: 'sdgdsgdsgd'
    - name: user02
      host: "localhost"
