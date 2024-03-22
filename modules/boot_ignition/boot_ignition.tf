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
  content_base64 = local.base64_bootstrap_ignition_updated
}


data "ibm_iam_access_group" "public_access_group" {
  access_group_name = "Public Access"
}

resource "ibm_iam_service_id" "cos_service_id" {
  name        = "cos-service-id"
  description = "Service ID for COS public access"
}

#resource "ibm_iam_access_group_members" "cos_public_access_group_members" {
#  access_group_id = data.ibm_iam_access_group.public_access_group.groups[0].id
#  iam_service_ids = [ibm_iam_service_id.cos_service_id.id]
#}

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




locals {
  bootstrap_ignition = file("${path.module}/../../bootstrap.ign")
  chrony_config = <<-EOF
    server ${var.internal_vpc_dns1} iburst
    server ${var.internal_vpc_dns2} iburst

    driftfile /var/lib/chrony/drift
    makestep 1.0 3
    rtcsync

    logdir /var/log/chrony
  EOF
  chrony_config_base64 = base64encode(local.chrony_config)
  chrony_file = [
    {
      path     = "/etc/chrony.conf"
      mode     = 420
      contents = {
        source = "data:text/plain;charset=utf-8;base64,${local.chrony_config_base64}"
      }
    }
  ]
  bootstrap_ignition_decoded = jsondecode(local.bootstrap_ignition)
  bootstrap_ignition_updated = merge(local.bootstrap_ignition_decoded, {
    storage = {
      files = concat(local.bootstrap_ignition_decoded.storage.files, local.chrony_file)
    }
  })
  base64_bootstrap_ignition_updated = base64encode(jsonencode(local.bootstrap_ignition_updated))
}

variable "internal_vpc_dns1" {}
variable "internal_vpc_dns2" {}
variable "bootstrap_ignition" {}
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