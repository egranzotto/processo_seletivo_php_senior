FROM php:8.2-apache

# Instala dependências do sistema
RUN apt-get update \
    && apt-get install -y libpq-dev unzip git curl \
    && docker-php-ext-install pdo pdo_pgsql

# Instala o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Cria diretório da aplicação e define permissões
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html
WORKDIR /var/www/html

# Copia os arquivos do projeto (composer.json/lock) antes de instalar dependências
COPY ../app/composer.json ./
COPY ../app/composer.lock ./

# Instala dependências PHP (como o firebase/php-jwt)
RUN composer install --no-interaction --prefer-dist --no-dev

# Instala SDK do MinIO (compatível com S3 via AWS SDK)
RUN composer require aws/aws-sdk-php

# Habilita o mod_rewrite do Apache
RUN a2enmod rewrite

# Define o diretório raiz do Apache
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Atualiza a configuração do Apache para apontar para o novo diretório
RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!/var/www/html/public!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Cria diretório padrão do public se não existir
RUN mkdir -p /var/www/html/public && chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 80