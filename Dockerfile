FROM php:8.1-fpm-alpine

LABEL Maintainer="1of1Group <info@1of1group.com>" \
	Description="1of1Group Docker Container with Nginx & PHP-FPM based on Alpine Linux."

ENV PHPIZE_DEPS \
	autoconf \
	dpkg-dev dpkg \
	file \
	g++ \
	gcc \
	libc-dev \
	make \
	pkgconf \
	musl-dev \
	re2c \
	php81-dev \
	php81-pear

RUN apk --no-cache add bind-tools

# Install packages
RUN apk --no-cache add nginx supervisor curl tzdata openssl

# Install xdebug
RUN apk add --no-cache $PHPIZE_DEPS \
	&& pecl install xdebug-3.1.1

# Configure nginx
COPY docker/development/config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY docker/development/config/fpm-pool.conf /usr/local/etc/php-fpm.d/www.conf
COPY docker/development/config/php.ini /usr/local/etc/php/conf.d/custom.ini

# Configure supervisord
COPY docker/development/config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup document root
RUN mkdir -p /var/www/html

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /run && \
	chown -R nobody.nobody /var/lib/nginx && \
	chown -R nobody.nobody /var/log/nginx

# Switch to use a non-root user from here on
USER nobody

# Add application
WORKDIR /var/www/html
COPY --chown=nobody . /var/www/html/

# Expose the port nginx is reachable on
EXPOSE 8080

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping
