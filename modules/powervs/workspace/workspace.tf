variable "this_pvs_dc" {
  type = string
}

variable "ibm_resource_group_id" {
  type = string
}

variable "this_service_instance_name" {
  type = string
}

variable "provider_region" {}
variable "ibmcloud_api_key" {}


resource "ibm_pi_workspace" "powervs_service_instance" {
  pi_name               = var.this_service_instance_name
  pi_plan               = "public"
  pi_datacenter         = var.this_pvs_dc
  pi_resource_group_id  = var.ibm_resource_group_id
}