resource "ibm_pi_instance_action" "start" {
  for_each = var.ocp_instance_mac
  pi_cloud_instance_id  = var.this_workspace_id
  pi_instance_id        = each.key
  pi_action             = "start"
}

variable "ocp_instance_mac" {

}
variable "ibmcloud_api_key" {}

variable "this_workspace_id" {
  type = string
}