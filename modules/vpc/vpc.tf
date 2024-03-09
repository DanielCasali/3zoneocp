module "create_vpc" {
  source          = "./create_vpc"
  ibm_resource_group_id = var.ibm_resource_group_id
  ibmcloud_api_key = var.ibmcloud_api_key
  vpc_name = var.vpc_name
  vpc_zone1_cidr = var.vpc_zone1_cidr
  vpc_zone2_cidr = var.vpc_zone2_cidr
  vpc_zone3_cidr = var.vpc_zone3_cidr
  provider_region = var.provider_region
  vpc_zone_1 = var.vpc_zone_1
  vpc_zone_2 = var.vpc_zone_2
  vpc_zone_3 = var.vpc_zone_3

}

module "sec_roles" {
  depends_on = [module.create_vpc]
  source          = "./sec_roles"
  ibm_resource_group_id = var.ibm_resource_group_id
  ibmcloud_api_key = var.ibmcloud_api_key
  security_group_id = module.create_vpc.security_group_id
  pvs_zone1_cidr = var.pvs_zone1_cidr
  pvs_zone2_cidr = var.pvs_zone2_cidr
  pvs_zone3_cidr = var.pvs_zone3_cidr
  vpc_zone1_cidr = var.vpc_zone1_cidr
  vpc_zone2_cidr = var.vpc_zone2_cidr
  vpc_zone3_cidr = var.vpc_zone3_cidr

}

variable "provider_region" {}

variable "vpc_name" {}
variable "ibm_resource_group_id" {}
variable "ibmcloud_api_key" {}

variable "pvs_zone1_cidr" {}
variable "pvs_zone2_cidr" {}
variable "pvs_zone3_cidr" {}
variable "vpc_zone1_cidr" {}
variable "vpc_zone2_cidr" {}
variable "vpc_zone3_cidr" {}
variable "vpc_zone_1" {}
variable "vpc_zone_2" {}
variable "vpc_zone_3" {}