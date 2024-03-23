module "cr_inst_var" {
  source = "./modules/cr_inst_var"
  instance_sizes = var.instance_sizes
  region_entries = local.region_entries
}

module "res-group" {
  source    = "./modules/res_group"
  providers = {
    ibm = ibm
  }
  region_entries   = local.region_entries
  provider_region  = local.region_entries.region
  ibmcloud_api_key = var.ibmcloud_api_key
}



module "vpc" {
  depends_on = [module.res-group,module.cr_inst_var]
  source     = "./modules/vpc"
  providers  = {
    ibm = ibm
  }
  provider_region       = local.region_entries.region
  ibmcloud_api_key      = var.ibmcloud_api_key
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  vpc_name              = local.region_entries.vpc_name
  pvs_zone1_cidr        = local.region_entries.zone1.pvs_dc_cidr
  pvs_zone2_cidr        = local.region_entries.zone2.pvs_dc_cidr
  pvs_zone3_cidr        = local.region_entries.zone3.pvs_dc_cidr
  vpc_zone1_cidr        = local.region_entries.zone1.vpc_zone_cidr
  vpc_zone2_cidr        = local.region_entries.zone2.vpc_zone_cidr
  vpc_zone3_cidr        = local.region_entries.zone3.vpc_zone_cidr
  vpc_zone_1            = local.region_entries.zone1.vpc_zone_name
  vpc_zone_2            = local.region_entries.zone2.vpc_zone_name
  vpc_zone_3            = local.region_entries.zone3.vpc_zone_name
  pi_ssh_key            = var.pi_ssh_key
  ocp_cluster_domain    = var.ocp_config.ocp_cluster_domain
  ocp_cluster_name      = var.ocp_config.ocp_cluster_name
  ocp_instances_zone1   = module.cr_inst_var.ocp_instances_zone1
  ocp_instances_zone2   = module.cr_inst_var.ocp_instances_zone2
  ocp_instances_zone3   = module.cr_inst_var.ocp_instances_zone3
  vpc_infra_init_config = module.cr_inst_var.vpc_infra_init_config
}

module "boot_ignition" {
  depends_on = [module.res-group,module.cr_inst_var]
  source     = "./modules/boot_ignition"
  providers  = {
    ibm = ibm
  }
  provider_region       = local.region_entries.region
  ibmcloud_api_key      = var.ibmcloud_api_key
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  ocp_cluster_domain    = var.ocp_config.ocp_cluster_domain
  ocp_cluster_name      = var.ocp_config.ocp_cluster_name
  zone1_pvs_dc_cidr     = local.region_entries.zone1.pvs_dc_cidr
  zone1_vpc_zone_cidr   = local.region_entries.zone1.vpc_zone_cidr
  zone2_pvs_dc_cidr     = local.region_entries.zone2.pvs_dc_cidr
  zone2_vpc_zone_cidr   = local.region_entries.zone2.vpc_zone_cidr
  zone3_pvs_dc_cidr     = local.region_entries.zone3.pvs_dc_cidr
  zone3_vpc_zone_cidr   = local.region_entries.zone3.vpc_zone_cidr
}

module "transit-gw" {
  depends_on            = [module.vpc]
  source                = "./modules/transit_gw"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  ibmcloud_api_key      = var.ibmcloud_api_key
  provider_region       = local.region_entries.region
  vpc_crn               = module.vpc.vpc_crn
}


module "powervs1" {
  depends_on            = [module.res-group, module.vpc, module.transit-gw]
  source                = "./modules/powervs"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  providers             = {
    ibm = ibm.powervs1
  }
  this_service_instance_name = module.cr_inst_var.pvs_zone1.name
  this_pvs_dc                = local.region_entries.zone1.ws_zone_name
  ocp_cluster_name           = var.ocp_config.ocp_cluster_name
  ocp_cluster_domain         = var.ocp_config.ocp_cluster_domain
  this_network_addr          = module.cr_inst_var.pvs_zone1.network_addr
  this_network_mask          = module.cr_inst_var.pvs_zone1.network_mask
  this_network_cidr          = module.cr_inst_var.pvs_zone1.network_cidr
  this_network_gw            = module.cr_inst_var.pvs_zone1.network_gw
  this_net_start_ip          = module.cr_inst_var.pvs_zone1.net_start_ip
  this_net_end_ip            = module.cr_inst_var.pvs_zone1.net_end_ip
  ocp_instances_zone         = module.cr_inst_var.ocp_instances_zone1
  lnx_instances_zone         = module.cr_inst_var.lnx_instances_zone1
  internal_vpc_dns1          = module.vpc.vpc_instance1_ip
  internal_vpc_dns2          = module.vpc.vpc_instance2_ip
  pi_ssh_key                 = var.pi_ssh_key
  ocp_pi_image               = var.ocp_config.ocp_version
  provider_region            = local.region_entries.region
  ibmcloud_api_key           = var.ibmcloud_api_key
  transit_gw_id              = module.transit-gw.transit_gw_id
  bootstrap_init            = module.boot_ignition.bootstrap_init_file
  this_dc_name               = local.region_entries.zone1.dc_name
  per_datacenters            = var.per_datacenters
}

