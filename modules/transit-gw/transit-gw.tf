
resource "ibm_tg_gateway" "ocp_transit_gateway"{
  name="ocp-transit-gateway"
  location = var.provider_region
  global = false
  resource_group=var.ibm_resource_group_id
}

variable "ibm_resource_group_id" {}
variable "provider_region" {}
variable "ibmcloud_api_key" {}