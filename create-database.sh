#!/usr/bin/env bash

mysql --user=root --password="$MYSQL_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS laravel10;
    GRANT ALL PRIVILEGES ON \`laravel10%\`.* TO '$MYSQL_USER'@'%';

    GRANT ALL PRIVILEGES
    ON laravel10.*
    TO 'sail'@'%'
    WITH GRANT OPTION;

    FLUSH PRIVILEGES;

EOSQL
