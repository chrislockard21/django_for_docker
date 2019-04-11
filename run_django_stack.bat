docker build --no-cache -t django_image .

docker run -itd -p 8000:80 --name django_container django_image

docker exec -it django_container apachectl -k start