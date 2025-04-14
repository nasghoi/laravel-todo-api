# Use latest Ubuntu
FROM ubuntu:24.04

# Prevent tzdata from prompting during install
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
ENV TZ=Asia/Kuala_Lumpur

# Install software and PHP 8.3 with required extensions
RUN apt-get update && apt-get install -y \
    software-properties-common \
    lsb-release \
    ca-certificates \
    curl \
    git \
    unzip \
    nano \
    apache2 \
    php8.3 \
    php8.3-cli \
    php8.3-common \
    php8.3-mbstring \
    php8.3-xml \
    php8.3-curl \
    php8.3-mysql \
    php8.3-zip \
    libapache2-mod-php8.3 \
    tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

# Enable Apache mod_rewrite for Laravel routing
RUN a2enmod rewrite

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Optional: Install Node.js (latest LTS for Vite build support)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Set working directory
WORKDIR /var/www/html

# Set proper permissions for Laravel
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Expose Apache port
EXPOSE 80

# Start Apache
CMD ["apachectl", "-D", "FOREGROUND"]