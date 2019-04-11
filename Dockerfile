# Creating a docker image to run a Django webserver

# Pulling pre-configured apache server docker image
FROM webserver

# Container owner
MAINTAINER chris.lockard@sas.com

# Updating Ubuntu
RUN apt-get update

# Copies django project to html apache folder
COPY myproject /var/www/html

# Copies django config file for apache to the enabled config folder
COPY django.conf /etc/apache2/conf-enabled/django.conf