output "instance_ips" {
  value = oci_core_instance.vps_zurich.*.public_ip
}
