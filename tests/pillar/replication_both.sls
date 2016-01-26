mysql:
  server:
    enabled: true
    version: '5.5'
    force_encoding: utf8
    replication:
      role: both
      master: 127.0.0.1
      master_address: 127.0.0.1
      user: admin
      password: password
    server_id: 1
    ssl:
      enabled: true
      authority: Org_CA
      certificate: name_of_service
      client_certificate: name_of_client_cert
    admin:
      user: user
      password: password
    bind:
      address: 0.0.0.0
      port: 3306
      protocol: tcp
salt:
  minion:
    mine:
      module:
        mysql.get_master_status: []