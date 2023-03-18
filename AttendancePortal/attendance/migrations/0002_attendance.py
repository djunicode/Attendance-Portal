# Generated by Django 4.1 on 2023-03-18 07:02

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0010_user_password_reset_token'),
        ('attendance', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Attendance',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date_time', models.DateTimeField(auto_now_add=True)),
                ('status', models.BooleanField(default=False)),
                ('lec_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='attendance.lecture')),
                ('sap_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='accounts.student')),
            ],
        ),
    ]
