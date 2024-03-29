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
  force_delete          = true
  expire_rule {
    rule_id = "a-bucket-expire-rule"
    enable  = true
    days    = 1
  }
}

resource "ibm_cos_bucket_object" "bootstrap" {
  bucket_crn      = ibm_cos_bucket.cos_bucket.crn
  bucket_location = ibm_cos_bucket.cos_bucket.region_location
  key             = "bootstrap.ign"
  content_base64 =  base64encode(file("${path.module}/../../bootstrap.ign"))

}


data "ibm_iam_access_group" "public_access_group" {
  access_group_name = "Public Access"
}

resource "ibm_iam_service_id" "cos_service_id" {
  name        = "cos-service-id"
  description = "Service ID for COS public access"
}


resource "ibm_iam_access_group_policy" "cos_policy" {
  access_group_id = data.ibm_iam_access_group.public_access_group.groups[0].id
  roles           = ["Object Reader"]

  resources {
    service              = "cloud-object-storage"
    resource_instance_id = ibm_resource_instance.cos_instance.guid
    resource_type        = "bucket"
    resource             = ibm_cos_bucket.cos_bucket.bucket_name
  }
}



variable "ibm_resource_group_id" {}
variable "provider_region" {}
variable "ibmcloud_api_key" {}
