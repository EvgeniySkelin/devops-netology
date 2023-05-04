# Домашнее задание по лекции "3.8 Компьютерные сети (лекция 3)"
## 1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```shell
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```
### Решение:
```
route-views>sh ip route 158.46.96.191
Routing entry for 158.46.0.0/17
  Known via "bgp 6447", distance 20, metric 0
  Tag 2497, type external
  Last update from 202.232.0.2 2w2d ago
  Routing Descriptor Blocks:
  * 202.232.0.2, from 202.232.0.2, 2w2d ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 2497
      MPLS label: none
route-views>show bgp 158.46.96.191
BGP routing table entry for 158.46.0.0/17, version 1861760429
Paths: (24 available, best #21, table default)
  Not advertised to any peer
  Refresh Epoch 1
  53767 174 31133 39927, (aggregated by 39927 95.181.0.77)
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 174:21101 174:22005 53767:5000
      path 7FE0A708C360 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20912 3257 28917 28917 28917 28917 28917 28917 28917 48858 48858 48858 39927 39927, (aggregated by 39927 95.181.0.77)
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 3257:4000 3257:8092 3257:50001 3257:50111 3257:54800 3257:54801 20912:65004
      path 7FE09DAFE4D0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3561 3910 3356 3216 39927, (aggregated by 39927 95.181.0.77)
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      path 7FE0CF4BFB60 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  701 1273 3216 39927, (aggregated by 39927 95.181.0.77)
    137.39.3.55 from 137.39.3.55 (137.39.3.55)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      path 7FE0FB8A6EC8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  8283 1299 39927, (aggregated by 39927 95.181.0.78)
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin IGP, metric 0, localpref 100, valid, external, atomic-aggregate
      Community: 1299:30000 8283:1 8283:101
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001
      path 7FE00A68F078 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 3216 39927, (aggregated by 39927 95.181.0.77)
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external, atomic-aggregate
      Community: 3216:2001 3216:4442 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067
      path 7FE025C578C8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3267 31133 39927, (aggregated by 39927 95.181.0.77)
    194.85.40.15 from 194.85.40.15 (185.141.126.1)
      Origin IGP, metric 0, localpref 100, valid, external, atomic-aggregate
      path 7FE0C7522608 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3549 3356 3216 39927, (aggregated by 39927 95.181.0.77)
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external, atomic-aggregate
      Community: 3216:2001 3216:4442 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 3549:2581 3549:30840
      path 7FE118175C30 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 31133 39927, (aggregated by 39927 95.181.0.77)
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      path 7FE1616FC910 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7018 1299 39927, (aggregated by 39927 95.181.0.78)
    12.0.1.63 from 12.0.1.63 (12.0.1.63)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 7018:5000 7018:37232
      path 7FE01D38D1E0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  19214 174 31133 39927, (aggregated by 39927 95.181.0.77)
    208.74.64.40 from 208.74.64.40 (208.74.64.40)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 174:21101 174:22005
      path 7FE0FEDE2370 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20130 6939 3216 39927, (aggregated by 39927 95.181.0.77)
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      path 7FE10E9A43B0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  4901 6079 31133 39927, (aggregated by 39927 95.181.0.77)
    162.250.137.254 from 162.250.137.254 (162.250.137.254)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 65000:10100 65000:10300 65000:10400
      path 7FE1144B3A20 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  101 3491 20485 20485 39927, (aggregated by 39927 95.181.0.77)
    209.124.176.223 from 209.124.176.223 (209.124.176.223)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 101:20300 101:22100 3491:300 3491:311 3491:9001 3491:9080 3491:9081 3491:9087 3491:62210 3491:62220 20485:10042
      path 7FE0C6EE3F28 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1351 6939 3216 39927, (aggregated by 39927 95.181.0.77)
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      path 7FE07CEC25F8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  57866 9002 48858 48858 48858 39927 39927, (aggregated by 39927 95.181.0.77)
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external, atomic-aggregate
      Community: 9002:0 9002:64667
      path 7FE053CF3120 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  852 31133 39927, (aggregated by 39927 95.181.0.77)
    154.11.12.212 from 154.11.12.212 (96.1.209.43)
      Origin IGP, metric 0, localpref 100, valid, external, atomic-aggregate
      path 7FE13720BFB8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3303 31133 39927, (aggregated by 39927 95.181.0.77)
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 0:15169 3303:1004 3303:1006 3303:1030 3303:3056 31133:26149
      path 7FE10CE5A350 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  6939 3216 39927, (aggregated by 39927 95.181.0.77)
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      path 7FE026FDE870 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7660 2516 12389 39927, (aggregated by 39927 95.181.0.78)
    203.181.248.168 from 203.181.248.168 (203.181.248.168)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 2516:1050 7660:9003
      path 7FE17145ABC8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 2
  2497 12389 39927, (aggregated by 39927 95.181.0.78)
    202.232.0.2 from 202.232.0.2 (58.138.96.254)
      Origin IGP, localpref 100, valid, external, atomic-aggregate, best
      path 7FE0BE6A28D8 RPKI State not found
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  49788 12552 31133 39927, (aggregated by 39927 95.181.0.77)
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 12552:12000 12552:12100 12552:12101 12552:22000
      Extended Community: 0x43:100:1
      path 7FE014BA9250 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1221 4637 3216 39927, (aggregated by 39927 95.181.0.77)
    203.62.252.83 from 203.62.252.83 (203.62.252.83)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      path 7FE0DD111048 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3257 28917 28917 28917 28917 28917 28917 28917 48858 48858 48858 39927 39927, (aggregated by 39927 95.181.0.77)
    89.149.178.10 from 89.149.178.10 (213.200.83.26)
      Origin IGP, metric 10, localpref 100, valid, external, atomic-aggregate
      Community: 3257:4000 3257:8092 3257:50001 3257:50111 3257:54800 3257:54801
      path 7FE096468D28 RPKI State not found
      rx pathid: 0, tx pathid: 0
```
## 2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
### Решение:
```shell
vagrant@vagrant:~$ sudo nano /etc/netplan/02-dymmy.yaml
network:
  version: 2
  renderer: networkd
  bridges:
    dummy0:
      dhcp4: no
      dhcp6: no
      accept-ra: no
      interfaces: [ ]
      addresses:
        - 169.254.1.1/32
vagrant@vagrant:~$ sudo netplan apply
vagrant@vagrant:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:b1:28:5d brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
       valid_lft 86396sec preferred_lft 86396sec
    inet6 fe80::a00:27ff:feb1:285d/64 scope link
       valid_lft forever preferred_lft forever
3: dummy0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether aa:4c:cc:ac:c1:23 brd ff:ff:ff:ff:ff:ff
    inet 169.254.1.1/32 scope global dummy0
       valid_lft forever preferred_lft forever
    inet6 fe80::a84c:ccff:feac:c123/64 scope link
       valid_lft forever preferred_lft forever
```
## 3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.
### Решение:
```
State    Recv-Q   Send-Q     Local Address:Port     Peer Address:Port   Process
LISTEN   0        511              0.0.0.0:80            0.0.0.0:*       users:(("nginx",pid=1857,fd=6),("nginx",pid=1856,fd=6),("nginx",pid=1855,fd=6))
LISTEN   0        4096       127.0.0.53%lo:53            0.0.0.0:*       users:(("systemd-resolve",pid=609,fd=13))
LISTEN   0        128              0.0.0.0:22            0.0.0.0:*       users:(("sshd",pid=865,fd=3))
ESTAB    0        0              10.0.2.15:22           10.0.2.2:25699   users:(("sshd",pid=1178,fd=4),("sshd",pid=1141,fd=4))
LISTEN   0        511                 [::]:80               [::]:*       users:(("nginx",pid=1857,fd=7),("nginx",pid=1856,fd=7),("nginx",pid=1855,fd=7))
LISTEN   0        128                 [::]:22               [::]:*       users:(("sshd",pid=865,fd=4))
```
Примеры: 80 порт открыт Nginx, 22 порт SSH, внутренняя служба разрешения доменных имен на 53 
порту loopback интерфейса

## 4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?
### Решение:
```
vagrant@vagrant:~$ sudo ss -paun
State       Recv-Q      Send-Q            Local Address:Port           Peer Address:Port     Process
UNCONN      0           0                 127.0.0.53%lo:53                  0.0.0.0:*         users:(("systemd-resolve",pid=609,fd=12))
UNCONN      0           0                10.0.2.15%eth0:68                  0.0.0.0:*         users:(("systemd-network",pid=1405,fd=20))
UNCONN      0           0                       0.0.0.0:111                 0.0.0.0:*         users:(("rpcbind",pid=608,fd=5),("systemd",pid=1,fd=84))
UNCONN      0           0                          [::]:111                    [::]:*         users:(("rpcbind",pid=608,fd=7),("systemd",pid=1,fd=86))
```
Аналогичная внутренняя служба доменных имен на loopback интерфейсе 53 UDP порт, Bootstrap Protocol Client - 68 порт, rpcbind на 111 udp порту

## 5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.
### Решение:
К сожалению у меня не сохранилась L3 схема с прошлой работы, а на текущей она еще не составлена, могу предоставить схему текущую схему L2. Построенную на Dude от Mikrotik.

![Main.png](images/Main.png)
