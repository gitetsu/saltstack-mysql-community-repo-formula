{% set pkg = salt['grains.filter_by']({
  '5': {
    'rpm': 'http://dev.mysql.com/get/mysql57-community-release-el5-7.noarch.rpm',
  },
  '6': {
    'rpm': 'http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm',
  },
  '7': {
    'rpm': 'http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm',
  },
}, 'osmajorrelease') %}

install-mysql-community-repo-rpm:
  cmd.run:
    - name: rpm -Uvh {{ salt['pillar.get']('mysql-community-repo:rpm', pkg.rpm) }}
    - unless: rpm -qi mysql57-community-release-el7-7.noarch

install-mysql-community-repo-pubkey:
  cmd.run:
    - name: rpm --import http://dev.mysql.com/doc/refman/5.7/en/checking-gpg-signature.html
    - unless: rpm -qi gpg-pubkey-5072e1f5-5301d466
