resource "ibm_pi_image" "centos" {
  pi_cloud_instance_id = var.this_workspace_id
  pi_image_name        = "CentOS8"
  pi_image_bucket_name = "power-cloud-boot-images"
  pi_image_bucket_access_key = ""
  pi_image_bucket_secret_key = ""
  pi_image_bucket_region = "us-east"
  pi_image_bucket_file_name = "ppc64le/CentOS-8.4-ppc64le-2021-11-25.ova"
}

variable "this_workspace_id" {}
variable "ibmcloud_api_key" {}



