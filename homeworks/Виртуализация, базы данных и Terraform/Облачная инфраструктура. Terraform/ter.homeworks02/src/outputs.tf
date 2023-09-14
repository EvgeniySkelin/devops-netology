output "platform" {
    value = yandex_compute_instance.platform.network_interface.0.nat_ip_address
}
output "platformdb" {
    value = yandex_compute_instance.platformdb.network_interface.0.nat_ip_address
}