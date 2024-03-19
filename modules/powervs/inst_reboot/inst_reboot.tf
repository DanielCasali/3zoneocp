
data "ibm_pi_instances" "ds_instance" {
  pi_cloud_instance_id = var.this_workspace_id
}

locals {
  instance_ids_to_reboot = toset([
    for instance in data.ibm_pi_instances.ds_instance.pvm_instances :
    instance.pvm_instance_id if contains(keys(var.ocp_instance_mac.instance_list), instance.id)
  ])
}

resource "ibm_pi_instance_action" "reboot" {
  for_each = local.instance_ids_to_reboot
  pi_cloud_instance_id = var.this_workspace_id
  pi_instance_id       = each.value
  pi_action            = "hard-reboot"
}


variable "ocp_instance_mac" {

}
variable "ibmcloud_api_key" {}

variable "this_workspace_id" {
  type = string
}