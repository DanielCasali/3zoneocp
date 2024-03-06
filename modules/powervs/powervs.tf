
module "workspace" {
  source    = "./workspace"
  ibm_resource_group_id = var.ibm_resource_group_id
  this_service_instance_name = var.this_service_instance_name
  this_zone = var.this_zone
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}

module "ocp_image" {
  source = "./ocp_image"
  depends_on = [module.workspace]
  ocp_pi_image = var.ocp_pi_image
  this_workspace_id = module.workspace.workspace_id
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}
module "ssh_key" {
  source = "./ssh_key"
  depends_on = [module.workspace]
  this_workspace_id = module.workspace.workspace_id
  pi_ssh_key = var.pi_ssh_key
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}


module "network" {
  source    = "./network"
  depends_on = [module.workspace]
  this_workspace_id = module.workspace.workspace_id
  this_service_instance_name = var.this_service_instance_name
  this_zone = var.this_zone
  internal_vpc_dns1 = var.internal_vpc_dns1
  internal_vpc_dns2 = var.internal_vpc_dns2
  this_network_cidr = var.this_network_cidr
  this_network_gw = var.this_network_gw
  this_net_start_ip = var.this_net_start_ip
  this_net_end_ip = var.this_net_end_ip
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}

module "ocp_instance" {
  depends_on = [module.workspace,module.network,module.ocp_image,module.ssh_key]
  source = "./ocp_instance"
  for_each = var.ocp_instances_zone.ocp_instances
  this_pi_instance_name      = each.value.pi_instance_name
  this_pi_memory             = each.value.pi_memory
  this_pi_processors         = each.value.pi_processors
  this_pi_proc_type          = each.value.pi_proc_type
  this_pi_sys_type           = each.value.pi_sys_type
  this_pi_pin_policy         = each.value.pi_pin_policy
  this_pi_health_status      = each.value.pi_health_status
  this_pi_image_name         = var.ocp_pi_image.ocp_pi_image_name
  this_ocp_image_id = module.ocp_image.this_ocp_image_id
  this_pi_user_data = each.value.pi_user_data
  this_workspace_id = module.workspace.workspace_id
  this_network_id = module.network.this_network_id
  ssh_key_id = module.ssh_key.ssh_key_id
  this_image_id = module.ocp_image.this_ocp_image_id
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}


module "get_ocp_inst" {
  source = "./get_ocp_inst"
  depends_on = [module.ocp_instance]
  this_workspace_id = module.workspace.workspace_id
  ibmcloud_api_key = var.ibmcloud_api_key
}

module "build_dhcp" {
  source     = "./build_dhcp"
  depends_on = [module.get_ocp_inst]
  instances = module.get_ocp_inst.ocp_instance_mac
  ibmcloud_api_key = var.ibmcloud_api_key
}

#module "ocp_inst_shut" {
#  source     = "./inst_shut"
#  depends_on = [module.get_ocp_inst]
#  ocp_instance_mac = module.get_ocp_inst.ocp_instance_mac
#  ibmcloud_api_key = var.ibmcloud_api_key
#  this_workspace_id = module.workspace.workspace_id
#}

module "lnx_instance" {
  source = "./lnx_instance"
#  depends_on = [module.ocp_inst_shut]
  for_each = var.lnx_instances_zone.lnx_instances
  this_pi_instance_name      = each.value.pi_instance_name
  this_pi_memory             = each.value.pi_memory
  this_pi_processors         = each.value.pi_processors
  this_pi_proc_type          = each.value.pi_proc_type
  this_pi_sys_type           = each.value.pi_sys_type
  this_pi_pin_policy         = each.value.pi_pin_policy
  this_pi_health_status      = each.value.pi_health_status
  this_pi_image_id         = each.value.pi_image_id
  this_pi_user_data = each.value.pi_user_data
  this_workspace_id = module.workspace.workspace_id
  this_network_id = module.network.this_network_id
  ssh_key_id = module.ssh_key.ssh_key_id
  ocp_instance_mac = module.get_ocp_inst.ocp_instance_mac
  this_image_id = each.value.pi_image_id
  provider_region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}

#module "ocp_inst_up" {
#  source     = "./inst_up"
#  depends_on = [module.lnx_instance]
#  ocp_instance_mac = module.get_ocp_inst.ocp_instance_mac
#  ibmcloud_api_key = var.ibmcloud_api_key
#  this_workspace_id = module.workspace.workspace_id
#}



variable "internal_vpc_dns1" {
  type = string
}

variable "internal_vpc_dns2" {
  type = string
}

variable "this_zone" {
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

variable "ocp_pi_image" {}
variable "provider_region" {}
variable "ibmcloud_api_key" {}