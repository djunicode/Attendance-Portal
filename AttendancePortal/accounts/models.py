from django.db import models
from .managers import UserManager
from django.contrib.auth.models import AbstractBaseUser

# Create your models here.
class User(AbstractBaseUser):
    unique_id = models.BigIntegerField(unique=True,help_text='Enter your Unique Id')
    first_name = models.CharField(max_length=20, help_text='Enter your First name')
    last_name = models.CharField(max_length=20, help_text='Enter your Last name')
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)

    objects = UserManager()

    USERNAME_FIELD = 'unique_id'
    REQUIRED_FIELDS = ['first_name','last_name']

    def __str__(self):
        return self.first_name+' '+self.last_name+', '+str(self.unique_id)

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    @property
    def is_staff(self):
        "Is the user a member of staff?"
        # Simplest possible answer: All admins are staff
        return self.is_admin