variable "this_zone" {
  type = string
}

variable "ibm_resource_group_id" {
  type = string
}

variable "this_service_instance_name" {
  type = string
}

resource "ibm_pi_workspace" "powervs_service_instance" {
  pi_name               = var.this_service_instance_name
  pi_datacenter         = var.this_zone
  pi_resource_group_id  = var.ibm_resource_group_id
}


