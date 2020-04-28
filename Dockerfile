#FROM alpine:latest
FROM php:7.2

RUN apt-get update
RUN apt-get install -y git curl cron

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]