module "powervs2" {
  depends_on            = [module.res-group, module.vpc, module.transit-gw]
  source                = "./modules/powervs"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  providers             = {
    ibm = ibm.powervs2
  }
  this_service_instance_name = module.cr_inst_var.pvs_zone2.name
  this_pvs_dc                = local.region_entries.zone2.ws_zone_name
  ocp_cluster_name           = var.ocp_config.ocp_cluster_name
  ocp_cluster_domain         = var.ocp_config.ocp_cluster_domain
  this_network_addr          = module.cr_inst_var.pvs_zone2.network_addr
  this_network_mask          = module.cr_inst_var.pvs_zone2.network_mask
  this_network_cidr          = module.cr_inst_var.pvs_zone2.network_cidr
  this_network_gw            = module.cr_inst_var.pvs_zone2.network_gw
  this_net_start_ip          = module.cr_inst_var.pvs_zone2.net_start_ip
  this_net_end_ip            = module.cr_inst_var.pvs_zone2.net_end_ip
  ocp_instances_zone         = module.cr_inst_var.ocp_instances_zone2
  lnx_instances_zone         = module.cr_inst_var.lnx_instances_zone2
  internal_vpc_dns1          = module.vpc.vpc_instance1_ip
  internal_vpc_dns2          = module.vpc.vpc_instance2_ip
  pi_ssh_key                 = var.pi_ssh_key
  ocp_pi_image               = var.ocp_config.ocp_version
  provider_region            = local.region_entries.region
  ibmcloud_api_key           = var.ibmcloud_api_key
  transit_gw_id              = module.transit-gw.transit_gw_id
  bootstrap_init            = module.boot_ignition.bootstrap_init_file
  this_dc_name               = local.region_entries.zone2.dc_name
  per_datacenters            = var.per_datacenters
}


module "powervs3" {
  depends_on            = [module.res-group, module.vpc, module.transit-gw]
  source                = "./modules/powervs"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  providers             = {
    ibm = ibm.powervs3
  }
  this_service_instance_name = module.cr_inst_var.pvs_zone3.name
  this_pvs_dc                = local.region_entries.zone3.ws_zone_name
  ocp_cluster_name           = var.ocp_config.ocp_cluster_name
  ocp_cluster_domain         = var.ocp_config.ocp_cluster_domain
  this_network_addr          = module.cr_inst_var.pvs_zone3.network_addr
  this_network_mask          = module.cr_inst_var.pvs_zone3.network_mask
  this_network_cidr          = module.cr_inst_var.pvs_zone3.network_cidr
  this_network_gw            = module.cr_inst_var.pvs_zone3.network_gw
  this_net_start_ip          = module.cr_inst_var.pvs_zone3.net_start_ip
  this_net_end_ip            = module.cr_inst_var.pvs_zone3.net_end_ip
  ocp_instances_zone         = module.cr_inst_var.ocp_instances_zone3
  lnx_instances_zone         = module.cr_inst_var.lnx_instances_zone3
  internal_vpc_dns1          = module.vpc.vpc_instance1_ip
  internal_vpc_dns2          = module.vpc.vpc_instance2_ip
  pi_ssh_key                 = var.pi_ssh_key
  ocp_pi_image               = var.ocp_config.ocp_version
  provider_region            = local.region_entries.region
  ibmcloud_api_key           = var.ibmcloud_api_key
  transit_gw_id              = module.transit-gw.transit_gw_id
  bootstrap_init            = module.boot_ignition.bootstrap_init_file
  this_dc_name               = local.region_entries.zone3.dc_name
  per_datacenters            = var.per_datacenters
}






###Defining here the all region details, please do not edit unless you really know anything has changed.


variable "per_datacenters" {
  default = ["dal10", "dal12", "fra04", "fra05", "wdc06", "wdc07", "mad02", "mad04", "sao01", "sao04"]
}

####This is choosing the datacenters for each region

locals {
  region_entries = merge(
    var.region_definition,
    {
      for k, v in var.region_specific_values[var.region_definition.region] :
      k => merge(lookup(var.region_definition, k, {}), v)
      if startswith(k, "zone")
    }
  )
}


#For some reason I don't understand zones have different names for designating a datacenter, we only have us-south and us-east.
#No, this automation does not make sense for 1 zone or 2 zones, do not do that. Use IPI or UPI for 1 zone, and 2 zones is worse than 1 zone. You introduce latency and if the datacenter that has the majority of the masters goes down, your cluster goes down so you are not gaining anything.

variable "region_specific_values" {
  type = map(map(object({
    dc_name       = string
    ws_zone_name  = string
    vpc_zone_name = string
  })))

  default = {
    us-south = {
      zone1 = {
        dc_name       = "dal10"
        ws_zone_name  = "dal10"
        vpc_zone_name = "us-south-1"
      }
      zone2 = {
        dc_name       = "dal12"
        ws_zone_name  = "dal12"
        vpc_zone_name = "us-south-2"
      }
      zone3 = {
        dc_name       = "dal13"
        ws_zone_name  = "us-south"
        vpc_zone_name = "us-south-3"
      }
    }
    us-east = {
      zone1 = {
        dc_name       = "wdc04"
        ws_zone_name  = "us-east"
        vpc_zone_name = "us-east-1"
      }
      zone2 = {
        dc_name       = "wdc06"
        ws_zone_name  = "wdc06"
        vpc_zone_name = "us-east-2"
      }
      zone3 = {
        dc_name       = "wdc07"
        ws_zone_name  = "wdc07"
        vpc_zone_name = "us-east-3"
      }
    }
  }
}

provider ibm {
  region = local.region_entries.region
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs1"
  region = local.region_entries.region
  zone = local.region_entries.zone1.ws_zone_name
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs2"
  region = local.region_entries.region
  zone = local.region_entries.zone2.ws_zone_name
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs3"
  region = local.region_entries.region
  zone = local.region_entries.zone3.ws_zone_name
  ibmcloud_api_key = var.ibmcloud_api_key
}