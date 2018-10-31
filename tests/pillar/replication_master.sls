mysql:
  server:
    enabled: true
    version: '5.5'
    force_encoding: utf8
    replication:
      role: master
      user: admin
      password: password
    server_id: 1
    ssl:
      enabled: true
      tls_version: TLSv1.1,TLSv1.2
      ciphers:
        DHE-RSA-AES128-SHA:
          enabled: True
        DHE-RSA-AES256-SHA:
          name: DHE-RSA-AES256-SHA
          enabled: True
        EDH-RSA-DES-CBC3-SHA:
          name: EDH-RSA-DES-CBC3-SHA
          enabled: True
        AES128-SHA:AES256-SHA:
          enabled: True
        DES-CBC3-SHA:
          enabled: True
      cert: |
        -----BEGIN CERTIFICATE-----
        MIIB6TCCAZOgAwIBAgIJAIfmjJydRX+GMA0GCSqGSIb3DQEBCwUAMFAxCzAJBgNV
        BAYTAkNaMRMwEQYDVQQIDApTb21lLVN0YXRlMRkwFwYDVQQHDBBLYXJkYXNvdmEg
        UmVjaWNlMREwDwYDVQQKDAhNaXJhbnRpczAeFw0xNzA4MzAxMTM1MzhaFw0yNzA4
        MjgxMTM1MzhaMFAxCzAJBgNVBAYTAkNaMRMwEQYDVQQIDApTb21lLVN0YXRlMRkw
        FwYDVQQHDBBLYXJkYXNvdmEgUmVjaWNlMREwDwYDVQQKDAhNaXJhbnRpczBcMA0G
        CSqGSIb3DQEBAQUAA0sAMEgCQQDhW6xXGA2iKd5ngRwqoU0A0pD71/moFm48q0UP
        Tg8vUsIO3WBIEKVLzpln9sU9gplCTx1ScsFBiRi2E3Wv+PnFAgMBAAGjUDBOMB0G
        A1UdDgQWBBSJ42eEq3O0faBj+NBXWV5O2Vr1PTAfBgNVHSMEGDAWgBSJ42eEq3O0
        faBj+NBXWV5O2Vr1PTAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA0EA3fbu
        x0W+XORSyFcChwFyhd+ka0R/FB4IL2udPXWX96x+0inuYi2Pta++3fMGmf30GF7Y
        1Iv89B+NrhLHCfkEbg==
        -----END CERTIFICATE-----
      key: |
        -----BEGIN PRIVATE KEY-----
        MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEA4VusVxgNoineZ4Ec
        KqFNANKQ+9f5qBZuPKtFD04PL1LCDt1gSBClS86ZZ/bFPYKZQk8dUnLBQYkYthN1
        r/j5xQIDAQABAkB4ip+Zin0oY3raJF5bkyHsMbVpcHHS7gSTIQ10jU1kAsBAVA2p
        wIvZte5fIuaA6pEQ/ogZ5oTdCSz+bgtR50ShAiEA+DjNRJeUvaXNYyNBqKyPI1oT
        na2QqV43z74txQ8FOykCIQDoa3YqPO4b70hglJOJMIYyMQAkAzdichKTWbBaIJf5
        PQIhANTqLDCU8RIHoXhTKqPbeGAziLXsxjRxS+BXWf05GByZAiB5whpEZGklL0TO
        e+eSnl4fGzaEpz6zjykWEo1lmd+jzQIgL740kEr8J+Q1ppNDJBtbZnc7yp+P/DKL
        wo20+sNoyFU=
        -----END PRIVATE KEY-----
      client_cert: |
        -----BEGIN CERTIFICATE-----
        MIIB6TCCAZOgAwIBAgIJAMOZDw2vHe+UMA0GCSqGSIb3DQEBCwUAMFAxCzAJBgNV
        BAYTAkNaMRMwEQYDVQQIDApTb21lLVN0YXRlMRkwFwYDVQQHDBBLYXJkYXNvdmEg
        UmVjaWNlMREwDwYDVQQKDAhNaXJhbnRpczAeFw0xNzA4MzAxMTU0MzVaFw0yNzA4
        MjgxMTU0MzVaMFAxCzAJBgNVBAYTAkNaMRMwEQYDVQQIDApTb21lLVN0YXRlMRkw
        FwYDVQQHDBBLYXJkYXNvdmEgUmVjaWNlMREwDwYDVQQKDAhNaXJhbnRpczBcMA0G
        CSqGSIb3DQEBAQUAA0sAMEgCQQD68iXHw1rQDWXFmdEPuv/8OCiUS1R6FoHqL357
        VvqHA5339j8XKxtPnV2SY8DoMxEy1j7SYAyxD5xsZDVx14RpAgMBAAGjUDBOMB0G
        A1UdDgQWBBTJ25400u3yEyiHykdeja+TGEMVKjAfBgNVHSMEGDAWgBTJ25400u3y
        EyiHykdeja+TGEMVKjAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA0EAaiMK
        a4m6eSuk5emcw7igaV3UtydA6tduMvjL3zNcbI58on5YV7xgBTPXqDjq4QvAw06P
        /PWEXbl2jaCHaX06wA==
        -----END CERTIFICATE-----
      client_key: |
        -----BEGIN PRIVATE KEY-----
        MIIBVQIBADANBgkqhkiG9w0BAQEFAASCAT8wggE7AgEAAkEA+vIlx8Na0A1lxZnR
        D7r//DgolEtUehaB6i9+e1b6hwOd9/Y/FysbT51dkmPA6DMRMtY+0mAMsQ+cbGQ1
        cdeEaQIDAQABAkEApuTYn4ybHvdqEgsEcVPK37Fxu36GBlRlvpwroFfuck9yYod+
        CZMPdFWD0/H29Tj1g5p/NKHGAcM3jtqf7daOCQIhAP4DCQguBpJChtQ9/LzGasJe
        LN5bg/ChpFmN6iVnwEDbAiEA/Oj4ELceNaDVsVG8sVI3IrG/8xgXhYnNex/e5LPR
        oQsCIEXE7akqgzGPRltrv0zWryI+HdLhjib9LxhOC59ElSD7AiEAz98EFWkNMXLy
        cP4Ho485thB2/m1s19t9wpddcojB4iUCIBJ1hIyrfWFAh8ktK9mNolMPR50+4eZk
        nTe8UvFB7ZIB
        -----END PRIVATE KEY-----
      cacert: |
        -----BEGIN CERTIFICATE-----
        MIIB6TCCAZOgAwIBAgIJAOqENcDHki1ZMA0GCSqGSIb3DQEBCwUAMFAxCzAJBgNV
        BAYTAkNaMRMwEQYDVQQIDApTb21lLVN0YXRlMRkwFwYDVQQHDBBLYXJkYXNvdmEg
        UmVjaWNlMREwDwYDVQQKDAhNaXJhbnRpczAeFw0xNzA4MzAxMTU3MjBaFw0yNzA4
        MjgxMTU3MjBaMFAxCzAJBgNVBAYTAkNaMRMwEQYDVQQIDApTb21lLVN0YXRlMRkw
        FwYDVQQHDBBLYXJkYXNvdmEgUmVjaWNlMREwDwYDVQQKDAhNaXJhbnRpczBcMA0G
        CSqGSIb3DQEBAQUAA0sAMEgCQQDR16IIDivaiFCgxe43WuZDNPnn+Efb5E8/oTMY
        fVR8DS9u+arKL0WRW3unDPErpZAoESa2GV+QIRfmJBtS7MWJAgMBAAGjUDBOMB0G
        A1UdDgQWBBT3yZnbvcTfd4qUxSSaNMMmToCuETAfBgNVHSMEGDAWgBT3yZnbvcTf
        d4qUxSSaNMMmToCuETAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA0EArDqA
        Y5Dnrw3xbFDoAYGVrvSwdabt5IbTA5xpAWYOqomkIMhJf8UptGZ6SkYoPKFLz+bL
        1yBBSG809x2L+BRFEA==
        -----END CERTIFICATE-----
    admin:
      user: root
      password: ''
    bind:
      address: 0.0.0.0
      port: 3306
      protocol: tcp
salt:
  minion:
    mine:
      module:
        mysql.get_master_status: []
