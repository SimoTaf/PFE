#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python manage.py flush --no-input
python manage.py makemigrations
python manage.py migrate
script="
from library.models import Language , Genre

Languages=['English','Arabic','French','Spanish','Russian']

Genres=['Fantasy','Adventure','Romance','Contemporary','Dystopian','Mystery','Horror','Thriller','Paranormal','Historical fiction','Science Fiction','Memoir','Cooking','Self-help','Art','Development','Motivational','Health','History','Travel','Humor']

for i in Languages:
    l=Language(name=i)
    l.save()


#print('the languages have been added successfully')



for i in Genres:
    l=Genre(name=i)
    l.save()

#print('the themes have been added successfully')
"
printf "$script" | python manage.py shell
python manage.py createsuperuser_if_none_exists --user=admin --password=Admin1234



exec "$@"
