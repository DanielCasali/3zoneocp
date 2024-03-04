variable "internal_vpc_dns1" {
  default = "8.8.4.4"
}
variable "internal_vpc_dns2" {
  default = "8.8.8.8"
}


variable "provider_region" {
  default = "us-south"
}

variable "zone1" {
  default = "dal10"
}

variable "zone2" {
  default = "dal12"
}

variable "zone3" {
  default = "us-south"
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

variable "powervs_zone1" {
  type = map(any)
  default = {
    ibm_provider = "ibm.powervs1",
    network_cidr = "192.168.101.0/24",
    network_gw   = "192.168.101.1",
    net_start_ip = "192.168.101.5",
    net_end_ip   = "192.168.101.254"
  }
}
variable "ocp_instances_zone1" {
  type    = map(any)
  default = {
    ocp_instances = {
      bootstrap = {
        pi_instance_name = "bootstrap",
        pi_memory        = "32",
        pi_processors    = "1",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING",
        pi_user_data     = {},
        pi_image_name    = "OCP412",
      },
      master = {
        pi_instance_name = "master1",
        pi_memory        = "32",
        pi_processors    = "1",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING",
        pi_user_data     = {},
        pi_image_name    = "OCP412",
      },
      worker = {
        pi_instance_name = "worker1",
        pi_memory        = "64",
        pi_processors    = "4",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING",
        pi_user_data     = {},
        pi_image_name    = "OCP412",
      },
    },
  }
}

variable "lnx_instances_zone1" {
  type    = map(any)
  default = {
    lnx_instances = {
      linux = {
        pi_instance_name = "linux1",
        pi_memory = "32",
        pi_processors = "2",
        pi_proc_type = "shared",
        pi_sys_type = "s922",
        pi_pin_policy = "none",
        pi_health_status = "WARNING",
        pi_user_data = {},
        pi_image_name = "RHEL8-SP8",
      }
    }
  }
}

variable "powervs_zone2" {
  type = map(any)
  default = {
    ibm_provider = "ibm.powervs1",
    network_cidr = "192.168.102.0/24",
    network_gw   = "192.168.102.1",
    net_start_ip = "192.168.102.5",
    net_end_ip   = "192.168.102.254"
  }
}


variable "ocp_instances_zone2" {
  type    = map(any)
  default = {
    ocp_instances = {
      master = {
        pi_instance_name = "master2",
        pi_memory        = "32",
        pi_processors    = "1",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING",
        pi_user_data     = {},
        pi_image_name    = "OCP412",
      },
      worker = {
        pi_instance_name = "worker2",
        pi_memory        = "64",
        pi_processors    = "4",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING",
        pi_user_data     = {},
        pi_image_name    = "OCP412",
      }
    }
  }
}

variable "lnx_instances_zone2" {
  type    = map(any)
  default = {
    lnx_instances = {
      linux = {
        pi_instance_name = "linux2",
        pi_memory = "32",
        pi_processors = "2",
        pi_proc_type = "shared",
        pi_sys_type = "s922",
        pi_pin_policy = "none",
        pi_health_status = "WARNING",
        pi_user_data = {},
        pi_image_name = "RHEL8-SP8",
      }
    }
  }
}

variable "powervs_zone3" {
  type = map(any)
  default = {
    ibm_provider = "ibm.powervs1",
    network_cidr = "192.168.103.0/24",
    network_gw   = "192.168.103.1",
    net_start_ip = "192.168.103.5",
    net_end_ip   = "192.168.103.254"
  }
}

variable "ocp_instances_zone3" {
  type    = map(any)
  default = {
    ocp_instances = {
      master = {
        pi_instance_name = "master3",
        pi_memory        = "32",
        pi_processors    = "1",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING",
        pi_user_data     = {},
        pi_image_name    = "OCP412"
      },
      worker = {
        pi_instance_name = "worker3",
        pi_memory        = "64",
        pi_processors    = "4",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING",
        pi_user_data     = {},
        pi_image_name    = "OCP412"
      }
    }
  }
}

variable "lnx_instances_zone3" {
  type    = map(any)
  default = {
    lnx_instances = {
      linux = {
        pi_instance_name = "linux3",
        pi_memory = "32",
        pi_processors = "2",
        pi_proc_type = "shared",
        pi_sys_type = "s922",
        pi_pin_policy = "none",
        pi_health_status = "WARNING",
        pi_user_data = {},
        pi_image_name = "RHEL8-SP8",
      }
    }
  }
}

