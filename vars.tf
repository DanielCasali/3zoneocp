variable "internal_vpc_dns1" {
  default = "8.8.4.4"
}
variable "internal_vpc_dns2" {
  default = "8.8.8.8"
}


variable "provider_region" {
  default = "us-south"
}

variable "region_zone1" {
  default = "dal10"
}

variable "region_zone2" {
  default = "dal12"
}

variable "region_zone3" {
  default = "dal13"
}

variable "ibmcloud_api_key" {
  default = "Not_this_API_KEY"
}

variable "pi_ssh_key" {
  default = "Not_this_ssh_key"
}

variable "ocp_pi_image_name" {
  default = "OCP412"
}
variable "ocp_pi_image_bucket_name" {
  default = "images-public-bucket"
}

variable "ocp_pi_image_bucket_access" {
  default = "public"
}
variable "ocp_pi_image_bucket_region" {
  default = "us-south"
}
variable "ocp_pi_image_bucket_file_name" {
  default = "rhcos-48-07222021.ova.gz"
}
variable "ocp_pi_image_storage_type" {
  default = "tier3"
}


variable "loop_workspace" {
  description = "Map for each workspace."
  type        = map(any)
  default = {
    powervs1 = {
      region_zone  = var.region_zone1,
      ibm_provider = "ibm.powervs1",
      network_cidr = "192.168.101.0/24",
      network_gw   = "192.168.101.1",
      net_start_ip = "192.168.101.5",
      net_end_ip   = "192.168.101.254",
      ocp_instances = [
        {
          pi_instance_name      = "bootstrap",
          pi_memory             = "16",
          pi_processors         = "1",
          pi_proc_type          = "shared",
          pi_sys_type           = "s922",
          pi_pin_policy         = "none",
          pi_health_status      = "WARNING",
          pi_user_data = {},
          pi_image_name = "OCP412",
        },
        {
          pi_instance_name      = "master1",
          pi_memory             = "32",
          pi_processors         = "1",
          pi_proc_type          = "shared",
          pi_sys_type           = "s922",
          pi_pin_policy         = "none",
          pi_health_status      = "WARNING",
          pi_user_data = {},
          pi_image_name = "OCP412",
        },
        {
          pi_instance_name      = "worker1",
          pi_memory             = "64",
          pi_processors         = "4",
          pi_proc_type          = "shared",
          pi_sys_type           = "s922",
          pi_pin_policy         = "none",
          pi_health_status      = "WARNING",
          pi_user_data = {},
          pi_image_name = "OCP412",
        },
      ],
      linux_instances = [
        {
          pi_instance_name      = "linux1",
          pi_memory             = "32",
          pi_processors         = "2",
          pi_proc_type          = "shared",
          pi_sys_type           = "s922",
          pi_pin_policy         = "none",
          pi_health_status      = "WARNING",
          pi_user_data = {},
          pi_image_name = "RHEL8-SP8",
        },
    ],
    },
    powervs2 = {
      region_zone  = var.region_zone2,
      ibm_provider = "ibm.powervs2",
      network_cidr = "192.168.102.0/24",
      network_gw   = "192.168.102.1",
      net_start_ip = "192.168.102.5",
      net_end_ip   = "192.168.102.254",
      ocp_instances = [
        {
          pi_instance_name      = "master2",
          pi_memory             = "32",
          pi_processors         = "1",
          pi_proc_type          = "shared",
          pi_sys_type           = "s922",
          pi_pin_policy         = "none",
          pi_health_status      = "WARNING",
          pi_user_data = {},
          pi_image_name = "OCP412",
        },
        {
          pi_instance_name      = "worker2",
          pi_memory             = "64",
          pi_processors         = "4",
          pi_proc_type          = "shared",
          pi_sys_type           = "s922",
          pi_pin_policy         = "none",
          pi_health_status      = "WARNING",
          pi_user_data = {},
          pi_image_name = "OCP412",
        },
      ],
      linux_instances = [
        {
          pi_instance_name      = "linux2",
          pi_memory             = "32",
          pi_processors         = "2",
          pi_proc_type          = "shared",
          pi_sys_type           = "s922",
          pi_pin_policy         = "none",
          pi_health_status      = "WARNING",
          pi_user_data = {},
          pi_image_name = "RHEL8-SP8",
        },
      ],
    },
    powervs3 = {
      region_zone  = var.region_zone3,
      ibm_provider = "ibm.powervs3",
      network_cidr = "192.168.103.0/24",
      network_gw   = "192.168.103.1",
      net_start_ip = "192.168.103.5",
      net_end_ip   = "192.168.103.254",
      ocp_instances = [
        {
          pi_instance_name      = "master3",
          pi_memory             = "32",
          pi_processors         = "1",
          pi_proc_type          = "shared",
          pi_sys_type           = "s922",
          pi_pin_policy         = "none",
          pi_health_status      = "WARNING",
          pi_user_data = {},
          pi_image_name = "OCP412",
        },
        {
          pi_instance_name      = "worker3",
          pi_memory             = "64",
          pi_processors         = "4",
          pi_proc_type          = "shared",
          pi_sys_type           = "s922",
          pi_pin_policy         = "none",
          pi_health_status      = "WARNING",
          pi_user_data = {},
          pi_image_name = "OCP412",
        },
      ],
      linux_instances = [
        {
          pi_instance_name      = "linux3",
          pi_memory             = "32",
          pi_processors         = "2",
          pi_proc_type          = "shared",
          pi_sys_type           = "s922",
          pi_pin_policy         = "none",
          pi_health_status      = "WARNING",
          pi_user_data = {},
          pi_image_name = "RHEL8-SP8",
        },
      ],
    }
  }
}