# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql

### Решение
- Используя docker поднимите инстанс PostgreSQL:

```dockerfile
version: '3.6'
volumes:
  data: {}
  backup: {}
services:
  postgres:
    restart: always
    image: postgres:13
    container_name: postgres
    ports:
      - "5432:5432"
    volumes:
      - data:/var/lib/postgresql/data
      - backup:/media/postgresql/backup
    environment:
      POSTGRES_USER: "netology"
      POSTGRES_PASSWORD: "netology"
```

- Подключитесь к БД PostgreSQL используя `psql`:

```commandline
root@pve-test:/postgres# docker exec -it postgres psql -U netology
psql (13.10 (Debian 13.10-1.pgdg110+1))
Type "help" for help.

netology=#
```

- вывода списка БД:

```text
netology=# \l
```

- подключения к БД:

```text
netology=# \conninfo
```

<details><summary>вывода списка таблиц:</summary>

```text
netology=# \dtS
```
</details>

<details><summary>вывода описания содержимого таблиц:</summary>

```text
netology=# \dS+
```
</details>

- выхода из psql:

```commandline
netology=# \q
```

## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

### Решение

- Используя `psql` создайте БД `test_database`:

```commandline
netology=# CREATE DATABASE test_database;
CREATE DATABASE
```

- Восстановите бэкап БД в `test_database`.

```commandline
root@pve-test:~# docker exec -it postgres bash
root@5ee3d0be18f4:/# psql -U netology -f /media/postgresql/backup/test_dump.sql test_database
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
psql:/media/postgresql/backup/test_dump.sql:34: ERROR:  role "postgres" does not exist
CREATE SEQUENCE
psql:/media/postgresql/backup/test_dump.sql:49: ERROR:  role "postgres" does not exist
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval
--------
      8
(1 row)

ALTER TABLE
```

- Перейдите в управляющую консоль `psql` внутри контейнера:

```commandline
root@5ee3d0be18f4:/# psql -U netology
psql (13.10 (Debian 13.10-1.pgdg110+1))
Type "help" for help.

netology=#
```

- Подключитесь к восстановленной БД и проведите операцию ANALYZE:

```commandline
netology=# \c test_database
You are now connected to database "test_database" as user "netology".
test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner
--------+--------+-------+----------
 public | orders | table | netology
(1 row)

test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```

- Используя таблицу pg_stats, найдите столбец таблицы orders:

```text
test_database=# SELECT avg_width FROM pg_stats WHERE tablename='orders';
 avg_width
-----------
         4
        16
         4
(3 rows)
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

### Решение

- Предложите SQL-транзакцию для проведения операции:

```text
test_database=# CREATE TABLE orders_1 (CHECK (price > 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO orders_1 SELECT * FROM orders WHERE price > 499;
INSERT 0 3
test_database=# CREATE TABLE orders_2 (CHECK (price <= 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO orders_2 SELECT * FROM orders WHERE price <= 499;
INSERT 0 5
test_database=# DELETE FROM ONLY orders;
DELETE 8
test_database=# \dt
          List of relations
 Schema |   Name   | Type  |  Owner
--------+----------+-------+----------
 public | orders   | table | netology
 public | orders_1 | table | netology
 public | orders_2 | table | netology
(3 rows)
```

- Можно ли было изначально исключить "ручное" разбиение:

Да можно. Необходимо было прописать правила вставки как пример:
```commandline
test_database=# CREATE RULE orders_up_to_500 AS ON INSERT TO orders WHERE ( price <= 499 ) DO INSTEAD
INSERT INTO orders_1 VALUES (NEW.*);
CREATE RULE
test_database=# CREATE RULE orders_from_500 AS ON INSERT TO orders WHERE ( price > 499 ) DO INSTEAD INSERT INTO orders_2 VALUES (NEW.*);
CREATE RULE
```

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

### Решение

- создайте бекап БД:

```commandline
root@5ee3d0be18f4:/# export PGPASSWORD=netology && pg_dump -h localhost -U netology test_database > /mroot@5ee3d0be18f4:/# export PGPASSWORD=netology && pg_dump -h localhost -U netology test_database > /media/postgresql/backup/newbackup.sql
root@5ee3d0be18f4:/# cd /media/postgresql/backup/
root@5ee3d0be18f4:/media/postgresql/backup#
root@5ee3d0be18f4:/media/postgresql/backup# ls
newbackup.sql  test_dump.sql
root@5ee3d0be18f4:/media/postgresql/backup# exit
exit
root@pve-test:~# ls /var/lib/docker/volumes/postgres_backup13/_data/
newbackup.sql  test_dump.sql
```

- Как бы вы доработали бэкап-файл:

Можно добавить свойство UNIQUE например так:

```text
title character varying(80) NOT NULL UNIQUE,
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---