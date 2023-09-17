resource "local_file" "VM_hosts_conf" {
depends_on   = [ 
  yandex_compute_instance.count,
  yandex_compute_instance.disk_vm,
  yandex_compute_instance.forearch,
  ]
  content = templatefile("${path.cwd}/hosts.tftpl",
    {
      count      = yandex_compute_instance.count[*]
      disk_vm    = yandex_compute_instance.disk_vm[*]
      forearch   = yandex_compute_instance.forearch
    }
  )
  filename = "${abspath(path.cwd)}/hosts.cfg"


}

resource "null_resource" "anssible" {
  depends_on   = [ 
    yandex_compute_instance.count,
    yandex_compute_instance.disk_vm,
    yandex_compute_instance.forearch,
    ]

  provisioner "local-exec" {
    command    = "cat ~/.ssh/id_rsa | ssh-add -"
  }

  provisioner "local-exec" {
    command    = "sleep 60"
  }

  provisioner "local-exec" {                  
    command    = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.cwd)}/hosts.cfg ${abspath(path.cwd)}/test.yml"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
}
