resource "ibm_pi_key" "my-key_ssh-key" {
  pi_key_name          = "my-key"
  pi_ssh_key           = var.pi_ssh_key
  pi_cloud_instance_id = var.this_workspace_id
}

variable "pi_ssh_key" {}

variable "this_workspace_id" {}

variable "provider_region" {}
variable "ibmcloud_api_key" {}