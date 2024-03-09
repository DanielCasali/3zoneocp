module "res-group" {
  source = "./modules/res-group"
  providers = {
    ibm = ibm
  }
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}

module "transit-gw" {
  depends_on = [module.res-group]
  source = "./modules/transit-gw"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  ibmcloud_api_key = var.ibmcloud_api_key
  provider_region = var.provider_region
}


module "vpc" {
  depends_on = [module.res-group]
  source = "./modules/vpc"
  providers = {
    ibm = ibm
  }
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  vpc_name = var.vpc.name
  pvs_zone1_cidr = var.pvs_zone1.network_cidr
  pvs_zone2_cidr = var.pvs_zone2.network_cidr
  pvs_zone3_cidr = var.pvs_zone3.network_cidr
  vpc_zone1_cidr = var.vpc_zone1_cidr
  vpc_zone2_cidr = var.vpc_zone2_cidr
  vpc_zone3_cidr = var.vpc_zone3_cidr
  vpc_zone_1 = var.vpc_zone_1
  vpc_zone_2 = var.vpc_zone_2
  vpc_zone_3 = var.vpc_zone_3
  pi_ssh_key = var.pi_ssh_key
  ocp_cluster_domain = var.ocp_cluster_domain
  ocp_cluster_name = var.ocp_cluster_name
}


module "powervs1" {
  depends_on = [module.res-group,module.vpc]
  source    = "./modules/powervs"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  providers = {
    ibm = ibm.powervs1
  }
  this_service_instance_name = "powervs1"
  this_pvs_dc = var.pvs_dc1
  ocp_cluster_name = var.ocp_cluster_name
  ocp_cluster_domain = var.ocp_cluster_domain
  this_network_addr = var.pvs_zone1.network_addr
  this_network_mask = var.pvs_zone1.network_mask
  this_network_cidr = var.pvs_zone1.network_cidr
  this_network_gw   = var.pvs_zone1.network_gw
  this_net_start_ip = var.pvs_zone1.net_start_ip
  this_net_end_ip   = var.pvs_zone1.net_end_ip
  ocp_instances_zone = var.ocp_instances_zone1
  lnx_instances_zone = var.lnx_instances_zone1
  internal_vpc_dns1     = var.internal_vpc_dns1
  internal_vpc_dns2     = var.internal_vpc_dns2
  pi_ssh_key = var.pi_ssh_key
  ocp_pi_image = var.ocp_pi_image
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
  workspace_plan = var.workspace_plan
  lb-int-id = module.vpc.lb-int-id
  lb-int-pool-id = module.vpc.lb-int-pool-id
}

module "powervs2" {
  depends_on = [module.res-group,module.vpc]
  source    = "./modules/powervs"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  providers = {
    ibm = ibm.powervs2
  }
  this_service_instance_name = "powervs2"
  this_pvs_dc = var.pvs_dc2
  ocp_cluster_name = var.ocp_cluster_name
  ocp_cluster_domain = var.ocp_cluster_domain
  this_network_addr = var.pvs_zone2.network_addr
  this_network_mask = var.pvs_zone2.network_mask
  this_network_cidr = var.pvs_zone2.network_cidr
  this_network_gw   = var.pvs_zone2.network_gw
  this_net_start_ip = var.pvs_zone2.net_start_ip
  this_net_end_ip   = var.pvs_zone2.net_end_ip
  ocp_instances_zone = var.ocp_instances_zone2
  lnx_instances_zone = var.lnx_instances_zone2
  internal_vpc_dns1     = var.internal_vpc_dns1
  internal_vpc_dns2     = var.internal_vpc_dns2
  pi_ssh_key = var.pi_ssh_key
  ocp_pi_image = var.ocp_pi_image
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
  workspace_plan = var.workspace_plan
  lb-int-id = module.vpc.lb-int-id
  lb-int-pool-id = module.vpc.lb-int-pool-id
}


module "powervs3" {
  depends_on = [module.res-group,module.vpc]
  source    = "./modules/powervs"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  providers = {
    ibm = ibm.powervs3
  }
  this_service_instance_name = "powervs3"
  this_pvs_dc = var.pvs_dc3
  ocp_cluster_name = var.ocp_cluster_name
  ocp_cluster_domain = var.ocp_cluster_domain
  this_network_addr = var.pvs_zone3.network_addr
  this_network_mask = var.pvs_zone3.network_mask
  this_network_cidr = var.pvs_zone3.network_cidr
  this_network_gw   = var.pvs_zone3.network_gw
  this_net_start_ip = var.pvs_zone3.net_start_ip
  this_net_end_ip   = var.pvs_zone3.net_end_ip
  ocp_instances_zone = var.ocp_instances_zone3
  lnx_instances_zone = var.lnx_instances_zone3
  internal_vpc_dns1     = var.internal_vpc_dns1
  internal_vpc_dns2     = var.internal_vpc_dns2
  pi_ssh_key = var.pi_ssh_key
  ocp_pi_image = var.ocp_pi_image
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
  workspace_plan = var.workspace_plan
  lb-int-id = module.vpc.lb-int-id
  lb-int-pool-id = module.vpc.lb-int-pool-id
}
