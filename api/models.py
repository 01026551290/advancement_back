from django.db import models

class Employee(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    email = models.CharField(max_length=100)
    hire_date = models.DateField()

    class Meta:
        db_table = 'employees' 

    def __str__(self):
        return f"{self.first_name} {self.last_name}"