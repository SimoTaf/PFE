# Generated by Django 3.2.12 on 2022-05-21 17:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('library', '0005_alter_account_enrollment_no'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='enrollment_no',
            field=models.IntegerField(default=62896, unique=True),
        ),
    ]
