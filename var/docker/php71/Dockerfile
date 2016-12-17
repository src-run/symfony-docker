FROM php:7.1-apache

# Install deps for php extensions
RUN apt-get update && apt-get install -y \
    vim \
    nano \
    libcurl4-gnutls-dev \
    g++ \
    zlib1g-dev \
    libicu-dev \
    mysql-client \
    make \
    autoconf \
    libc-dev \
    pkg-config \
    libjpeg-dev \
    libpng12-dev \
    cron \
    openssh-server \
    sudo

# Enable required apache2 modules
RUN a2enmod rewrite

# Install PHP extensions
RUN docker-php-ext-install -j$(nproc) curl iconv json pdo_mysql exif zip && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    docker-php-ext-configure gd --with-jpeg-dir=/usr/lib/x86_64-linux-gnu && \
    docker-php-ext-install gd

# Install composer
RUN curl -o /usr/local/bin/composer https://getcomposer.org/composer.phar && \
    chmod +x /usr/local/bin/composer

# Create webserver user
RUN useradd --shell /bin/bash -m -d /var/www/html web && \
    chown -R web:web /var/www

# Configure environment
ENV APACHE_RUN_USER web
ENV APACHE_RUN_GROUP web

# Expose SSH ports
EXPOSE 21
EXPOSE 22

# Copy scripts and configurations
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY config/000-default.conf /etc/apache2/sites-enabled/
COPY config/php.ini /usr/local/etc/php/

# Make entry point executable
RUN chmod +x /docker-entrypoint.sh

# Set custom entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
