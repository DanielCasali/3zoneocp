resource "ibm_pi_image" "openshift"{
  pi_image_name       = var.ocp_pi_image_name
  pi_cloud_instance_id = var.this_workspace_id
  pi_image_bucket_name = var.ocp_pi_image_bucket_name
  pi_image_bucket_access = var.ocp_pi_image_bucket_access
  pi_image_bucket_region = var.ocp_pi_image_bucket_region
  pi_image_bucket_file_name = var.ocp_pi_image_bucket_file_name
  pi_image_storage_type = var.ocp_pi_image_storage_type
}

variable "this_workspace_id" {}
variable "ocp_pi_image_name" {}
variable "ocp_pi_image_bucket_name" {}
variable "ocp_pi_image_bucket_access" {}
variable "ocp_pi_image_bucket_region" {}
variable "ocp_pi_image_bucket_file_name" {}
variable "ocp_pi_image_storage_type" {}