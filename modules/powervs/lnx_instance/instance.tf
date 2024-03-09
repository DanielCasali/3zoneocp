

resource "ibm_pi_instance" "instance" {
  pi_memory             = var.this_pi_memory
  pi_processors         = var.this_pi_processors
  pi_instance_name      = var.this_pi_instance_name
  pi_proc_type          = var.this_pi_proc_type
  pi_image_id           = local.usable_image_id
  pi_key_pair_name      = "ocp-ssh-key"
  pi_sys_type           = var.this_pi_sys_type
  pi_cloud_instance_id  = var.this_workspace_id
  pi_pin_policy         = var.this_pi_pin_policy
  pi_health_status      = var.this_pi_health_status
  pi_user_data = var.cloud_init_file
  pi_network {
    network_id = var.this_network_id
  }
}


locals {
  usable_image_id = element(split("/", var.this_pi_image_id), 1)
}

variable "cloud_init_file" {}

variable "this_pi_instance_name" {
}

variable "this_pi_image_id" {

}

variable "ssh_key_id" {
}

variable "this_workspace_id" {
}

variable "this_pi_memory"{

}

variable "this_pi_processors"{

}
variable "this_pi_proc_type"{

}
variable "this_pi_sys_type" {

}
variable "this_pi_pin_policy" {

}
variable "this_pi_health_status" {

}
variable "this_pi_user_data" {

}

variable "this_network_id" {}

variable "this_image_id" {}
variable "provider_region" {}
variable "ibmcloud_api_key" {}