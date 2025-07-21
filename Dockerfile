FROM php:8.4-cli-alpine AS release

COPY --from=composer/composer:2.8 /usr/bin/composer /usr/local/bin/composer
