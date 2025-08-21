echo Creating database $INIT_DATABASE_NAME on host $INIT_DATABASE_HOST

mariadb --user=root -h $INIT_DATABASE_HOST -e "create database $INIT_DATABASE_NAME"
mariadb --user=root -h $INIT_DATABASE_HOST -D $INIT_DATABASE_NAME < /init.sql