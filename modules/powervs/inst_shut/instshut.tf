resource "ibm_pi_instance_action" "example" {
  for_each = var.instance_mac
  pi_cloud_instance_id  = var.this_workspace_id
  pi_instance_id        = each.key
  pi_action             = "immediate-shutdown"
}

variable "instance_mac" {
  type = map(any)
}
variable "ibmcloud_api_key" {}

variable "this_workspace_id" {
  type = string
}