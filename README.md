# Ansible Role: PostgreSQL

[![Build Status](https://travis-ci.org/geerlingguy/ansible-role-postgresql.svg?branch=master)](https://travis-ci.org/geerlingguy/ansible-role-postgresql)

Installs and configures PostgreSQL server on RHEL/CentOS or Debian/Ubuntu servers.

## Requirements

No special requirements; note that this role requires root access, so either run it in a playbook with a global `become: yes`, or invoke the role in your playbook like:

    - hosts: database
      roles:
        - role: geerlingguy.postgresql
          become: yes

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    postgresql_enablerepo: ""

TODO.

    postgresql_data_dir: /var/lib/pgsql/data

TODO.

    postgresql_user: postgres
    postgresql_group: postgres

TODO.

    postgresql_databases:
      - name: example
        lc_collate: 'en_US.UTF-8' # optional
        lc_ctype: 'en_US.UTF-8' # optional
        encoding: 'UTF-8' # optional
        login_host: example.com # optional, defaults to 'localhost'
        login_password: supersecure # optional
        login_user: admin # optional, defaults to 'postgres'
        port: 5432 # optional

TODO.

    postgresql_users:
      - name: jdoe
        password: supersecure # optional
        login_host: example.com # optional, defaults to 'localhost'
        login_password: supersecure # optional
        login_user: admin # optional, defaults to 'postgres'
        port: 1234 # optional, defaults to 5432
        priv: table:priv1,priv2 # optional
        role_attr_flags: CREATEDB,NOSUPERUSER # optional
        state: present # optional

TODO.

    postgresql_version: [OS-specific]
    postgresql_bin_path: [OS-specific]
    postgresql_daemon: [OS-specific]
    postgresql_packages: [OS-specific]

TODO.

## Dependencies

None.

## Example Playbook

    - hosts: database
      become: yes
      vars_files:
        - vars/main.yml
      roles:
        - geerlingguy.postgresql

*Inside `vars/main.yml`*:

    postgresql_databases:
      - name: example_db
    postgresql_users:
      - name: example_user
        password: similarly-secure-password

## License

MIT / BSD

## Author Information

This role was created in 2016 by [Jeff Geerling](http://www.jeffgeerling.com/), author of [Ansible for DevOps](https://www.ansiblefordevops.com/).
