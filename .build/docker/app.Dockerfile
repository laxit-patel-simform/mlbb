# Use the official FrankenPHP image
FROM dunglas/frankenphp:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    curl \
    && docker-php-ext-install zip

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Composer dependencies
RUN composer install

# Install npm dependencies
RUN npm install

# Build assets
RUN npm run build

# Expose port 80 and start FrankenPHP server
EXPOSE 80
