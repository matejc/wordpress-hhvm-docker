#!/bin/bash
cd /home/wordpress/wordpress
if ! grep -Fxq "define( 'Object', 'OBJECT', true );" wp-includes/wp-db.php
then
  sed -i -r "/define\(\s*'OBJECT',\s+'OBJECT',\s+true\s*\);/a define( 'Object', 'OBJECT' );" wp-includes/wp-db.php
fi
if ! grep -Fxq "define( 'object', 'OBJECT', true );" wp-includes/wp-db.php
then
  sed -i -r "/define\(\s*'OBJECT',\s+'OBJECT',\s+true\s*\);/a define( 'object', 'OBJECT' );" wp-includes/wp-db.php
fi
sed -i -r "s/define\(\s*'OBJECT',\s+'OBJECT',\s+true\s*\);/define( 'OBJECT', 'OBJECT' );/" wp-includes/wp-db.php
cp ../wp-config.php ./
cp ../production-config.php ./
hhvm -m daemon -u wordpress -c /etc/hhvm.hdf
tail -f /var/log/hhvm/error.log