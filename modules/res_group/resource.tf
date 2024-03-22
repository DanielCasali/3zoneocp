resource "ibm_resource_group" "resourceGroup" {
  name     = var.region_entries.resource_group_name
}

variable "region_entries" {}
variable "provider_region" {}
variable "ibmcloud_api_key" {}