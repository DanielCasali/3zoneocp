resource "ibm_pi_image" "centos" {
  pi_cloud_instance_id = var.this_workspace_id
  pi_image_name        = "CentOS-Stream-8"
  pi_image_id = local.centos_stream_8_image.id
}

data "ibm_is_images" "centos_stream_8" {
  visibility = "public"
}

locals {
  centos_stream_8_image = [
    for image in data.ibm_is_images.centos_stream_8.images:
    image
    if length(regexall("CentOS-Stream-8", image.name)) > 0
  ][0]
}


variable "this_workspace_id" {}
variable "ibmcloud_api_key" {}



