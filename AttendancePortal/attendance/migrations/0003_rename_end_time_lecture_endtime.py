# Generated by Django 4.1.7 on 2023-04-06 15:27

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('attendance', '0002_rename_start_time_lecture_starttime'),
    ]

    operations = [
        migrations.RenameField(
            model_name='lecture',
            old_name='end_time',
            new_name='endTime',
        ),
    ]
