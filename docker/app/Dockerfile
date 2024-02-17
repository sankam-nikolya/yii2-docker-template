# Use a lightweight base image
FROM php:7.4-fpm

# Set environment variables
ARG UID
ARG GID
ARG TZ

# Install required packages and PHP extensions
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
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
    ; \
    rm -rf /var/lib/apt/lists/*; \
    pecl install mcrypt-1.0.3 imagick install xdebug-2.9.8; \
    docker-php-ext-configure gd --with-freetype --with-jpeg; \
    docker-php-ext-install -j$(nproc) \
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
    ;

# Copy configuration files and scripts
COPY ./php.ini /usr/local/etc/php/
COPY ./install-composer.sh /
COPY ./entrypoint.sh /
RUN chmod +x /install-composer.sh /entrypoint.sh

# Install Yii framework bash autocompletion
RUN curl -L https://raw.githubusercontent.com/yiisoft/yii2/master/contrib/completion/bash/yii -o /etc/bash_completion.d/yii

# Set up time zone
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# Set user and group IDs
RUN groupadd -g ${GID} appuser && \
    useradd -u ${UID} -g ${GID} -s /bin/bash -m appuser

# Switch to the newly created user
USER appuser

# Set working directory and expose port
VOLUME /var/www/.composer
WORKDIR /app
EXPOSE 9000

# Define default command and entrypoint
CMD ["php-fpm"]
ENTRYPOINT ["/entrypoint.sh"]
