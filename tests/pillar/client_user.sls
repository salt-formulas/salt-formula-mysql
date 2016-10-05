mysql:
  client:
    enabled: true
    server:
      server01:
        admin:
          host: database.host
          port: 3306
          user: root
          password: password
          encoding: utf8
        users:
        - name: user01
          host: "*"
          password: 'sdgdsgdsgd'
        - name: user02
          host: "localhost"
