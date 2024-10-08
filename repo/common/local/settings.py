from django_auth_ldap.config import LDAPSearch, PosixGroupType, GroupOfNamesType
import ldap

"""
This is an example, please update with your own information
"""

CONFIG = dict(
    local=dict(
        database=dict(
            ENGINE='django.db.backends.mysql',
            NAME='mdmdb',
            USER='mdmuser',
            PASSWORD='MDMPassword123',
            HOST='mysql',  # Ändere 'localhost' zu 'mysql' (Service-Name im docker-compose)
            PORT='3306'),
        ldap=dict(
            SERVER_URI='ldap://openldap',  # Verweis auf den LDAP-Container
            BIND_DN='cn=admin,dc=ramhlocal,dc=com',
            BIND_PASSWORD='admin_pass',
            USER_SEARCH=LDAPSearch("ou=users,dc=ramhlocal,dc=com",
                                   ldap.SCOPE_SUBTREE, "(cn=%(user)s)"),
            GROUP_SEARCH=LDAPSearch("ou=groups,dc=ramhlocal,dc=com",
                                    ldap.SCOPE_SUBTREE, "(objectClass=posixGroup)"),
            GROUP_TYPE=PosixGroupType(),

            REQUIRE_GROUP='cn=mdm,ou=groups,dc=ramhlocal,dc=com',
            GROUPS=('finance', 'marketing'),
        ),
        mongo=dict(
            DB='mdm',
            HOST='mongodb',  # Füge den MongoDB-Host hinzu
            PORT=27017       # Standard-Port für MongoDB
        )
    ),
)
