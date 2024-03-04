
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
  this_network_cidr = var.powervs_region1.network_cidr
  this_network_gw   = var.powervs_region1.network_gw
  this_net_start_ip = var.powervs_region1.net_start_ip
  this_net_end_ip   = var.powervs_region1.net_end_ip
  ocp_instances_region = var.ocp_instances_region1
  internal_vpc_dns1     = var.internal_vpc_dns1
  internal_vpc_dns2     = var.internal_vpc_dns2
  pi_ssh_key = var.pi_ssh_key
  ocp_pi_image_bucket_access = var.ocp_pi_image_bucket_access
  ocp_pi_image_bucket_file_name = var.ocp_pi_image_bucket_file_name
  ocp_pi_image_bucket_name = var.ocp_pi_image_bucket_name
  ocp_pi_image_bucket_region = var.ocp_pi_image_bucket_region
  ocp_pi_image_name = var.ocp_pi_image_name
  ocp_pi_image_storage_type = var.ocp_pi_image_storage_type
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
  this_network_cidr = var.powervs_region2.network_cidr
  this_network_gw   = var.powervs_region2.network_gw
  this_net_start_ip = var.powervs_region2.net_start_ip
  this_net_end_ip   = var.powervs_region2.net_end_ip
  ocp_instances_region = var.ocp_instances_region2
  internal_vpc_dns1     = var.internal_vpc_dns1
  internal_vpc_dns2     = var.internal_vpc_dns2
  pi_ssh_key = var.pi_ssh_key
  ocp_pi_image_bucket_access = var.ocp_pi_image_bucket_access
  ocp_pi_image_bucket_file_name = var.ocp_pi_image_bucket_file_name
  ocp_pi_image_bucket_name = var.ocp_pi_image_bucket_name
  ocp_pi_image_bucket_region = var.ocp_pi_image_bucket_region
  ocp_pi_image_name = var.ocp_pi_image_name
  ocp_pi_image_storage_type = var.ocp_pi_image_storage_type
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
  this_network_cidr = var.powervs_region3.network_cidr
  this_network_gw   = var.powervs_region3.network_gw
  this_net_start_ip = var.powervs_region3.net_start_ip
  this_net_end_ip   = var.powervs_region3.net_end_ip
  ocp_instances_region = var.ocp_instances_region2
  internal_vpc_dns1     = var.internal_vpc_dns1
  internal_vpc_dns2     = var.internal_vpc_dns2
  pi_ssh_key = var.pi_ssh_key
  ocp_pi_image_bucket_access = var.ocp_pi_image_bucket_access
  ocp_pi_image_bucket_file_name = var.ocp_pi_image_bucket_file_name
  ocp_pi_image_bucket_name = var.ocp_pi_image_bucket_name
  ocp_pi_image_bucket_region = var.ocp_pi_image_bucket_region
  ocp_pi_image_name = var.ocp_pi_image_name
  ocp_pi_image_storage_type = var.ocp_pi_image_storage_type
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}
