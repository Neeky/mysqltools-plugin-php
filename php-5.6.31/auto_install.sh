#!/bin/bash

set -eo pipefail
shopt -s nullglob

file_dir=`dirname $0`
if [ $file_dir -eq '.' ]
then
    file_dir=`pwd`
fi
cd $file_dir

if [ -d /usr/local/php-5.6.31 ]
then
    echo "php-5.6.31 has been installed."
else
    tar -xvf php-5.6.31.tar.gz
    cd php-5.6.31
    ./configure --prefix=/usr/local/php-5.6.31 \
      --with-config-file-path=/usr/local/php-5.6.31/etc --with-config-file-scan-dir=/usr/local/php-5.6.31/etc/php.d \
      --with-mysql={{mysql_base_dir}}/ --with-openssl --enable-ctype \
      --with-mysqli={{mysql_base_dir}}/bin/mysql_config --enable-mbstring \
      --enable-bcmath --with-freetype-dir --with-jpeg-dir --with-png-dir \
      --with-zlib --with-libxml-dir=/usr --enable-xml --enable-sockets \
      --with-apxs2=/usr/local/httpd/bin/apxs  --with-bz2 \
      --enable-maintainer-zts --with-gd --with-gettext && make -j 2 && make install
fi