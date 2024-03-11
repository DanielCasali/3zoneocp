resource "ibm_pi_key" "ocp_ssh_key" {
  pi_key_name          = "ocp-ssh-key${var.this_pvs_dc}"
  pi_ssh_key           = var.pi_ssh_key
  pi_cloud_instance_id = var.this_workspace_id
}

variable "this_pvs_dc" {}
variable "pi_ssh_key" {}
variable "this_workspace_id" {}

variable "provider_region" {}
variable "ibmcloud_api_key" {}