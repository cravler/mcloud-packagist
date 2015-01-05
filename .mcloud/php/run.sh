#!/bin/bash

echo "Waiting while mysql starts"
while ! echo exit | nc -z mysql 3306; do
    echo ".";
    sleep 3;
done

if [ ! -d /var/www/sf ]; then

    git clone http://github.com/composer/packagist.git /var/www/sf/
    chmod +x /var/www/sf/app/console
    cp /var/www/.mcloud/php/parameters.yml.dist /var/www/sf/app/config/parameters.yml
    composer install --no-interaction --working-dir=/var/www/sf/
    /var/www/sf/app/console doctrine:database:create
    /var/www/sf/app/console doctrine:schema:create
    /var/www/sf/app/console assets:install /var/www/sf/web/

    FIND='nelmio_solarium: ~'
    REPLACE=''
    sed -i "s;$FIND;$REPLACE;g" /var/www/sf/app/config/config.yml

    echo 'nelmio_solarium:' >> /var/www/sf/app/config/config.yml
    echo '    clients:' >> /var/www/sf/app/config/config.yml
    echo '        default:' >> /var/www/sf/app/config/config.yml
    echo '            host: %solr_host%' >> /var/www/sf/app/config/config.yml
    echo '            port: %solr_port%' >> /var/www/sf/app/config/config.yml
    echo '            path: /solr' >> /var/www/sf/app/config/config.yml
    echo '            core: active' >> /var/www/sf/app/config/config.yml
    echo '            timeout: 5' >> /var/www/sf/app/config/config.yml

else

    composer install --no-interaction --working-dir=/var/www/sf/
    /var/www/sf/app/console doctrine:schema:update --force
    /var/www/sf/app/console assets:install /var/www/sf/web/

fi

@me ready in 3s
php5-fpm -R