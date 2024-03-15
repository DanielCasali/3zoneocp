

resource "ibm_pi_network" "power_networks" {
  pi_network_name      = "power-network"
  pi_cloud_instance_id = var.this_workspace_id
  pi_network_type      = "vlan"
  pi_cidr              = var.this_network_cidr
  pi_dns               = [var.internal_vpc_dns1,var.internal_vpc_dns2]
  pi_gateway           = var.this_network_gw
  pi_ipaddress_range {
    pi_starting_ip_address  = var.this_net_start_ip
    pi_ending_ip_address    = var.this_net_end_ip
  }
}

variable "this_workspace_id" {
  type = string
}

variable "internal_vpc_dns1" {
  type = string
}

variable "internal_vpc_dns2" {
  type = string
}

variable "this_pvs_dc" {
  type = string
}

variable "this_service_instance_name" {
  type = string
}

variable "this_network_cidr" {
  type = string
}

variable "this_network_gw" {
  type = string
}

variable "this_net_start_ip" {
  type = string
}

variable "this_net_end_ip" {
  type = string
}

variable "provider_region" {}
variable "ibmcloud_api_key" {}