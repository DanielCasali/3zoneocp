
resource "ibm_tg_gateway" "ocp_transit_gateway"{
  name="ocp-transit-gateway"
  location = var.provider_region
  global = false
  resource_group=var.ibm_resource_group_id
}


resource "ibm_tg_connection" "test_ibm_tg_connection" {
  gateway      = ibm_tg_gateway.ocp_transit_gateway.id
  network_type = "vpc"
  name         = "ocp-vpc"
  network_id   = var.vpc_crn
}

variable "vpc_crn" {}
variable "ibm_resource_group_id" {}
variable "provider_region" {}
variable "ibmcloud_api_key" {}