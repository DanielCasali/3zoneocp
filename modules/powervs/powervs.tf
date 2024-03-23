
module "workspace" {
  source                     = "./workspace"
  ibm_resource_group_id      = var.ibm_resource_group_id
  this_service_instance_name = var.this_service_instance_name
  this_pvs_dc                = var.this_pvs_dc
  provider_region            = var.provider_region
  ibmcloud_api_key           = var.ibmcloud_api_key
}

module "ocp_image" {
  source            = "./ocp_image"
  depends_on        = [module.workspace]
  ocp_pi_image      = var.ocp_pi_image
  this_workspace_id = module.workspace.workspace_id
  provider_region   = var.provider_region
  ibmcloud_api_key  = var.ibmcloud_api_key
}

module "lnx_image" {
  source            = "./lnx_image"
  depends_on        = [module.workspace]
  ibmcloud_api_key  = var.ibmcloud_api_key
  this_workspace_id = module.workspace.workspace_id
}

module "ssh_key" {
  source            = "./ssh_key"
  depends_on        = [module.workspace]
  this_workspace_id = module.workspace.workspace_id
  pi_ssh_key        = var.pi_ssh_key
  this_pvs_dc       = var.this_pvs_dc
  provider_region   = var.provider_region
  ibmcloud_api_key  = var.ibmcloud_api_key
}

module "network" {
  source                     = "./network"
  depends_on                 = [module.workspace]
  this_workspace_id          = module.workspace.workspace_id
  this_service_instance_name = var.this_service_instance_name
  this_pvs_dc                = var.this_pvs_dc
  internal_vpc_dns1          = var.internal_vpc_dns1
  internal_vpc_dns2          = var.internal_vpc_dns2
  this_network_cidr          = var.this_network_cidr
  this_network_gw            = var.this_network_gw
  this_net_start_ip          = var.this_net_start_ip
  this_net_end_ip            = var.this_net_end_ip
  provider_region            = var.provider_region
  ibmcloud_api_key           = var.ibmcloud_api_key
}


# Conditionally create either the Transit Gateway connection Directly or Cloud Connection
resource "ibm_tg_connection" "test_ibm_tg_connection" {
  # Create only if this_pvs_dc is in the list
  #count = data.ibm_pi_workspace.this_workspace[0].pi_workspace_capabilities.cloud-connections == true ? 0 : 1
  count = contains(var.per_datacenters, var.this_dc_name) ? 1 : 0
  gateway      = var.transit_gw_id
  network_type = "power_virtual_server"
  name         = "${var.this_dc_name}-ocp-vpc"
  network_id   = module.workspace.workspace_crn
}

resource "ibm_pi_cloud_connection" "cloud_connection" {
  # Create only if this_pvs_dc is not in the list
  #count = data.ibm_pi_workspace.this_workspace[0].pi_workspace_capabilities.cloud-connections == true ? 1 : 0
  count                               = contains(var.per_datacenters, var.this_dc_name) ? 0 : 1
  pi_cloud_instance_id                = module.workspace.workspace_id
  pi_cloud_connection_name            = "ocp-cloud-connection-${var.this_dc_name}"
  pi_cloud_connection_speed           = 1000
  pi_cloud_connection_transit_enabled = true
}

resource "time_sleep" "wait_cloud_connection" {
  count           = length(ibm_pi_cloud_connection.cloud_connection)
  depends_on      = [ibm_pi_cloud_connection.cloud_connection]
  create_duration = "2m"
}

resource "ibm_pi_cloud_connection_network_attach" "attachment" {
  # Depends on cloud_connection being created
  depends_on             = [time_sleep.wait_cloud_connection]
  count                  = length(ibm_pi_cloud_connection.cloud_connection)
  pi_cloud_instance_id   = module.workspace.workspace_id
  pi_cloud_connection_id = element(split("/", ibm_pi_cloud_connection.cloud_connection[count.index].id), 1)
  pi_network_id          = module.network.this_network_id
}

data "ibm_dl_gateway" "ocp_cloud_connection" {
  count      = length(ibm_pi_cloud_connection.cloud_connection)
  depends_on = [time_sleep.wait_cloud_connection]
  name       = "ocp-cloud-connection-${var.this_dc_name}"
}

resource "ibm_tg_connection" "cloud_gw_tg_connection" {
  # Depends on cloud_connection being created
  depends_on   = [time_sleep.wait_cloud_connection]
  count        = length(ibm_pi_cloud_connection.cloud_connection)
  gateway      = var.transit_gw_id
  network_type = "directlink"
  name         = "${var.this_dc_name}-ocp-vpc"
  network_id   = data.ibm_dl_gateway.ocp_cloud_connection[count.index].crn
}


