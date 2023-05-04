# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера".

## Задача 1
Сценарий выполнения задачи:
* создайте свой репозиторий на <https://hub.docker.com>;
* выберете любой образ, который содержит веб-сервер Nginx;
* создайте свой fork образа;
* реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```html
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на 
<https://hub.docker.com/username_repo>.

### Решение:
index.html:
```html
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>

```
Dockerfile:
```dockerfile
FROM nginx
COPY ./index.html /usr/share/nginx/html
```
```shell
skelin_ei@homework30:/docker$ sudo docker build -t skelinevgeniyivanovich/nginx:1.0 .
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM nginx
 ---> b692a91e4e15
Step 2/2 : COPY ./index.html /usr/share/nginx/html
 ---> d86aa1e91da6
Successfully built d86aa1e91da6
Successfully tagged skelinevgeniyivanovich/nginx:1.0
skelin_ei@homework30:/docker$ sudo docker push skelinevgeniyivanovich/nginx:1.0 The push refers to repository [docker.io/skelinevgeniyivanovich/nginx]
350537587bfb: Pushed
b539cf60d7bb: Mounted from library/nginx
bdc7a32279cc: Mounted from library/nginx
f91d0987b144: Mounted from library/nginx
3a89c8160a43: Mounted from library/nginx
e3257a399753: Mounted from library/nginx
92a4e8a3140f: Mounted from library/nginx
1.0: digest: sha256:674c5161c2c42d9c79ea55b086ba1a4f912d32959a5c73dd9f7d92a6de0a9a51 size: 1777
skelin_ei@homework30:/docker$ sudo docker run --name nginx -d -p 80:80 skelinevgeniyivanovich/nginx:1.0
621de28b2679727b16902484c527512d45aa6becc5c4d04ec27bbb7321cd4d6d
skelin_ei@homework30:/docker$ curl http://localhost
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
skelin_ei@homework30:/docker$
```

Репозиторий: <https://hub.docker.com/repository/docker/skelinevgeniyivanovich/nginx>

## Задача 2
Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или 
лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор:
* Высоконагруженное монолитное java веб-приложение;
* Nodejs веб-приложение;
* Мобильное приложение c версиями для Android и iOS;
* Шина данных на базе Apache Kafka;
* Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash
и две ноды kibana;
* Мониторинг-стек на базе Prometheus и Grafana;
* MongoDB, как основное хранилище данных для java-приложения;
* Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

### Ответ:
1. **Высоконагруженное монолитное java веб-приложение** - в данном случае я бы использовал физическую машину, java 
использует свою виртуальную машину, поэтому излишняя виртуализация только снизит производительность
2. **Nodejs веб-приложение** - контейнеризация, веб приложения всегда отличный вариант для контейнеризации и разбиения
на микросервисы, упростит создание тестовых сред и ускорит выпуски релизов.
3. **Мобильное приложение c версиями для Android и iOS** - докер, отлично подойдет для тестирования под различные версии
мобильных ОС
4. **Шина данных на базе Apache Kafka** - docker, позволит быстро поднимать ноды, а так же позволит реализовать хорошую
отказоустойчивость, по крайней мере если верить.
5. **Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два 
logstash и две ноды kibana** - Судя по описанию данный сценари построен на докере.
6. **Мониторинг-стек на базе Prometheus и Grafana** - Докер. я использую так контейнер с Prometheus, контейнер с Grafana и подключенным
внешним волюмом для хранения данных мониторинга так же отдельно пробрасывается файл конфигурации Prometheus для ускорения внесения правок.
7. **MongoDB, как основное хранилище данных для java-приложения** - К сожаленю судя по данным от коллег нет однозначного понимания, что лучше использовать. Как пример для реализации БД для 1С я использую отдельную виртуальную машину, а для реализации небольших (малонагруженных) БД использовал контейнер. В данном примере т.к. java проекты (с которыми я всчтречался) не сильно нагружают БД я бы использовал Docker.
8. **Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry** - Докер. Оптимальное решение
чтобы в рамках CI/CD в контейнерах осуществлять конфигурирование, сборку, тестирование кода из репозитория.

## Задача 3
* Запустите первый контейнер из образа _**centos**_ c любым тегом в фоновом режиме, подключив папку `/data` из текущей 
рабочей директории на хостовой машине в `/data` контейнера;
* Запустите второй контейнер из образа **_debian_** в фоновом режиме, подключив папку `/data` из текущей рабочей 
директории на хостовой машине в `/data` контейнера;
* Подключитесь к первому контейнеру с помощью `docker exec` и создайте текстовый файл любого содержания в `/data`;
* Добавьте еще один файл в папку `/data` на хостовой машине;
* Подключитесь во второй контейнер и отобразите листинг и содержание файлов в `/data` контейнера.

### Решение:
```shell
skelin_ei@homework30:/docker$ sudo docker run -dit -v /docker/data:/data --name centos centos
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
a1d0c7532777: Pull complete
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
bdee56c91ab3e4ad8f45410f3e689c26771a218e0947d353fe856e0973f79f15
skelin_ei@homework30:/docker$ sudo docker run -dit -v /docker/data:/data --name debian debian
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
001c52e26ad5: Pull complete
Digest: sha256:82bab30ed448b8e2509aabe21f40f0607d905b7fd0dec72802627a20274eba55
Status: Downloaded newer image for debian:latest
52d915ed714ce58b2d21740366acbb8bdf9bd39f290206b68bd6951e99618b79
skelin_ei@homework30:/docker$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
52d915ed714c   debian    "bash"        24 seconds ago   Up 21 seconds             debian
bdee56c91ab3   centos    "/bin/bash"   3 minutes ago    Up 3 minutes              centos

skelin_ei@homework30:/docker$ sudo docker exec -it centos bash
[root@bdee56c91ab3 /]# echo "centos file" > /data/centos.txt
[root@bdee56c91ab3 /]# exit
vagrant@vagrant:~$ echo "host file" > ~/data/host_file.txt
skelin_ei@homework30:/docker$ sudo docker exec -it debian bash
root@52d915ed714c:/# echo "debian file" > /data/debian.txt
root@52d915ed714c:/# exit
skelin_ei@homework30:/docker$ ls -la ./data/
total 20
drwxrwxrwx 2 root      root      4096 авг  9 03:16 .
drwxrwxrwx 3 root      root      4096 авг  9 02:59 ..
-rw-r--r-- 1 root      root        12 авг  9 03:16 centos.txt
-rw-r--r-- 1 root      root        12 авг  9 03:16 debian.txt
-rw-rw-r-- 1 skelin_ei skelin_ei   10 авг  9 03:08 host_file.txt
skelin_ei@homework30:/docker$ cat ./data/centos.txt
centos file
skelin_ei@homework30:/docker$ cat ./data/debian.txt
debian file
skelin_ei@homework30:/docker$ cat ./data/host_file.txt
host file
```