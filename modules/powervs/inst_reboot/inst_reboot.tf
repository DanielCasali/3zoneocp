resource "ibm_pi_instance_action" "reboot" {
  for_each = var.ocp_instance_mac.instance_list
  pi_cloud_instance_id = var.this_workspace_id
  pi_instance_id       = each.instance_id
  pi_action            = "hard-reboot"
}

variable "ocp_instance_mac" {

}
variable "ibmcloud_api_key" {}

variable "this_workspace_id" {
  type = string
}