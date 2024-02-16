FROM php:7.4-fpm

ARG TZ
ARG UID
ARG GID

# Install required packages
RUN apt-get update && apt-get install -y \
        gnupg2 \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libicu-dev \
        wget \
        git \
        curl \
        imagemagick \
        libcurl3-dev \
        libonig-dev \
        libmagickwand-dev \
        libpq-dev \
        libpng-dev \
        libxml2-dev \
        libzip-dev \
        libgmp-dev \
        zlib1g-dev \
        default-mysql-client \
        openssh-client \
        nano \
        mc \
        unzip \
        openssl \
        libcurl4-openssl-dev \
        libssl-dev \
        libmcrypt-dev \
        librabbitmq-dev \
        libssh-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Xdebug compatible with PHP 7.4
RUN pecl install xdebug-2.9.8 \
    && docker-php-ext-enable xdebug

# Install PHP extensions
RUN pecl install mcrypt-1.0.3 imagick \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        zip \
        intl \
        mbstring \
        pdo_mysql \
        exif \
        gd \
        gmp \
        bz2 \
        mysqli \
        pcntl \
        soap \
        sockets \
        bcmath \
        calendar \
        ftp \
    && docker-php-ext-enable imagick

# Copy install-composer
COPY ./install-composer.sh /
RUN chmod +x /install-composer.sh

COPY ./php.ini /usr/local/etc/php/
COPY ./www.conf /usr/local/etc/php/

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Install Yii framework bash autocompletion
RUN curl -L https://raw.githubusercontent.com/yiisoft/yii2/master/contrib/completion/bash/yii -o /etc/bash_completion.d/yii

# Set up time zone
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TZ > /etc/timezone

VOLUME /var/www/.composer
WORKDIR /app

EXPOSE 9000

CMD ["php-fpm"]
ENTRYPOINT ["/entrypoint.sh"]
