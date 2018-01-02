Instructions and script on how to populate mariadb instance with data in Dockerfile

Start docker registry:

```
docker run -d -p 5000:5000 --name registry registry:2
```

build maria iamge with data inside
```
docker build -t localhost:5000/maria .
```

push image to docker registry:

```
docker push localhost:5000/maria
```

now you can start the image using the one you've recently pushed
```
docker run -d -p 3306:3306 --name maria localhost:5000/maria
```


Inspiration and resources:

https://stackoverflow.com/a/29150538/1647283
https://github.com/docker-library/mariadb/blob/master/10.3/docker-entrypoint.sh