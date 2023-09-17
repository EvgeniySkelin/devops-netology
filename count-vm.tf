data "yandex_compute_image" "ubuntu-count" {
  family   = var.vm_web_platform
}

resource "yandex_compute_instance" "count" {
  count       = 2
  name        = "web-${count.index+1}"
  platform_id = var.vm_web_server
    resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-count.image_id
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