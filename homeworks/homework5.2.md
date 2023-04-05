# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами".

## Задача 1
* Опишите своими словами основные преимущества применения на практике IaaC паттернов.
* Какой из принципов IaaC является основополагающим?

### Ответ:
Основными преимущества IaaC являются обеспечение стабильности среды, уверенность в том что любая новая система будет
идентичной предыдущей, так же использование IaaC позволяет ускорить процесс развертывания сред, и ускорить процесс их
изменения, что ускоряет процесс разработки, что в конечном счете приводит к ускорению вывода продукта на рынок. Так же это упрощает администрирования системы, т.е. в случае выхода из строя какого либо из серверов его можно быстро заменить. Из практики вышел из строя сервер проекта на восстановление ушло примерно 20-30 мин (включая развертывание копии БД mysql) в случае работы бе IaaC времени понадобилось бы примерно 3-4 часа.

Основополагающим принципом IaaC, является автоматизация любого действие которое
требует повторений, что позволяет не отвлекаться на рутинные процессы, а заниматься более важными задачами. Так же из практики при работе в розницной сети магазинов было много новых открытий и приходилось каждый раз настраивать роутеры. Был написан скрипт для автоматического создания конфигурации при внесении минимальных данных от администратора (такие как данные провадера и подсеть конкретной точки) все остальное конфигурировалось автоматически (Включая VPN, маршруты и т.д.), что привело к сокращению времени на выполнение данной задачи с 1,5 часов до 7-10 мин.

## Задача 2
* Чем Ansible выгодно отличается от других систем управление конфигурациями?
* Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

### Ответ:
Выгодное отличие Ansible в том что в работе он использует SSH и не требует для своей работы дополнительных PKI 
окружений, или установки каких либо дополнительных инструментов.

С точки зрения надежности, метод Push имеет преимущества: он возможен в использовании без применения дополнительных
инструментов на стороне клиента, так же он проще в мониторинге результата развертывания конфигурации (с Pull, без
дополнительных средств мониторинга мы не всегда можем быть уверены в успешном развертывании конфигурации).   
Есть и минусы. При Push в случае компрометации ключа появится 
возможность получить доступ к целевым серверам кластера, в то время как при Pull сервера кластера могут не иметь 
административный доступ к самому кластеру, что при компрометации не позволить положить всю систему.   
Для примера, по похожему принципу у нас в компании обеспечена передача резервных копий в долгосрочное хранилище,
источники резервных копий отправляют через Push резервные копии на промежуточный сервер, далее методом Pull резервные 
копии с промежуточного сервера забираются в долговременное хранилище, таким образом в долговременное хранилище 
невозможно получить какой-либо доступ с использованием служебных учетных записей.

## Задача 3
Установить на личный компьютер:
* VirtualBox
* Vagrant
* Ansible
* Terraform
_Приложить вывод команд установленных версий каждой из программ, оформленный в markdown._

## Задача 4 

Воспроизведите практическую часть лекции самостоятельно.