module "ocp_instance" {
  depends_on            = [module.workspace, module.network, module.ocp_image, module.lnx_image, module.ssh_key]
  source                = "./ocp_instance"
  for_each              = var.ocp_instances_zone.ocp_instances
  this_pi_instance_name = each.value.pi_instance_name
  this_pi_memory        = each.value.pi_memory
  this_pi_processors    = each.value.pi_processors
  this_pi_proc_type     = each.value.pi_proc_type
  this_pi_sys_type      = each.value.pi_sys_type
  this_pi_pin_policy    = each.value.pi_pin_policy
  this_pi_health_status = each.value.pi_health_status
  this_ip_address       = each.value.ip_address
  this_ocp_image_id     = module.ocp_image.this_ocp_image_id
  this_pi_user_data     = each.value.pi_user_data
  this_workspace_id     = module.workspace.workspace_id
  this_network_id       = module.network.this_network_id
  ssh_key_id            = module.ssh_key.ssh_key_id
  this_image_id         = module.ocp_image.this_ocp_image_id
  provider_region       = var.provider_region
  ibmcloud_api_key      = var.ibmcloud_api_key
  bootstrap_init       = var.bootstrap_init
  this_pvs_dc           = var.this_pvs_dc
  internal_vpc_dns1     = var.internal_vpc_dns1
  internal_vpc_dns2     = var.internal_vpc_dns2
}


module "get_ocp_inst" {
  source            = "./get_ocp_inst"
  depends_on        = [module.ocp_instance]
  this_workspace_id = module.workspace.workspace_id
  ibmcloud_api_key  = var.ibmcloud_api_key
  ocp_instances_zone = var.ocp_instances_zone
}

module "build_dhcp" {
  source             = "./build_dhcp"
  depends_on         = [module.get_ocp_inst]
  ocp_instance_mac   = module.get_ocp_inst.ocp_instance_mac
  ibmcloud_api_key   = var.ibmcloud_api_key
  ocp_cluster_name   = var.ocp_cluster_name
  ocp_cluster_domain = var.ocp_cluster_domain
  this_network_addr  = var.this_network_addr
  this_network_mask  = var.this_network_mask
  internal_vpc_dns1  = var.internal_vpc_dns1
  internal_vpc_dns2  = var.internal_vpc_dns2
  this_network_gw    = var.this_network_gw
}



module "lnx_instance" {
  depends_on = [module.build_dhcp]
  source                = "./lnx_instance"
  #  depends_on = [module.ocp_inst_shut]
  for_each              = var.lnx_instances_zone.lnx_instances
  this_pi_instance_name = each.value.pi_instance_name
  this_pi_memory        = each.value.pi_memory
  this_pi_processors    = each.value.pi_processors
  this_pi_proc_type     = each.value.pi_proc_type
  this_pi_sys_type      = each.value.pi_sys_type
  this_pi_pin_policy    = each.value.pi_pin_policy
  this_pi_health_status = each.value.pi_health_status
  this_ip_address       = each.value.ip_address
  this_workspace_id     = module.workspace.workspace_id
  this_network_id       = module.network.this_network_id
  ssh_key_id            = module.ssh_key.ssh_key_id
  cloud_init_file       = module.build_dhcp.cloud_init_file
  this_pi_image_id      = module.lnx_image.this_lnx_image_id
  provider_region       = var.provider_region
  ibmcloud_api_key      = var.ibmcloud_api_key
  this_pvs_dc           = var.this_pvs_dc
}




variable "this_dc_name" {}
variable "transit_gw_id" {}

variable "internal_vpc_dns1" {}

variable "internal_vpc_dns2" {}

variable "this_pvs_dc" {
type = string
}

variable "ibm_resource_group_id" {
type = string
}

variable "this_service_instance_name" {
type = string
}

variable "this_network_cidr" {
type = string
}

variable "this_network_gw" {
type = string
}

variable "this_net_start_ip" {
type = string
}

variable "this_net_end_ip" {
type = string
}

variable "pi_ssh_key" {
  type = string
}

variable "ocp_instances_zone" {
  type = map(any)
}

variable "lnx_instances_zone" {
  type = map(any)
}

variable "per_datacenters" {}
variable "ocp_pi_image" {}
variable "provider_region" {}
variable "ibmcloud_api_key" {}
variable "ocp_cluster_name" {}
variable "ocp_cluster_domain" {}
variable "this_network_addr" {}
variable "this_network_mask" {}
variable "bootstrap_init" {}
