
module "vpc" {
  source = "./modules/vpc"
  providers = {
    ibm = ibm
  }
}


module "res-group" {
  source = "./modules/res-group"
  providers = {
    ibm = ibm
  }
}

module "powervs" {
  source    = "./modules/powervs"
  ibm_resource_group_id = module.res-group.ibm_resource_group_id
  for_each = var.loop_workspace
  providers = {
    ibm = ibm.each.value.ibm_provider
  }
  this_service_instance_name = each.key
  this_zone = each.value.region_zone
  this_network_cidr = each.value.network_cidr,
  this_network_gw   = each.value.network_gw,
  this_net_start_ip = each.value.net_start_ip,
  this_net_end_ip   = each.value.net_end_ip,
  this_ocp_instances    = each.value.ocp_instances,
  this_linux_instances    = each.value.linux_instances,
  internal_vpc_dns1          = var.internal_vpc_dns1,
  internal_vpc_dns2          = var.internal_vpc_dns2,
  pi_ssh_key = var.pi_ssh_key
  ocp_pi_image_bucket_access = var.ocp_pi_image_bucket_access
  ocp_pi_image_bucket_file_name = var.ocp_pi_image_bucket_file_name
  ocp_pi_image_bucket_name = var.ocp_pi_image_bucket_name
  ocp_pi_image_bucket_region = var.ocp_pi_image_bucket_region
  ocp_pi_image_name = var.ocp_pi_image_name
  ocp_pi_image_storage_type = var.ocp_pi_image_storage_type
}
