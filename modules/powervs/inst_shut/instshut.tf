resource "ibm_pi_instance_action" "example" {
  pi_cloud_instance_id  = var.this_workspace_id
  pi_instance_id        = this_pi_instance_id
  pi_action             = "start"
}

variable "this_pi_instance_id" {
  type = map(any)
}
variable "ibmcloud_api_key" {}

variable "this_workspace_id" {
  type = string
}