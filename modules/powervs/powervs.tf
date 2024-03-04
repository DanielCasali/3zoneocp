
module "workspace" {
  source    = "./workspace"
  ibm_resource_group_id = var.ibm_resource_group_id
  this_service_instance_name = var.this_service_instance_name
  this_zone = var.this_zone
}

module "ocp_image" {
  source = "./ocp_image"
  ocp_pi_image_bucket_access = var.ocp_pi_image_bucket_access
  ocp_pi_image_bucket_file_name = var.ocp_pi_image_bucket_file_name
  ocp_pi_image_bucket_name = var.ocp_pi_image_bucket_name
  ocp_pi_image_bucket_region = var.ocp_pi_image_bucket_region
  ocp_pi_image_name = var.ocp_pi_image_name
  ocp_pi_image_storage_type = var.ocp_pi_image_storage_type
  this_workspace_id = module.workspace.workspace_id
}
module "ssh_key" {
  source = "./ssh_key"
  this_workspace_id = module.workspace.workspace_id
  pi_ssh_key = var.pi_ssh_key
}


module "network" {
  source    = "./network"
  this_workspace_id = module.workspace.workspace_id
  this_service_instance_name = var.this_service_instance_name
  this_zone = var.this_zone
  internal_vpc_dns1 = var.internal_vpc_dns1,
  internal_vpc_dns2 = var.internal_vpc_dns2,
  this_network_cidr = var.this_network_cidr,
  this_network_gw = var.this_network_gw,
  this_net_start_ip = var.this_net_start_ip,
  this_net_end_ip = var.this_net_end_ip,
}

module "ocp_instance" {
  source = "./ocp_instance"
  for_each = var.this_ocp_instances[obj],
  this_pi_instance_name      = each.value.obj.pi_instance_name,
  this_pi_memory             = each.value.obj.pi_memory,
  this_pi_processors         = each.value.obj.pi_processors,
  this_pi_proc_type          = each.value.obj._pi_proc_type,
  this_pi_sys_type           = each.value.obj.pi_pin_policy,
  this_pi_pin_policy         = each.value.obj.pi_health_status,
  this_pi_health_status      = each.value.obj.pi_health_status,
  this_pi_user_data = each.value.obj.pi_user_data,
  this_pi_image_name = each.value.obj.pi_image_name,
  this_workspace_id = module.workspace.workspace_id,
  this_network_id = module.network.this_network_id,
  ssh_key_id = module.ssh_key.ssh_key_id,
  this_ocp_image_id = module.ocp_image.this_ocp_image_id
}

module "linux_instance" {
  source = "./linux_instance"
  for_each = var.this_linux_instances[obj],
  this_pi_instance_name      = each.value.obj.pi_instance_name,
  this_pi_memory             = each.value.obj.pi_memory,
  this_pi_processors         = each.value.obj.pi_processors,
  this_pi_proc_type          = each.value.obj._pi_proc_type,
  this_pi_sys_type           = each.value.obj.pi_pin_policy,
  this_pi_pin_policy         = each.value.obj.pi_health_status,
  this_pi_health_status      = each.value.obj.pi_health_status,
  this_pi_user_data = each.value.obj.pi_user_data,
  this_pi_image_name = each.value.obj.pi_image_name,
  this_workspace_id = module.workspace.workspace_id,
  this_network_id = module.network.this_network_id,
  ssh_key_id = module.ssh_key.ssh_key_id,
}

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
variable "this_ocp_instances" {
  type = list(any)
}

variable "this_linux_instances" {
  type = list(any)
}

variable "ocp_pi_image_name" {}
variable "ocp_pi_image_bucket_name" {}
variable "ocp_pi_image_bucket_access" {}
variable "ocp_pi_image_bucket_region" {}
variable "ocp_pi_image_bucket_file_name" {}
variable "ocp_pi_image_storage_type" {}