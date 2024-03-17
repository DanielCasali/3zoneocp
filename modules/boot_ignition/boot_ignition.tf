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
  storage_class         = "standard"
}

resource "ibm_cos_bucket_object" "bootstrap" {
  bucket_crn      = ibm_cos_bucket.cos_bucket.crn
  bucket_location = ibm_cos_bucket.cos_bucket.region_location
  key             = "bootstrap.ign"
  content_base64 = var.bootstrap_image
}


data "ibm_iam_access_group" "public_access_group" {
  access_group_name = "Public Access"
}

resource "ibm_iam_service_id" "cos_service_id" {
  name        = "cos-service-id"
  description = "Service ID for COS public access"
}
resource "ibm_iam_access_group_members" "cos_public_access_group_members" {
  access_group_id = data.ibm_iam_access_group.public_access_group.groups[0].id
  iam_service_ids = [ibm_iam_service_id.cos_service_id.id]
}

resource "ibm_iam_authorization_policy" "cos_policy" {
  target_service_name         = "cloud-object-storage"
  target_resource_instance_id = ibm_resource_instance.cos_instance.guid
  roles                       = ["Object Reader"]
  resource             = ibm_cos_bucket.cos_bucket.bucket_name
  account_management = false
}

variable "bootstrap_image" {}
variable "ibm_resource_group_id" {}
variable "provider_region" {}
variable "ibmcloud_api_key" {}
variable "ocp_cluster_name" {}
variable "ocp_cluster_domain" {}
variable "zone1_vpc_zone_cidr" {}
variable "zone2_vpc_zone_cidr" {}
variable "zone3_vpc_zone_cidr" {}
variable "zone1_pvs_dc_cidr" {}
variable "zone2_pvs_dc_cidr" {}
variable "zone3_pvs_dc_cidr" {}