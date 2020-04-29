FROM php:7.1-cli-alpine3.10

RUN apk add git

RUN apk add curl

COPY entrypoint.sh /entrypoint.sh

COPY apigen /cached-apigen

RUN chmod +x /entrypoint.sh

RUN chmod +x /cached-apigen

ENTRYPOINT ["/entrypoint.sh"]