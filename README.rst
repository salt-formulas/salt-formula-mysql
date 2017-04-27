
=============
MySQL Formula
=============

MySQL is the world's second most widely used open-source relational database
management system (RDBMS).


Sample Metadata
===============


Standalone setups
-----------------

Standalone MySQL server

.. code-block:: yaml

    mysql:
      server:
        enabled: true
        version: '5.5'
        admin:
          user: root
          password: pass
        bind:
          address: '127.0.0.1'
          port: 3306
        database:
          name:
            encoding: 'utf8'
            users:
            - name: 'username'
              password: 'password'
              host: 'localhost'
              rights: 'all privileges'


MySQL replication master with SSL

.. code-block:: yaml

    mysql:
      server:
        enabled: true
        version: 5.5
        replication:
          role: master
        ssl:
          enabled: true
          authority: Org_CA
          certificate: name_of_service
        admin:
          user: root
          password: pass
        bind:
          address: '127.0.0.1'
          port: 3306

MySQL replication slave with SSL

.. code-block:: yaml

    mysql:
      server:
        enabled: true
        version: '5.5'
        replication:
          role: slave
          master: master.salt.id
        ssl:
          enabled: true
          authority: Org_CA
          certificate: name_of_service
          client_certificate: name_of_client_cert
        admin:
          user: root
          password: pass
        bind:
          address: '127.0.0.1'
          port: 3306

Tuned up MySQL server

.. code-block:: yaml

    mysql:
      server:
        enabled: true
        version: '5.5'
        admin:
          user: root
          password: pass
        bind:
          address: '127.0.0.1'
          port: 3306
        key_buffer: 250M
        max_allowed_packet: 32M
        max_connections: 1000
        thread_stack: 512K
        thread_cache_size: 64
        query_cache_limit: 16M
        query_cache_size: 96M
        force_encoding: utf8
        sql_mode: "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
        database:
          name:
            encoding: 'utf8'
            users:
            - name: 'username'
              password: 'password'
              host: 'localhost'
              rights: 'all privileges'


MySQL Galera cluster
--------------------

MySQL Galera cluster is configured for ring connection between 3 nodes. Each
node should have just one member.

Galera initial server (master)

.. code-block:: yaml

    mysql:
      cluster:
        enabled: true
        name: openstack
        role:master
        bind:
          address: 192.168.0.1
        members:
        - host: 192.168.0.1
          port: 4567
        user:
          name: wsrep_sst
          password: password
     server:
        enabled: true
        version: 5.5
        admin:
          user: root
          password: pass
        bind:
          address: 192.168.0.1
        database:
          name:
            encoding: 'utf8'
            users:
            - name: 'username'
              password: 'password'
              host: 'localhost'
              rights: 'all privileges'

MySQL client
------------

Database with initial data (Restore DB)

.. code-block:: yaml

    mysql:
      client:
        server:
          database:
            admin:
              host: localhost
              port: 3306
              user: ${_param:mysql_admin_user}
              password: ${_param:mysql_admin_password}
              encoding: utf8
            database:
              neutron_upgrade:
                encoding: utf8
                users:
                - name: neutron
                  password: ${_param:mysql_neutron_password}
                  host: '%'
                  rights: all
                - name: neutron
                  password: ${_param:mysql_neutron_password}
                  host: ${_param:single_address}
                  rights: all
                initial_data:
                  engine: backupninja
                  source: ${_param:backupninja_backup_host}
                  host: ${linux:network:fqdn}
                  database: neutron

.. note:: This client role needs to be put directly on dbs node. 
          The provided setup restores db named neutron_upgrade with data from db called neutron.


Database management on remote MySQL server

.. code-block:: yaml

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


User management on remote MySQL server

.. code-block:: yaml

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


Sample Usage
============

MySQL Galera check sripts

.. code-block:: bash
    
    mysql> SHOW STATUS LIKE 'wsrep%';

    mysql> SHOW STATUS LIKE 'wsrep_cluster_size' ;"

Galera monitoring command, performed from extra server

.. code-block:: bash

    garbd -a gcomm://ipaddrofone:4567 -g my_wsrep_cluster -l /tmp/1.out -d

1. salt-call state.sls mysql
2. Comment everything starting wsrep* (wsrep_provider, wsrep_cluster, wsrep_sst)
3. service mysql start
4. run on each node mysql_secure_install and filling root password.

.. code-block:: bash

    Enter current password for root (enter for none): 
    OK, successfully used password, moving on...

    Setting the root password ensures that nobody can log into the MySQL
    root user without the proper authorisation.

    Set root password? [Y/n] y
    New password: 
    Re-enter new password: 
    Password updated successfully!
    Reloading privilege tables..
     ... Success!

    By default, a MySQL installation has an anonymous user, allowing anyone
    to log into MySQL without having to have a user account created for
    them.  This is intended only for testing, and to make the installation
    go a bit smoother.  You should remove them before moving into a
    production environment.

    Remove anonymous users? [Y/n] y
     ... Success!

    Normally, root should only be allowed to connect from 'localhost'.  This
    ensures that someone cannot guess at the root password from the network.

    Disallow root login remotely? [Y/n] n
     ... skipping.

    By default, MySQL comes with a database named 'test' that anyone can
    access.  This is also intended only for testing, and should be removed
    before moving into a production environment.

    Remove test database and access to it? [Y/n] y
     - Dropping test database...
     ... Success!
     - Removing privileges on test database...
     ... Success!

    Reloading the privilege tables will ensure that all changes made so far
    will take effect immediately.

    Reload privilege tables now? [Y/n] y
     ... Success!

    Cleaning up...

5. service mysql stop
6. uncomment all wsrep* lines except first server, where leave only in my.cnf wsrep_cluster_address='gcomm://'; 
7. start first node
8. Start third node which is connected to first one
9. Start second node which is connected to third one
10. After starting cluster, it must be change cluster address at first starting node without restart database and change config my.cnf.

.. code-block:: bash

    mysql> SET GLOBAL wsrep_cluster_address='gcomm://10.0.0.2';

More Information
================

* http://dev.mysql.com/doc/
* http://www.slideshare.net/osscube/mysql-performance-tuning-top-10-tips

* http://sourceforge.net/projects/automysqlbackup/
* https://labs.riseup.net/code/projects/backupninja/wiki
* http://wiki.zmanda.com/index.php/Mysql-zrm


Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-mysql/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-mysql

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
