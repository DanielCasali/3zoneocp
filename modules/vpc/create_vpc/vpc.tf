resource "ibm_is_vpc" "vpc" {
  resource_group = var.ibm_resource_group_id
  name           = var.vpc_name

}

resource "ibm_is_vpc_address_prefix" "zone-1-prefix" {
  name = "zone-1-prefix"
  zone = var.vpc_zone_1
  vpc  = ibm_is_vpc.vpc.id
  cidr = var.vpc_zone1_cidr
}

resource "ibm_is_vpc_address_prefix" "zone-2-prefix" {
  name = "zone-2-prefix"
  zone = var.vpc_zone_2
  vpc  = ibm_is_vpc.vpc.id
  cidr = var.vpc_zone2_cidr
}

resource "ibm_is_vpc_address_prefix" "zone-3-prefix" {
  name = "zone-3-prefix"
  zone = var.vpc_zone_3
  vpc  = ibm_is_vpc.vpc.id
  cidr = var.vpc_zone3_cidr
}


variable "vpc_name" {}
variable "ibmcloud_api_key" {}
variable "ibm_resource_group_id" {}
variable "vpc_zone1_cidr" {}
variable "vpc_zone2_cidr" {}
variable "vpc_zone3_cidr" {}
variable "vpc_zone_1" {}
variable "vpc_zone_2" {}
variable "vpc_zone_3" {}
