#FROM alpine:latest
FROM php:7.3

RUN apt-get update
RUN apt-get install -y git curl cron zlib1g-dev

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]