resource "oci_core_instance" "vps_zurich" {
  count = 2

  availability_domain = "QKyX:EU-ZURICH-1-AD-1"
  compartment_id      = var.compartment_ocid
  display_name        = var.vps[count.index]
  fault_domain        = "FAULT-DOMAIN-1"
  metadata = {
    "ssh_authorized_keys" = file(var.ssh_authorized_keys_file)
  }
  shape = "VM.Standard.E2.1.Micro"

  agent_config {
    are_all_plugins_disabled = true
    is_management_disabled   = false
    is_monitoring_disabled   = false

    plugins_config {
      desired_state = "DISABLED"
      name          = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Compute Instance Monitoring"
    }
  }

  create_vnic_details {
    assign_public_ip       = "true"
    display_name           = var.vps[count.index]
    private_ip             = "10.0.0.${count.index+2}"
    subnet_id              = oci_core_subnet.default_subnet.id
  }

  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = true
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }

  source_details {
    boot_volume_size_in_gbs = "50"
    source_id               = "ocid1.image.oc1.eu-zurich-1.aaaaaaaacfqvwggf3xiwenw3tfu6bjrrcqoroms5fw7ficzto7qvcfu357nq"
    source_type             = "image"
  }

}
