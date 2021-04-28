resource "digitalocean_record" "wildcard" {
  domain = var.domain
  type   = "CNAME"
  name   = "*"
  value  = "${var.domain}."
  ttl    = 300
}

locals {
subdomains = {
              "@": "158.101.164.133",
              "k": "139.59.206.161",
              "cat": oci_core_instance.vps_zurich[0].public_ip,
              "dog": oci_core_instance.vps_zurich[1].public_ip,
              }
}

resource "digitalocean_record" "subdomains" {
  for_each = local.subdomains

  domain = var.domain
  type   = "A"
  name   = each.key
  value  = each.value
  ttl    = 300
}
