module "create_vpc" {
  source          = "./create_vpc"
  ibm_resource_group_id = var.ibm_resource_group_id
  ibmcloud_api_key = var.ibmcloud_api_key
  vpc_name = var.vpc_name
  vpc_zone1_cidr = var.vpc_zone1_cidr
  vpc_zone2_cidr = var.vpc_zone2_cidr
  vpc_zone3_cidr = var.vpc_zone3_cidr
  vpc_zone_1 = var.vpc_zone_1
  vpc_zone_2 = var.vpc_zone_2
  vpc_zone_3 = var.vpc_zone_3
  pi_ssh_key = var.pi_ssh_key

}

module "sec_roles" {
  depends_on = [module.create_vpc]
  source          = "./sec_roles"
  ibmcloud_api_key = var.ibmcloud_api_key
  security_group_id = module.create_vpc.security_group_id
  pvs_zone1_cidr = var.pvs_zone1_cidr
  pvs_zone2_cidr = var.pvs_zone2_cidr
  pvs_zone3_cidr = var.pvs_zone3_cidr
  vpc_zone1_cidr = var.vpc_zone1_cidr
  vpc_zone2_cidr = var.vpc_zone2_cidr
  vpc_zone3_cidr = var.vpc_zone3_cidr

}

module "create_inst1" {
  depends_on = [module.create_vpc, module.sec_roles]
  source     = "./create_inst"
  ibmcloud_api_key = ""
  instance_name = "infra1"
  ssh_key_id = module.create_vpc.ssh_key_id
  vpc_id = module.create_vpc.vpc_id
  user_data =  var.vpc_infra_init_config
  zone_name = var.vpc_zone_1
  image_id = local.vpc_image_id
  subnet_id = module.create_vpc.subnet1_vpc_id
}

module "create_inst2" {
  depends_on = [module.create_vpc, module.sec_roles]
  source     = "./create_inst"
  ibmcloud_api_key = ""
  instance_name = "infra2"
  ssh_key_id = module.create_vpc.ssh_key_id
  vpc_id = module.create_vpc.vpc_id
  user_data =  var.vpc_infra_init_config
  zone_name = var.vpc_zone_2
  image_id = local.vpc_image_id
  subnet_id = module.create_vpc.subnet2_vpc_id
}


module "lb_int" {
  depends_on          = [module.create_inst1, module.create_inst2]
  source              = "./lb_int"
  ibmcloud_api_key    = var.ibmcloud_api_key
  subnet1_vpc_id      = module.create_vpc.subnet1_vpc_id
  subnet2_vpc_id      = module.create_vpc.subnet2_vpc_id
  subnet3_vpc_id      = module.create_vpc.subnet3_vpc_id
  instance1_id        = module.create_inst1.ibm_instance_id
  instance2_id        = module.create_inst2.ibm_instance_id
  ocp_instances_zone1 = var.ocp_instances_zone1
  ocp_instances_zone2 = var.ocp_instances_zone2
  ocp_instances_zone3 = var.ocp_instances_zone3
}


module "create_dns"{
  depends_on = [module.lb_int]
  source = "./create_dns"
  ibmcloud_api_key = var.ibmcloud_api_key
  ibm_resource_group_id = var.ibm_resource_group_id
  ocp_cluster_domain = var.ocp_cluster_domain
  ocp_cluster_name = var.ocp_cluster_name
  vpc_crn = module.create_vpc.vpc_crn
  lb-int-hostname = module.lb_int.lb_int_hostname
}

variable "ocp_instances_zone1" {}
variable "ocp_instances_zone2" {}
variable "ocp_instances_zone3" {}
variable "ocp_cluster_name" {}
variable "ocp_cluster_domain" {}
variable "provider_region" {}
variable "vpc_name" {}
variable "ibm_resource_group_id" {}
variable "ibmcloud_api_key" {}
variable "pi_ssh_key" {}
variable "pvs_zone1_cidr" {}
variable "pvs_zone2_cidr" {}
variable "pvs_zone3_cidr" {}
variable "vpc_zone1_cidr" {}
variable "vpc_zone2_cidr" {}
variable "vpc_zone3_cidr" {}
variable "vpc_zone_1" {}
variable "vpc_zone_2" {}
variable "vpc_zone_3" {}
variable "vpc_infra_init_config" {}

data "ibm_is_images" "vpc" {
  visibility = "public"
  status = "available"
}

locals {
  vpc_image = [
    for image in data.ibm_is_images.vpc.images:
    image
    if image.os == "centos-stream-9-amd64"
  ][0]
  vpc_image_id = local.vpc_image.id
}


