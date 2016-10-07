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
        database:
          database01:
            encoding: utf8
            users:
            - name: username
              password: 'password'
              host: 'localhost'
              rights: 'all privileges'
