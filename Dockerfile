FROM php:7.1-cli-alpine

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN apk add git
RUN apk add bash
RUN rm -rf /var/cache/apk/* /var/tmp/*/tmp/*

WORKDIR /package
RUN git init \
    && git config --global user.name "package" \
    && git config --global user.email "package@mvfglobal.com"

COPY version.sh /scripts/version.sh
COPY patch /usr/local/bin/patch
COPY minor /usr/local/bin/minor
COPY major /usr/local/bin/major
COPY tests.sh /usr/local/bin/tests

# Setup entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
