variable "ocp_cluster_name" {
  default = "ocp"

}

variable "ocp_cluster_domain" {
  default = "example.com"

}
variable "provider_region" {
  default = "us-south"
}

variable "pvs_dc1" {
  default = "dal10"
}

variable "pvs_dc2" {
  default = "dal12"
}

variable "pvs_dc3" {
  default = "dal13"
}

variable "ibmcloud_api_key" {
  default = "Not_this_API_KEY"
  description = "On the safe side, delete this variable entry and create a terraform.tfvars file with the content with the ssh_key"
}

variable "pi_ssh_key" {
  default = "Not_this_ssh_key"
  description = "On the safe side, delete this variable entry and create a terraform.tfvars file with the content with the ibmcloud_api_key"
}


variable "vpc" {
  type = map(any)
  default = {
    name           = "ocp-vpc"
  }
}


variable "ocp_pi_image" {
  type = map(any)
  default = {
    ocp_pi_image_name = "OCP412"
    ocp_pi_image_bucket_name = "images-public-bucket"
    ocp_pi_image_bucket_access = "public"
    ocp_pi_image_bucket_region = "us-south"
    ocp_pi_image_bucket_file_name = "rhcos-48-07222021.ova.gz"
    ocp_pi_image_storage_type = "tier3"
  }
}

variable "vpc_zone1_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "vpc_zone2_cidr" {
  type = string
  default = "10.0.2.0/24"
}

variable "vpc_zone3_cidr" {
  type = string
  default = "10.0.3.0/24"
}

variable "vpc_zone_1" {
  type = string
  default = "us-south-1"
}
variable "vpc_zone_2" {
  type = string
  default = "us-south-2"
}
variable "vpc_zone_3" {
  type = string
  default = "us-south-3"
}

variable "workspace_plan" {
  type = string
  default = "public"
}
variable "pvs_zone1" {
  type = map(any)
  default = {
    network_cidr = "192.168.101.0/24",
    network_addr = "192.168.101.0",
    network_mask = "255.255.255.0",
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
        pi_image_id = "1fa28b82-16c8-4fa2-8f25-986d50ca2f36",
      }
    }
  }
}

variable "pvs_zone2" {
  type = map(any)
  default = {
    network_cidr = "192.168.102.0/24",
    network_addr = "192.168.102.0",
    network_mask = "255.255.255.0",
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
        pi_image_id = "1fa28b82-16c8-4fa2-8f25-986d50ca2f36",
      }
    }
  }
}

variable "pvs_zone3" {
  type = map(any)
  default = {
    network_cidr = "192.168.103.0/24",
    network_addr = "192.168.103.0",
    network_mask = "255.255.255.0",
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
        pi_image_id = "1fa28b82-16c8-4fa2-8f25-986d50ca2f36",
      }
    }
  }
}

