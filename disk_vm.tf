resource "yandex_compute_disk" "disk" {
  count           = 3
  name            = "disk-${count.index+1}"
  size            = 5
  zone            = var.default_zone
}

data "yandex_compute_image" "ubuntu-storage" {
  family = var.vm_web_platform
}

resource "yandex_compute_instance" "disk_vm" {
  name            = "storage"
  platform_id     = var.vm_web_server
    resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-storage.image_id
    }
  }
  dynamic "secondary_disk" {
    for_each      = yandex_compute_disk.disk
    content {
      device_name = secondary_disk.value.name
      disk_id     = secondary_disk.value.id
    }
  }
  scheduling_policy {
    preemptible   = true
  }
  network_interface {
    subnet_id     = yandex_vpc_subnet.develop.id
    nat           = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh-key}"
  }
}