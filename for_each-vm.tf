data "yandex_compute_image" "ubuntu-forearch" {
  family   = var.vm_web_platform
}

resource "yandex_compute_instance" "forearch" {
  depends_on = [ yandex_compute_instance.count ]
  for_each = { for i in var.vm_resources : i.vm_name => i }
  name        = each.value.vm_name
  platform_id = var.vm_web_server
    resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-forearch.image_id
      size = each.value.disk
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh-key}"
  }
}