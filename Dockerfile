FROM php:8.4-cli-bookworm

RUN apt-get update && apt-get install -y git unzip && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN useradd -m appuser
USER appuser

WORKDIR /app

COPY --chown=appuser:appuser composer.json composer.lock ./
RUN composer install --no-interaction --no-scripts --no-autoloader

COPY --chown=appuser:appuser . .
RUN composer dump-autoload

CMD ["bash"]
