# Домашнее задание к занятию "6.2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

### Решение

```dockerfile
version: '3.6'

volumes:
  data: {}
  backup: {}

services:

  postgres:
    image: postgres:12
    container_name: psql
    ports:
      - "0.0.0.0:5432:5432"
    volumes:
      - data:/var/lib/postgresql/data
      - backup:/media/postgresql/backup
    environment:
      POSTGRES_USER: "test-admin-user"
      POSTGRES_PASSWORD: "netology"
      POSTGRES_DB: "test_db"
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

### Решение
- Итоговый список БД после выполнения пунктов задания:
```sql
test_db-# \l
                                             List of databases
   Name    |      Owner      | Encoding |  Collate   |   Ctype    |            Access privileges
-----------+-----------------+----------+------------+------------+-----------------------------------------
 postgres  | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 | =c/"test-admin-user"                   +
           |                 |          |            |            | "test-admin-user"=CTc/"test-admin-user"
 template1 | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 | =c/"test-admin-user"                   +
           |                 |          |            |            | "test-admin-user"=CTc/"test-admin-user"
 test_db   | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 |
 ```

- описание таблиц (describe)
```sql
test_db=# \d+ orders
                                                          Table "public.orders"
    Column    |         Type          | Collation | Nullable |              Default               | Storage  | Stats target | Description
--------------+-----------------------+-----------+----------+------------------------------------+----------+--------------+-------------
 id           | integer               |           | not null | nextval('orders_id_seq'::regclass) | plain    |              |
 цена         | integer               |           |          |                                    | plain    |              |
 наименование | character varying(30) |           |          |                                    | extended |              |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

test_db=# \d+ clients
                                                             Table "public.clients"
      Column       |         Type          | Collation | Nullable |               Default               | Storage  | Stats target | Description
-------------------+-----------------------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id                | integer               |           | not null | nextval('clients_id_seq'::regclass) | plain    |              |
 фамилия           | character varying(30) |           |          |                                     | extended |              |
 заказ             | integer               |           |          |                                     | plain    |              |
 страна проживания | character varying(30) |           |          |                                     | extended |              |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap
```

- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```sql
test_db=# SELECT
    grantee, table_name, privilege_type
FROM
    information_schema.table_privileges
WHERE
    grantee in ('test-admin-user','test-simple-user')
    and table_name in ('clients','orders')
order by
    1,2,3;
```
- список пользователей с правами над таблицами test_db
```sql

     grantee      | table_name | privilege_type
------------------+------------+----------------
 test-admin-user  | clients    | DELETE
 test-admin-user  | clients    | INSERT
 test-admin-user  | clients    | REFERENCES
 test-admin-user  | clients    | SELECT
 test-admin-user  | clients    | TRIGGER
 test-admin-user  | clients    | TRUNCATE
 test-admin-user  | clients    | UPDATE
 test-admin-user  | orders     | DELETE
 test-admin-user  | orders     | INSERT
 test-admin-user  | orders     | REFERENCES
 test-admin-user  | orders     | SELECT
 test-admin-user  | orders     | TRIGGER
 test-admin-user  | orders     | TRUNCATE
 test-admin-user  | orders     | UPDATE
 test-simple-user | clients    | DELETE
 test-simple-user | clients    | INSERT
 test-simple-user | clients    | SELECT
 test-simple-user | clients    | UPDATE
 test-simple-user | orders     | DELETE
 test-simple-user | orders     | INSERT
 test-simple-user | orders     | SELECT
 test-simple-user | orders     | UPDATE
(22 rows)
```

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

### Решение

```commandline
test_db=# INSERT INTO orders VALUES (1, 10, 'Шоколад'), (2, 3000, 'Принтер'), (3, 500, 'Книга'), (4, 7000, 'Монитор'), (5, 4000, 'Гитара');
INSERT 0 5
test_db=# SELECT * FROM orders;
 id | цена | наименование
----+------+--------------
  1 |   10 | Шоколад
  2 | 3000 | Принтер
  3 |  500 | Книга
  4 | 7000 | Монитор
  5 | 4000 | Гитара
(5 rows)

test_db=# INSERT INTO clients (id, фамилия, "страна проживания") VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
INSERT 0 5
test_db=# SELECT * FROM clients;
 id |       фамилия        | заказ | страна проживания
----+----------------------+-------+-------------------
  1 | Иванов Иван Иванович |       | USA
  2 | Петров Петр Петрович |       | Canada
  3 | Иоганн Себастьян Бах |       | Japan
  4 | Ронни Джеймс Дио     |       | Russia
  5 | Ritchie Blackmore    |       | Russia
(5 rows)
```
P.S. В данной задаче ошибся с последовательостью столбцов в связи с чем пришлось указывать отдельно именно те столбцы в которые необходимо внести данные.

- вычислите количество записей для каждой таблицы 
- приведите в ответе:
  - запросы 
  - результаты их выполнения
  
```sql
test_db=# select count(*) from orders;
 count
-------
     5
(1 row)

test_db=# select count(*) from clients;
 count
-------
     5
(1 row)
```

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказка - используйте директиву `UPDATE`.

### Решение

```sql
test_db=# update clients set заказ = (select id from orders where наименование = 'Книга') where фамилия = 'Иванов Иван Иванович';
UPDATE 1
test_db=# update clients set заказ = (select id from orders where наименование = 'Монитор') where фамилия = 'Петров Петр Петрович';
UPDATE 1
test_db=# update clients set заказ = (select id from orders where наименование = 'Гитара') where фамилия = 'Иоганн Себастьян Бах';
UPDATE 1
test_db=# select c.* from clients c join orders o on c.заказ = o.id;
 id |       фамилия        | заказ | страна проживания
