# Django Docker Container
This project was created to automate the deployement of django projects in docker containers. It uses the ctlockar/webserver image from Docker Hub to deploy a django project on an Apache2 server. There is a base project that gets imported "myproject" and a default "django.conf" file which is utilized in the conf-enabled Apache2 directory.

## Deploying Your Own Django Project
All configuration for the django project should be done in the project directories of the host machine. The Dockerfile will take care of copying that project into the container.

For a project with a name other than "myproject", you will need to edit the django.conf file to reflect the location of the wsgi.py file and the python path. The base config file is below for reference.

```
WSGIScriptAlias / /var/www/html/myproject/myproject/wsgi.py
WSGIPythonPath /var/www/html/myproject

<Directory /var/www/html/myproject/myproject>
<Files wsgi.py>
Require all granted
</Files>
</Directory>
```

This project uses a standard WSGI configuration as seen [here](https://docs.djangoproject.com/en/2.2/howto/deployment/wsgi/modwsgi/) in the official django docs, but can be configured with the WSGI Daemon process or virtual hosts by simply editing the django.conf file.

You will also need to edit the Dockerfile to reference the new directory that you are trying to copy to the container.

## Runing the Container
Two bat scripts are provided for windows users to spin up and remove the django contianer. Edit these scripts to suit your needs, or to add additional options to the deployement.

For all other OS's (and Windows if you would rather ignore the scripts) running the following commands provided me the correct result:

```
docker build --no-cache -t django_image .

docker run -itd -p 8000:80 --name django_container django_image

docker exec -it django_container apachectl -k start
```
Once the above commands are run you should be able to open a web browser and go to http://localhost:8000 and see the django splash screen.

## Extending the Dockerfile
The docker file as it stands now is very basic. Feel free to edit it running extra commands for your specific project.

For example, here are some good ideas:
* Django - collect static files
* Git - install git and pull your projects from a remote repository
* Cron Jobs - add cron jobs to refresh your server or to automate file creation/log collection

## Special Notes
* This project does not collect static images
* This is a raw django project, meaning that no settings have been changed including debug=TRUE and a null ALLOWED_HOSTS list
* Root is used to spawn the additional Apache services being run as the www-data user. If you want to use this for production, be sure to check and make sure that your contianer is secure to your liking.