- Создайте виртуальную машину.
- Зайдите внутрь ВМ, убедитесь, что Docker установлен с помощью команды
```
docker ps,
```
Vagrantfile из лекции и код ansible находятся в [папке](https://github.com/netology-code/virt-homeworks/tree/virt-11/05-virt-02-iaac/src).

Примечание. Если Vagrant выдаёт ошибку:
```
URL: ["https://vagrantcloud.com/bento/ubuntu-20.04"]     
Error: The requested URL returned error: 404:
```

выполните следующие действия:

1. Скачайте с [сайта](https://app.vagrantup.com/bento/boxes/ubuntu-20.04) файл-образ "bento/ubuntu-20.04".
2. Добавьте его в список образов Vagrant: "vagrant box add bento/ubuntu-20.04 <путь к файлу>".

### Ответ:
Вывод vagrant up и docker ps:

```shell
skelin_ei@homework30:~/vagrant$ vboxmanage --version
6.1.34_Ubuntur150636
skelin_ei@homework30:~/vagrant$ vagrant --version
Vagrant 2.2.6
skelin_ei@homework30:~/vagrant$ terraform -v
Terraform v1.4.4
skelin_ei@homework30:~/vagrant$ ansible --version
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/skelin_ei/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Sep 28 2021, 16:10:42) [GCC 9.3.0]

``` code
root@pve-test:~/vagrant/homework5.2# vagrant destroy
    server1.netology: Are you sure you want to destroy the 'server1.netology' VM? [y/N] y
==> server1.netology: Forcing shutdown of VM...
==> server1.netology: Destroying VM and associated drives...
root@pve-test:~/vagrant/homework5.2# vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
==> server1.netology: Matching MAC address for NAT networking...
==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202303.13.0' is up to date...
==> server1.netology: Setting the name of the VM: server1.netology
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: private key
    server1.netology: Warning: Connection reset. Retrying...
    server1.netology: Warning: Remote connection disconnect. Retrying...
    server1.netology:
    server1.netology: Vagrant insecure key detected. Vagrant will automatically replace
    server1.netology: this with a newly generated keypair for better security.
    server1.netology:
    server1.netology: Inserting generated public key within guest...
    server1.netology: Removing insecure key from the guest if it's present...
    server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...
==> server1.netology: Machine booted and ready!
==> server1.netology: Checking for guest additions in VM...
==> server1.netology: Setting hostname...
==> server1.netology: Configuring and enabling network interfaces...
==> server1.netology: Mounting shared folders...
    server1.netology: /vagrant => /root/vagrant/homework5.2
==> server1.netology: Running provisioner: ansible...
    server1.netology: Running ansible-playbook...
[WARNING]: Ansible is being run in a world writable directory
(/root/vagrant/homework5.2), ignoring it as an ansible.cfg source. For more
information see
https://docs.ansible.com/ansible/devel/reference_appendices/config.html#cfg-in-
world-writable-dir

PLAY [nodes] *******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [server1.netology]

TASK [Create directory for ssh-keys] *******************************************
ok: [server1.netology]

TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
changed: [server1.netology]

TASK [Checking DNS] ************************************************************
changed: [server1.netology]

TASK [Installing tools] ********************************************************
[DEPRECATION WARNING]: Invoking "apt" only once while using a loop via
squash_actions is deprecated. Instead of using a loop to supply multiple items
and specifying `package: "{{ item }}"`, please use `package: ['git', 'curl',
'docker']` and remove the loop. This feature will be removed from ansible-base
in version 2.11. Deprecation warnings can be disabled by setting
deprecation_warnings=False in ansible.cfg.
ok: [server1.netology] => (item=['git', 'curl', 'docker'])

TASK [Installing docker] *******************************************************
[WARNING]: Consider using the file module with mode rather than running
'chmod'.  If you need to use command because file is insufficient you can add
'warn: false' to this command task or set 'command_warnings=False' in
ansible.cfg to get rid of this message.
changed: [server1.netology]

TASK [Add the current user to docker group] ************************************
changed: [server1.netology]

PLAY RECAP *********************************************************************
server1.netology           : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

root@pve-test:~/vagrant/homework5.2# vagrant ssh
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-144-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Wed 05 Apr 2023 09:07:45 AM UTC

  System load:  0.3                Users logged in:          0
  Usage of /:   13.4% of 30.34GB   IPv4 address for docker0: 172.17.0.1
  Memory usage: 26%                IPv4 address for eth0:    10.0.2.15
  Swap usage:   0%                 IPv4 address for eth1:    192.168.56.11
  Processes:    139

 * Introducing Expanded Security Maintenance for Applications.
   Receive updates to over 25,000 software packages with your
   Ubuntu Pro subscription. Free for personal use.

     https://ubuntu.com/pro


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Wed Apr  5 09:07:14 2023 from 10.0.2.2
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