----+----------------------+-------+-------------------
  1 | Иванов Иван Иванович |     3 | USA
  2 | Петров Петр Петрович |     4 | Canada
  3 | Иоганн Себастьян Бах |     5 | Japan
(3 rows)
```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

### Решение

```sql
test_db=# explain select c.* from clients c join orders o on c.заказ = o.id;
                              QUERY PLAN
-----------------------------------------------------------------------
 Hash Join  (cost=25.98..41.29 rows=420 width=164)
   Hash Cond: (c."заказ" = o.id)
   ->  Seq Scan on clients c  (cost=0.00..14.20 rows=420 width=164)
   ->  Hash  (cost=17.10..17.10 rows=710 width=4)
         ->  Seq Scan on orders o  (cost=0.00..17.10 rows=710 width=4)
(5 rows)
```

1. Будет построчно прочитана таблица orders
2. Для данной таблицы будет создан хэш по олю id
3. Будет построчно прочитана таблица clients
4. Для каждой строке по полю "заказ" будет проверено, соответствует ли она чему-то в хэше orders
- если соответствия нет - строка будет пропущена
- если соответствие есть, то на основе всех подходящих строк хэша postres сформирует вывод


## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

### Решение
Есть несколько вариантов решения опишу некоторые из них:

1. внутри docker контейнера:
```commandline
root@d947ec9a578c:/# export PGPASSWORD=netology && pg_dumpall -h localhost -U test-admin-user > /media/postgresql/backup/all_$(date --iso-8601=m | sed 's/://g; s/+/z/g').backup
root@d947ec9a578c:/# ls /media/postgresql/backup/
all_2023-04-12T0521z0000.backup
root@d947ec9a578c:/# exit
exit
root@pve-test:~# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED        STATUS        PORTS                    NAMES
d947ec9a578c   postgres:12   "docker-entrypoint.s…"   21 hours ago   Up 21 hours   0.0.0.0:5432->5432/tcp   psql
root@pve-test:~# cd /postgres/
root@pve-test:/postgres# docker-compose stop
Stopping psql ... done
root@pve-test:/postgres# docker run --rm -d -e POSTGRES_USER=test-admin-user -e POSTGRES_PASSWORD=netology -e POSTGRES_DB=test_db -v /var/lib/docker/volumes/postgres_backup/_data:/media/postgresql/backup --name postgres_copy postgres:12
58949b6e6acba85ade5523fdb0e1adca6ddd5274889bc12eb31e7a9b6644ccb4
root@pve-test:/postgres# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                      PORTS      NAMES
58949b6e6acb   postgres:12   "docker-entrypoint.s…"   29 seconds ago   Up 29 seconds               5432/tcp   postgres_copy
d947ec9a578c   postgres:12   "docker-entrypoint.s…"   21 hours ago     Exited (0) 12 minutes ago              psql
root@pve-test:/postgres# docker exec -it postgres_copy bash
root@58949b6e6acb:/# ls /media/postgresql/backup/
all_2023-04-12T0521z0000.backup
root@58949b6e6acb:/# export PGPASSWORD=netology && psql -h localhost -U test-admin-user -f $(ls -1trh /media/postgresql/backup/all_*.backup) test_db
SET
SET
SET
psql:/media/postgresql/backup/all_2023-04-12T0521z0000.backup:14: ERROR:  role "test-admin-user" already exists
ALTER ROLE
CREATE ROLE
ALTER ROLE
You are now connected to database "template1" as user "test-admin-user".
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
You are now connected to database "postgres" as user "test-admin-user".
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
psql:/media/postgresql/backup/all_2023-04-12T0521z0000.backup:110: ERROR:  database "test_db" already exists
ALTER DATABASE
You are now connected to database "test_db" as user "test-admin-user".
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
COPY 5
COPY 5
 setval
--------
      1
(1 row)

 setval
--------
      1
(1 row)

ALTER TABLE
ALTER TABLE
ALTER TABLE
GRANT
GRANT
```
2. С хоста (чаще использую этот метод)
```code

root@pve-test:/postgres# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED        STATUS          PORTS                    NAMES
d947ec9a578c   postgres:12   "docker-entrypoint.s…"   22 hours ago   Up 34 seconds   0.0.0.0:5432->5432/tcp   psql
root@pve-test:/postgres# docker exec -it d94 pg_dump -U test-admin-user test_db --file /media/postgresql/backup/all_$(date --iso-8601=m | sed 's/://g; s/+/z/g').backup
root@pve-test:/postgres# docker run --rm -d -e POSTGRES_USER=test-admin-user -e POSTGRES_PASSWORD=netology -e POSTGRES_DB=test_db -v /var/lib/docker/volumes/postgres_backup/_data:/media/postgresql/backup --name postgres_copy postgres:12
298d0f336eb12b348d82b9138d9d3d46f2cc7f6b1103ba07fa67085af300e35b
root@pve-test:~# docker exec -i 298 psql -U test-admin-user test_db -f /media/postgresql/backup/all_2023-04-12T1349z0700.backup
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
COPY 5
COPY 5
 setval
--------
      1
(1 row)

 setval
--------
      1
(1 row)

ALTER TABLE
ALTER TABLE
ALTER TABLE
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
