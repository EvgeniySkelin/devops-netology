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
  datav13: {}
  backupv13: {}
services:
  postgres:
    restart: always
    image: postgres:13
    container_name: postgres
    ports:
      - "5432:5432"
    volumes:
      - datav13:/var/lib/postgresql/data
      - backupv13:/media/postgresql/backup
    environment:
      POSTGRES_USER: "netology"
      POSTGRES_PASSWORD: "netology"
```

- Подключитесь к БД PostgreSQL используя `psql`:

```commandline
root@homework30:/postgres# docker exec -it postgres psql -U netology
psql (13.8 (Debian 13.8-1.pgdg110+1))
Type "help" for help.

netology=#
```

- вывода списка БД:

```text
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   |  Size   | Tablespace |
   Description
-----------+----------+----------+------------+------------+-----------------------+---------+------------+-------------
-------------------------------
 netology  | netology | UTF8     | en_US.utf8 | en_US.utf8 |                       | 7901 kB | pg_default |
 postgres  | netology | UTF8     | en_US.utf8 | en_US.utf8 |                       | 7753 kB | pg_default | default admi
nistrative connection database
 template0 | netology | UTF8     | en_US.utf8 | en_US.utf8 | =c/netology          +| 7753 kB | pg_default | unmodifiable
 empty database
           |          |          |            |            | netology=CTc/netology |         |            |
 template1 | netology | UTF8     | en_US.utf8 | en_US.utf8 | =c/netology          +| 7753 kB | pg_default | default temp
late for new databases
           |          |          |            |            | netology=CTc/netology |         |            |
(4 rows)
```

- подключения к БД:

```text
netology=# \conninfo
You are connected to database "netology" as user "netology" via socket in "/var/run/postgresql" at port "5432".
```

<details><summary>вывода списка таблиц:</summary>

```text
netology=# \dtS
                    List of relations
   Schema   |          Name           | Type  |  Owner
------------+-------------------------+-------+----------
 pg_catalog | pg_aggregate            | table | netology
 pg_catalog | pg_am                   | table | netology
 pg_catalog | pg_amop                 | table | netology
 pg_catalog | pg_amproc               | table | netology
 pg_catalog | pg_attrdef              | table | netology
 pg_catalog | pg_attribute            | table | netology
 pg_catalog | pg_auth_members         | table | netology
 pg_catalog | pg_authid               | table | netology
 pg_catalog | pg_cast                 | table | netology
 pg_catalog | pg_class                | table | netology
 pg_catalog | pg_collation            | table | netology
 pg_catalog | pg_constraint           | table | netology
 pg_catalog | pg_conversion           | table | netology
 pg_catalog | pg_database             | table | netology
 pg_catalog | pg_db_role_setting      | table | netology
 pg_catalog | pg_default_acl          | table | netology
 pg_catalog | pg_depend               | table | netology
 pg_catalog | pg_description          | table | netology
 pg_catalog | pg_enum                 | table | netology
 pg_catalog | pg_event_trigger        | table | netology
 pg_catalog | pg_extension            | table | netology
 pg_catalog | pg_foreign_data_wrapper | table | netology
 pg_catalog | pg_foreign_server       | table | netology
 pg_catalog | pg_foreign_table        | table | netology
 pg_catalog | pg_index                | table | netology
 pg_catalog | pg_inherits             | table | netology
 pg_catalog | pg_init_privs           | table | netology
 pg_catalog | pg_language             | table | netology
 pg_catalog | pg_largeobject          | table | netology
 pg_catalog | pg_largeobject_metadata | table | netology
 pg_catalog | pg_namespace            | table | netology
 pg_catalog | pg_opclass              | table | netology
 pg_catalog | pg_operator             | table | netology
 pg_catalog | pg_opfamily             | table | netology
 pg_catalog | pg_partitioned_table    | table | netology
 pg_catalog | pg_policy               | table | netology
 pg_catalog | pg_proc                 | table | netology
 pg_catalog | pg_publication          | table | netology
 pg_catalog | pg_publication_rel      | table | netology
 pg_catalog | pg_range                | table | netology
 pg_catalog | pg_replication_origin   | table | netology
 pg_catalog | pg_rewrite              | table | netology
 pg_catalog | pg_seclabel             | table | netology
 pg_catalog | pg_sequence             | table | netology
 pg_catalog | pg_shdepend             | table | netology
 pg_catalog | pg_shdescription        | table | netology
 pg_catalog | pg_shseclabel           | table | netology
 pg_catalog | pg_statistic            | table | netology
 pg_catalog | pg_statistic_ext        | table | netology
 pg_catalog | pg_statistic_ext_data   | table | netology
 pg_catalog | pg_subscription         | table | netology
 pg_catalog | pg_subscription_rel     | table | netology
 pg_catalog | pg_tablespace           | table | netology
 pg_catalog | pg_transform            | table | netology
 pg_catalog | pg_trigger              | table | netology
 pg_catalog | pg_ts_config            | table | netology
 pg_catalog | pg_ts_config_map        | table | netology
 pg_catalog | pg_ts_dict              | table | netology
 pg_catalog | pg_ts_parser            | table | netology
 pg_catalog | pg_ts_template          | table | netology
 pg_catalog | pg_type                 | table | netology
 pg_catalog | pg_user_mapping         | table | netology
