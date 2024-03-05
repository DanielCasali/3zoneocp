
module "vpc" {
  source = "./modules/vpc"
  providers = {
    ibm = ibm
  }
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}


module "res-group" {
  source = "./modules/res-group"
  providers = {
    ibm = ibm
  }
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}

module "powervs1" {
  source    = "./modules/powervs"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  providers = {
    ibm = ibm.powervs1
  }
  this_service_instance_name = "powervs1"
  this_zone = var.zone1
  this_network_cidr = var.network_zone1.network_cidr
  this_network_gw   = var.network_zone1.network_gw
  this_net_start_ip = var.network_zone1.net_start_ip
  this_net_end_ip   = var.network_zone1.net_end_ip
  ocp_instances_zone = var.ocp_instances_zone1
  lnx_instances_zone = var.lnx_instances_zone1
  internal_vpc_dns1     = var.internal_vpc_dns1
  internal_vpc_dns2     = var.internal_vpc_dns2
  pi_ssh_key = var.pi_ssh_key
  ocp_pi_image = var.ocp_pi_image
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}

module "powervs2" {
  source    = "./modules/powervs"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  providers = {
    ibm = ibm.powervs2
  }
  this_service_instance_name = "powervs2"
  this_zone = var.zone2
  this_network_cidr = var.network_zone2.network_cidr
  this_network_gw   = var.network_zone2.network_gw
  this_net_start_ip = var.network_zone2.net_start_ip
  this_net_end_ip   = var.network_zone2.net_end_ip
  ocp_instances_zone = var.ocp_instances_zone2
  lnx_instances_zone = var.lnx_instances_zone2
  internal_vpc_dns1     = var.internal_vpc_dns1
  internal_vpc_dns2     = var.internal_vpc_dns2
  pi_ssh_key = var.pi_ssh_key
  ocp_pi_image = var.ocp_pi_image
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}


module "powervs3" {
  source    = "./modules/powervs"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  providers = {
    ibm = ibm.powervs3
  }
  this_service_instance_name = "powervs3"
  this_zone = var.zone3
  this_network_cidr = var.network_zone3.network_cidr
  this_network_gw   = var.network_zone3.network_gw
  this_net_start_ip = var.network_zone3.net_start_ip
  this_net_end_ip   = var.network_zone3.net_end_ip
  ocp_instances_zone = var.ocp_instances_zone3
  lnx_instances_zone = var.lnx_instances_zone3
  internal_vpc_dns1     = var.internal_vpc_dns1
  internal_vpc_dns2     = var.internal_vpc_dns2
  pi_ssh_key = var.pi_ssh_key
  ocp_pi_image = var.ocp_pi_image
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}
