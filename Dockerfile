#FROM alpine:latest
#FROM php:7.1-cli-alpine3.10
FROM composer:1

#RUN apk add git
#RUN apk add curl

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]