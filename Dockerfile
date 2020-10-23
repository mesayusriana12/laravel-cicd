# using this awesome prebuild image:
FROM 'mesayusriana12/php-7.4-nginx:cicd'
MAINTAINER  Muhammad Esa Yusriana <mesayusriana12@gmail.com>

# Install prestissimo for faster deps instalation
RUN composer global require hirak/prestissimo

# Make directory for hosting the apps
RUN mkdir /home/app/app
WORKDIR /home/app/app

# Install dependencies
COPY composer.json composer.json
RUN composer install --prefer-dist --no-scripts --no-dev --no-autoloader && rm -rf /home/app/.composer

# Copy codebase
COPY --chown=app:root . ./

# Finish composer
# RUN composer dump-autoload

RUN composer dump-autoload --no-scripts --no-dev --optimize

EXPOSE 8080