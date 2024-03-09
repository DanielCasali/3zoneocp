resource "ibm_is_vpc" "vpc" {
  resource_group            = var.ibm_resource_group_id
  name                      = var.vpc_name
  address_prefix_management = "manual"
  default_routing_table_name = "ocp-routing-table"
}

resource "ibm_is_vpc_routing_table" "ocp-routing-table" {
  vpc                           = ibm_is_vpc.vpc.id
  name                          = "ocp-routing-table"
  route_direct_link_ingress     = true
  route_transit_gateway_ingress = true
  route_vpc_zone_ingress        = true
  advertise_routes_to           = ["direct_link", "transit_gateway"]
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

resource "ibm_is_subnet" "vpc-zone1-subnet" {
  name            = "vpc-zone1-subnet"
  vpc             = ibm_is_vpc.vpc.id
  zone            = var.vpc_zone_1
  ipv4_cidr_block = var.vpc_zone1_cidr
  routing_table   = ibm_is_vpc_routing_table.ocp-routing-table.routing_table
}

resource "ibm_is_subnet" "vpc-zone2-subnet" {
  name            = "vpc-zone2-subnet"
  vpc             = ibm_is_vpc.vpc.id
  zone            = var.vpc_zone_2
  ipv4_cidr_block = var.vpc_zone2_cidr
  routing_table   = ibm_is_vpc_routing_table.ocp-routing-table.routing_table
}

resource "ibm_is_subnet" "vpc-zone3-subnet" {
  name            = "vpc-zone3-subnet"
  vpc             = ibm_is_vpc.vpc.id
  zone            = var.vpc_zone_3
  ipv4_cidr_block = var.vpc_zone3_cidr
  routing_table   = ibm_is_vpc_routing_table.ocp-routing-table.routing_table
}

resource "ibm_is_ssh_key" "vpc-ssh-key" {
  name       = "vpc-ssh-key"
  public_key = var.pi_ssh_key
}

variable "pi_ssh_key" {}
variable "vpc_name" {}
variable "ibmcloud_api_key" {}
variable "vpc_zone1_cidr" {}
variable "vpc_zone2_cidr" {}
variable "vpc_zone3_cidr" {}
variable "vpc_zone_1" {}
variable "vpc_zone_2" {}
variable "vpc_zone_3" {}
