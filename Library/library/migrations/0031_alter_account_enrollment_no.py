# Generated by Django 3.2.12 on 2023-02-02 20:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('library', '0030_alter_account_enrollment_no'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='enrollment_no',
            field=models.IntegerField(default=92525, unique=True),
        ),
    ]
