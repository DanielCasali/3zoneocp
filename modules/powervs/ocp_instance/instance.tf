

resource "ibm_pi_instance" "instance" {
  pi_memory             = var.this_pi_memory
  pi_processors         = var.this_pi_processors
  pi_instance_name      = var.this_pi_instance_name
  pi_proc_type          = var.this_pi_proc_type
  pi_image_id           = data.ibm_pi_image.this_image.id
  pi_key_pair_name      = var.ssh_key_id
  pi_sys_type           = var.this_pi_sys_type
  pi_cloud_instance_id  = var.this_workspace_id
  pi_pin_policy         = var.this_pi_pin_policy
  pi_health_status      = var.this_pi_health_status
  pi_user_data = ""
  pi_network {
    network_id = var.this_network_id
  }
}


data "ibm_pi_image" "this_image" {
  pi_image_name        = var.this_pi_image_name
  pi_cloud_instance_id = var.this_workspace_id
}

variable "this_pi_instance_name" {
}

variable "this_pi_image_name" {

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