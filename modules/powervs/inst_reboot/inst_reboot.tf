resource "ibm_pi_instance_action" "reboot" {
  for_each = local.instance_list_transformed
  pi_cloud_instance_id  = var.this_workspace_id
  pi_instance_id        = each.instance_id
  pi_action             = "hard-reboot"
}



locals {
  instance_list_transformed = {
    for instance_key, instance in var.ocp_instance_mac.instance_list :
    instance_key => merge(instance, { instance_id = instance_key })
  }
}


variable "ocp_instance_mac" {

}
variable "ibmcloud_api_key" {}

variable "this_workspace_id" {
  type = string
}