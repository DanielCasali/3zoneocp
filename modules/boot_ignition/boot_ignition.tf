resource "ibm_resource_instance" "cos_instance" {
  resource_group_id = var.ibm_resource_group_id
  service           = "cloud-object-storage"
  plan              = "lite"
  location          = "global"
  name              = "ocp-cos"
}

resource "ibm_cos_bucket" "cos_bucket" {
  bucket_name           = var.ibm_resource_group_id
  resource_instance_id  = ibm_resource_instance.cos_instance.id
  region_location       = var.provider_region
  cross_region_location = "us"
  storage_class         = "standard"
}

resource "ibm_cos_bucket_object" "bootstrap" {
  bucket_crn      = ibm_cos_bucket.cos_bucket.crn
  bucket_location = ibm_cos_bucket.cos_bucket.region_location
  key             = "bootstrap.ign"
  content_base64 = var.bootstrap_image
}


variable "bootstrap_image" {}
variable "ibm_resource_group_id" {}
variable "provider_region" {}
variable "ibmcloud_api_key" {}