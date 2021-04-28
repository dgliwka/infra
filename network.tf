resource "oci_core_vcn" "default_vcn" {
    cidr_block               = "10.0.0.0/16"
    compartment_id           = var.compartment_ocid
    display_name             = "Default vcn"
}

resource "oci_core_subnet" "default_subnet" {
    cidr_block                 = "10.0.0.0/24"
    compartment_id             = var.compartment_ocid
    display_name               = "Default subnet"
    security_list_ids          = [
        oci_core_security_list.default_security_list.id,
    ]
    vcn_id                     = oci_core_vcn.default_vcn.id
    route_table_id   = oci_core_route_table.default_route_table.id
}

resource "oci_core_security_list" "default_security_list" {
    compartment_id = var.compartment_ocid
    display_name   = "Allow everything"
    vcn_id         = oci_core_vcn.default_vcn.id

    egress_security_rules {
        destination      = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
        protocol         = "all"
        stateless        = false
    }

    ingress_security_rules {
        description = "Allow all incoming traffic"
        protocol    = "all"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"
        stateless   = false
    }
}

resource "oci_core_route_table" "default_route_table" {
    compartment_id = var.compartment_ocid
    display_name   = "Default Route Table"
    vcn_id         = oci_core_vcn.default_vcn.id

    route_rules {
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
        network_entity_id = oci_core_internet_gateway.default_internet_gateway.id
    }
}

resource "oci_core_internet_gateway" "default_internet_gateway" {
    compartment_id = var.compartment_ocid
    display_name   = "Default internet gateway"
    enabled        = true
    vcn_id         = oci_core_vcn.default_vcn.id
}
