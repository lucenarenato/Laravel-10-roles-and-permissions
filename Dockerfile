FROM php:8.2-fpm

ARG user=bonifica
ARG uid=1000

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libwebp-dev \
    zip \
    unzip \
    libpq-dev \
    libssl-dev \
    libmagickwand-dev  # Adicionado para suporte ao ImageMagick

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install the Imagick extension
RUN pecl install imagick && \
    docker-php-ext-enable imagick

# Install other PHP extensions
RUN docker-php-ext-configure gd --with-webp

RUN docker-php-ext-install mbstring exif pcntl bcmath sockets gd && \
    pecl install -o -f redis mongodb && \
    docker-php-ext-enable redis mongodb


# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user && \
    mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www/html

# Copy custom configurations PHP
COPY docker/php/custom.ini /usr/local/etc/php/conf.d/custom.ini

# Set the Docker user to the user we just created
USER $user

# You can specify the command to run on container start here if needed
CMD ["php-fpm"]
