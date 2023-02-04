#!/bin/sh

# wait for mysql service to start
echo "Waiting for mysql service to start..."
while ! mysqladmin ping -h"db" --silent; do
    sleep 1
done
echo "MySQL service started."

# create the database and user
echo "Creating database and user..."
mysql -h db -u root -prootpassword -e "CREATE DATABASE tafifet; CREATE USER 'sidotaf'@'%' IDENTIFIED BY '1234'; GRANT ALL PRIVILEGES ON tafifet.* TO 'sidotaf'@'%'; FLUSH PRIVILEGES;"
echo "Database and user created."

if [ "$DATABASE" = "mysql" ]
then
    echo "Waiting for MySQL..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "MySQL started"
else
    echo "Unknown database, using SQLite by default"
fi

python manage.py flush --no-input
python manage.py makemigrations
python manage.py migrate

script="
from library.models import Language , Genre

Languages=['English','Arabic','French','Spanish','Russian']

Genres=['Fantasy','Adventure','Romance','Contemporary','Dystopian','Mystery','Horror','Thriller','Paranormal','Historical']

for lang in Languages:
    l=Language(name=lang)
    l.save()

for genre in Genres:
    g=Genre(name=genre)
    g.save()
"

echo "$script" | python manage.py shell

printf "$script" | python manage.py shell
python manage.py createsuperuser_if_none_exists --user=sido --password=sido

exec "$@"

