FROM php:8.3-cli-alpine3.20

WORKDIR /app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY composer.json composer.json 

RUN composer install

COPY . ./

RUN touch oci.log

RUN echo "* * * * * /usr/local/bin/php /app/index.php >> /dev/stdout" | crontab -

ENTRYPOINT ["crond", "&&", "tail", "-f", "/app/oci.log"]