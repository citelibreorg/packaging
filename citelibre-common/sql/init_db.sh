echo Creating database $INIT_DATABASE_NAME on host $INIT_DATABASE_HOST for app user $INIT_APP_USER

mariadb --user=root -h $INIT_DATABASE_HOST -e "create database $INIT_DATABASE_NAME"
mariadb --user=root -h $INIT_DATABASE_HOST -D $INIT_DATABASE_NAME < /init.sql
mariadb --user=root -h $INIT_DATABASE_HOST -e "GRANT ALL PRIVILEGES ON $INIT_DATABASE_NAME.* TO '$INIT_APP_USER'@'%'"