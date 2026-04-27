FROM php:8.4-fpm

# Installation des dépendances système
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libonig-dev \
    libzip-dev \
    zip \
    curl

# Extensions PHP nécessaires pour Symfony
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    intl \
    zip \
    opcache

# Installation de Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Configuration PHP
COPY php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www

CMD ["php-fpm"]