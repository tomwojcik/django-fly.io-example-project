#!/bin/sh

gunicorn --workers 2 --bind :8000 hello_django.wsgi
