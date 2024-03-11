resource "ibm_pi_image" "openshift"{
  pi_image_name       = var.ocp_pi_image
  pi_cloud_instance_id = var.this_workspace_id
  pi_image_bucket_name = "rhcos-powervs-images-${var.provider_region}"
  pi_image_bucket_access = "public"
  pi_image_bucket_region = var.provider_region
  pi_image_bucket_file_name = local.newest_rhcos_version_image
  pi_image_storage_type = "tier3"
}


data "http" "bucket_contents" {
  url = "https://s3.${var.provider_region}.cloud-object-storage.appdomain.cloud/rhcos-powervs-images-${var.provider_region}/"
}

locals {
  bucket_xml = data.http.bucket_contents.response_body

  rhcos_images = [
    for key in distinct(regexall("<Key>(${var.ocp_pi_image}[^<]*)</Key>", local.bucket_xml)) :
    {
      key = key[0]
    }
  ]

  sorted_rhcos_images = sort(local.rhcos_images[*].key)
  newest_rhcos_version_image = local.sorted_rhcos_images[length(local.sorted_rhcos_images) - 1]
}

variable "this_workspace_id" {}
variable "ocp_pi_image" {}
variable "provider_region" {}
variable "ibmcloud_api_key" {}