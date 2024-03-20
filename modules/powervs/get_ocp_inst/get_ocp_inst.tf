
locals {
  instances = {
    instance_list = {
      for key, value in var.ocp_instances_zone.ocp_instances : key => {
        ip_address    = data.ibm_pi_instance.ds_instance[key].networks[0].ip
        mac_address   = data.ibm_pi_instance.ds_instance[key].networks[0].macaddress
        instance_id   = data.ibm_pi_instance.ds_instance[key].id
      }
    }
  }
}

data "ibm_pi_instance" "ds_instance" {
  for_each   = var.ocp_instances_zone.ocp_instances
  pi_instance_name     = each.value.pi_instance_name
  pi_cloud_instance_id = var.this_workspace_id
}


variable "ocp_instances_zone" {}
variable "this_workspace_id" {
}
variable "ibmcloud_api_key" {}
