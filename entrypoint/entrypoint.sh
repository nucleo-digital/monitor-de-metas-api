#!/bin/bash

git pull
chown -R www-data: /monitor-de-metas-api/

sed -i -e "s/root %%NGINX_ROOT%%;/root \/monitor-de-metas-api\/public;/g" /etc/nginx/sites-available/default.conf
sed -i -e "s/'default'\s*=>\s*'mysql'/'default' => '${DBDRIVE}'/g" app/config/database.php
sed -i  -e "s/'host'\s*=>\s*'localhost'/'host' => '${DBHOST}'/g" app/config/database.php
sed -i  -e "s/'database'\s*=>\s*'pdm_api'/'database' => '${DBNAME}'/g" app/config/database.php
sed -i  -e "s/'username'\s*=>\s*'wp'/'username' => '${DBUSER}'/g" app/config/database.php
sed -i  -e "s/'password'\s*=>\s*'wp'/'password' => '${DBPASS}'/g" app/config/database.php
sed -i  -e "s/'prefix'\s*=>\s*''/'prefix' => '${DBPREFIX}'/g" app/config/database.php

php artisan migrate
php artisan db:seed

chmod -R 777 /monitor-de-metas-api/app/storage
/etc/init.d/php5.6-fpm start

nginx   