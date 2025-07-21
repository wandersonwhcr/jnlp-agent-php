ARG PHP_VERSION=8.4

FROM php:${PHP_VERSION}-cli-alpine AS release

COPY --from=composer/composer:2.8 /usr/bin/composer /usr/local/bin/composer

COPY --from=jenkins/agent:3327.v868139a_d00e0-1-alpine3.22-jdk21 /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

RUN apk add --no-cache \
        openjdk21-jre

CMD [ "java", "-jar", "/usr/share/jenkins/agent.jar" ]

ENV HOME=/app

USER 1000:1000

VOLUME /app

WORKDIR /app
