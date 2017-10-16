# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models


class Computer(models.Model):

    stack_pointer = models.IntegerField(default=0)
    program_counter = models.IntegerField(default=0)
    computation_ended = models.BooleanField(default=False)

    @staticmethod
    def create(size):
        computer = Computer.objects.create()
        for x in range(size):
            Register.objects.create(address=x, computer=computer)
        return computer


class Register(models.Model):

    address = models.IntegerField()
    value1 = models.CharField(max_length=50, null=True)
    value2 = models.IntegerField(null=True)
    computer = models.ForeignKey(Computer)
