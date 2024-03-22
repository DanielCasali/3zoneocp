resource "ibm_pi_instance" "instance" {
  pi_memory            = var.this_pi_memory
  pi_processors        = var.this_pi_processors
  pi_instance_name     = var.this_pi_instance_name
  pi_proc_type         = var.this_pi_proc_type
  pi_image_id          = var.this_ocp_image_id
  pi_key_pair_name     = "ocp-ssh-key-${var.this_pvs_dc}"
  pi_sys_type          = var.this_pi_sys_type
  pi_cloud_instance_id = var.this_workspace_id
  pi_pin_policy        = var.this_pi_pin_policy
  pi_health_status     = var.this_pi_health_status
  pi_user_data         = var.this_pi_instance_name == "bootstrap" ? var.bootstrap_init : local.base64_ignition_updated
  pi_network {
    network_id = var.this_network_id
    ip_address = var.this_ip_address
  }
}


locals {
  original_ignition = var.this_pi_user_data
  chrony_config = <<-EOF
    server ${var.internal_vpc_dns1} iburst
    server ${var.internal_vpc_dns2} iburst

    driftfile /var/lib/chrony/drift
    makestep 1.0 3
    rtcsync

    logdir /var/log/chrony
  EOF
  chrony_config_base64 = base64encode(local.chrony_config)
  chrony_file = [
    {
      path     = "/etc/chrony.conf"
      mode     = 420
      contents = {
        source = "data:text/plain;charset=utf-8;base64,${local.chrony_config_base64}"
      }
    }
  ]

  ignition_updated = merge(local.original_ignition, {
    storage = {
      files = local.chrony_file
    }
  })
  base64_ignition_updated = base64encode(ignition_updated)
}

variable "internal_vpc_dns1" {}
variable "internal_vpc_dns2" {}
variable "this_pvs_dc" {}
variable "this_ip_address" {}
variable "this_pi_instance_name" {}
variable "ssh_key_id" {}
variable "this_workspace_id" {}
variable "this_pi_memory"{}
variable "this_pi_processors"{}
variable "this_pi_proc_type"{}
variable "this_pi_sys_type" {}
variable "this_pi_pin_policy" {}
variable "this_pi_health_status" {}
variable "this_pi_user_data" {}
variable "this_ocp_image_id" {}
variable "this_network_id" {}
variable "bootstrap_init" {}
variable "this_image_id" {}
variable "provider_region" {}
variable "ibmcloud_api_key" {}