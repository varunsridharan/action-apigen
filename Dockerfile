#FROM alpine:latest
FROM php:7.2

RUN apt-get install -y git curl cron zlib1g-dev

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]