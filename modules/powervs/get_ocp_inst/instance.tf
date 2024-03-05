
data "ibm_pi_instances" "ds_instance" {
  pi_cloud_instance_id = var.this_workspace_id
}


variable "this_workspace_id" {
}

variable "ibmcloud_api_key" {}