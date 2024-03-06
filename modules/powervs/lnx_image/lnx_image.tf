resource "ibm_pi_catalog_image" "centos" {
  pi_cloud_instance_id = var.this_workspace_id
  pi_image_id          = "b86c8d00-6419-4652-ba93-4355a5d62ac4"
  pi_image_name        = "CentOSStream8"
}

variable "this_workspace_id" {}
variable "ibmcloud_api_key" {}



