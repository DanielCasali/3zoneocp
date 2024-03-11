data "ibm_pi_catalog_images" "catalog_images" {
  pi_cloud_instance_id = var.this_workspace_id
}

locals {
  lnx_image = [
    for image in data.ibm_pi_catalog_images.catalog_images.images :
    image
    if image.name == "CentOS-Stream-9"
  ][0]
}



variable "this_workspace_id" {}
variable "ibmcloud_api_key" {}