(62 rows)
```
</details>

<details><summary>вывода описания содержимого таблиц:</summary>

```text
netology=# \dS+
                                            List of relations
   Schema   |              Name               | Type  |  Owner   | Persistence |    Size    | Descript
ion
------------+---------------------------------+-------+----------+-------------+------------+---------
----
 pg_catalog | pg_aggregate                    | table | netology | permanent   | 56 kB      |
 pg_catalog | pg_am                           | table | netology | permanent   | 40 kB      |
 pg_catalog | pg_amop                         | table | netology | permanent   | 80 kB      |
 pg_catalog | pg_amproc                       | table | netology | permanent   | 64 kB      |
 pg_catalog | pg_attrdef                      | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_attribute                    | table | netology | permanent   | 456 kB     |
 pg_catalog | pg_auth_members                 | table | netology | permanent   | 40 kB      |
 pg_catalog | pg_authid                       | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_available_extension_versions | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_available_extensions         | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_cast                         | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_class                        | table | netology | permanent   | 136 kB     |
 pg_catalog | pg_collation                    | table | netology | permanent   | 240 kB     |
 pg_catalog | pg_config                       | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_constraint                   | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_conversion                   | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_cursors                      | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_database                     | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_db_role_setting              | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_default_acl                  | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_depend                       | table | netology | permanent   | 488 kB     |
 pg_catalog | pg_description                  | table | netology | permanent   | 376 kB     |
 pg_catalog | pg_enum                         | table | netology | permanent   | 0 bytes    |
 pg_catalog | pg_event_trigger                | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_extension                    | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_file_settings                | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_foreign_data_wrapper         | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_foreign_server               | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_foreign_table                | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_group                        | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_hba_file_rules               | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_index                        | table | netology | permanent   | 64 kB      |
 pg_catalog | pg_indexes                      | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_inherits                     | table | netology | permanent   | 0 bytes    |
 pg_catalog | pg_init_privs                   | table | netology | permanent   | 56 kB      |
 pg_catalog | pg_language                     | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_largeobject                  | table | netology | permanent   | 0 bytes    |
 pg_catalog | pg_largeobject_metadata         | table | netology | permanent   | 0 bytes    |
 pg_catalog | pg_locks                        | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_matviews                     | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_namespace                    | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_opclass                      | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_operator                     | table | netology | permanent   | 144 kB     |
 pg_catalog | pg_opfamily                     | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_partitioned_table            | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_policies                     | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_policy                       | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_prepared_statements          | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_prepared_xacts               | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_proc                         | table | netology | permanent   | 688 kB     |
 pg_catalog | pg_publication                  | table | netology | permanent   | 0 bytes    |
 pg_catalog | pg_publication_rel              | table | netology | permanent   | 0 bytes    |
 pg_catalog | pg_publication_tables           | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_range                        | table | netology | permanent   | 40 kB      |
 pg_catalog | pg_replication_origin           | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_replication_origin_status    | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_replication_slots            | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_rewrite                      | table | netology | permanent   | 656 kB     |
 pg_catalog | pg_roles                        | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_rules                        | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_seclabel                     | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_seclabels                    | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_sequence                     | table | netology | permanent   | 0 bytes    |
 pg_catalog | pg_sequences                    | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_settings                     | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_shadow                       | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_shdepend                     | table | netology | permanent   | 40 kB      |
 pg_catalog | pg_shdescription                | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_shmem_allocations            | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_shseclabel                   | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_stat_activity                | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_all_indexes             | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_all_tables              | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_archiver                | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_bgwriter                | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_database                | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_database_conflicts      | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_gssapi                  | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_progress_analyze        | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_progress_basebackup     | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_progress_cluster        | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_progress_create_index   | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_progress_vacuum         | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_replication             | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_slru                    | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_ssl                     | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_subscription            | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_sys_indexes             | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_sys_tables              | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_user_functions          | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_user_indexes            | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_user_tables             | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_wal_receiver            | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_xact_all_tables         | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_xact_sys_tables         | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_xact_user_functions     | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stat_xact_user_tables        | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_statio_all_indexes           | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_statio_all_sequences         | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_statio_all_tables            | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_statio_sys_indexes           | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_statio_sys_sequences         | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_statio_sys_tables            | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_statio_user_indexes          | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_statio_user_sequences        | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_statio_user_tables           | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_statistic                    | table | netology | permanent   | 248 kB     |
 pg_catalog | pg_statistic_ext                | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_statistic_ext_data           | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_stats                        | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_stats_ext                    | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_subscription                 | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_subscription_rel             | table | netology | permanent   | 0 bytes    |
 pg_catalog | pg_tables                       | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_tablespace                   | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_timezone_abbrevs             | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_timezone_names               | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_transform                    | table | netology | permanent   | 0 bytes    |
 pg_catalog | pg_trigger                      | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_ts_config                    | table | netology | permanent   | 40 kB      |
 pg_catalog | pg_ts_config_map                | table | netology | permanent   | 56 kB      |
 pg_catalog | pg_ts_dict                      | table | netology | permanent   | 48 kB      |
 pg_catalog | pg_ts_parser                    | table | netology | permanent   | 40 kB      |
 pg_catalog | pg_ts_template                  | table | netology | permanent   | 40 kB      |
 pg_catalog | pg_type                         | table | netology | permanent   | 120 kB     |
 pg_catalog | pg_user                         | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_user_mapping                 | table | netology | permanent   | 8192 bytes |
 pg_catalog | pg_user_mappings                | view  | netology | permanent   | 0 bytes    |
 pg_catalog | pg_views                        | view  | netology | permanent   | 0 bytes    |
(129 rows)
```
</details>

- выхода из psql:

```commandline
netology=# \q
root@homework30:/postgres#
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
root@homework30:/postgres# docker exec -it postgres bash
root@5658e0ae7ccb:/# psql -U netology -f /media/postgresql/backup/test_dimp.sql test_database
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
psql:/media/postgresql/backup/test_dimp.sql:34: ERROR:  role "postgres" does not exist
CREATE SEQUENCE
psql:/media/postgresql/backup/test_dimp.sql:49: ERROR:  role "postgres" does not exist
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
root@5658e0ae7ccb:/# psql -U netology
psql (13.8 (Debian 13.8-1.pgdg110+1))
Type "help" for help.
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
test_database=#
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
root@5658e0ae7ccb:/# export PGPASSWORD=netology && pg_dump -h localhost -U netology test_database > /m
edia/postgresql/backup/newbackup.sql
root@5658e0ae7ccb:/# cd /media/postgresql/backup/
root@5658e0ae7ccb:/media/postgresql/backup# ls
newbackup.sql  test_dimp.sql
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