#!/usr/bin/env bash

VERSION="$1"

if [ -z "$VERSION" ]; then
  echo "Usage: $0 <php-version>"
  exit 1
fi

export PHP_BUILD_CONFIGURE_OPTS="\
--with-pgsql \
--with-pdo-pgsql \
--with-pear \
--enable-opcache \
--enable-opcache-jit \
--with-curl \
--enable-intl \
--with-gd \
--with-xml \
--with-zip \
--with-sodium \
--enable-fpm \
--enable-exif \
--enable-mbstring"

phpenv install "$VERSION"

