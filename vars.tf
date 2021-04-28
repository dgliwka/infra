variable "user_ocid" {
  description = "user_ocid"
  type        = string
}

variable "tenancy_ocid" {
  description = "tenancy_ocid"
  type        = string
}

variable "compartment_ocid" {
  description = "compartment ocid where to create all resources"
  type        = string
}

variable "fingerprint" {
  description = "fingerprint"
}

variable "private_key_path" {
  description = "private_key_path"
}

variable "region" {
  description = "region"
}

variable "ssh_authorized_keys_file" {
  description = "Public SSH keys path to be included in the ~/.ssh/authorized_keys file for the default user on the instance"
  type        = string
}

variable "vps" {
  description = "List of instance names"
  type        = list(string)
}

variable "do_token" {
  type = string
}

variable "api_endpoint" {
  type = string
}

variable "domain" {
  type = string
}
