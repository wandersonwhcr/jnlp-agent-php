ARG PHP_VERSION=8.4
ARG COMPOSER_VERSION=2.8
ARG AGENT_VERSION=3327.v868139a_d00e0-1
ARG AGENT_PLATFORM=alpine3.22-jdk21

FROM composer/composer:${COMPOSER_VERSION} AS composer
FROM jenkins/agent:${AGENT_VERSION}-${AGENT_PLATFORM} AS agent

FROM php:${PHP_VERSION}-cli-alpine AS release

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

COPY --from=agent /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

RUN apk add --no-cache \
        openjdk21-jre \
    && install -d -o 1000 -g 1000 /app

CMD [ "java", "-jar", "/usr/share/jenkins/agent.jar" ]

ENV HOME=/app

USER 1000:1000

VOLUME /app

WORKDIR /app
