variable "ibmcloud_api_key" {
  default = "Not_this_API_KEY"
  description = "On the safe side, delete this variable entry and create a terraform.tfvars file with the content with the ssh_key"
}

variable "pi_ssh_key" {
  default = "Not_this_ssh_key"
  description = "On the safe side, delete this variable entry and create a terraform.tfvars file with the content with the ibmcloud_api_key"
}


variable "ocp_cluster_name" {
  default = "ocp"
}

variable "ocp_cluster_domain" {
  default = "example.com"
}


variable "instance_sizes" {
  type    = map(any)
  default = {
    size = {
      bootstrap = {
        pi_memory        = "24",
        pi_processors    = "1",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING",
      },
      master = {
        pi_memory        = "32",
        pi_processors    = "1",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING",
      },
      worker = {
        pi_memory        = "64",
        pi_processors    = "4",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING"
      },
      linux = {
        pi_memory = "4",
        pi_processors = "0.25",
        pi_proc_type = "shared",
        pi_sys_type = "s922",
        pi_pin_policy = "none",
        pi_health_status = "WARNING",
      }
    }
  }
}



variable "region_entries" {
  default = {
    region = "us-south"
    vpc_name = "ocp-vpc"
    zone1 = {
      dc_name = "dal10"
      pvs_dc_name = "dal10"
      pvs_dc_cidr = "192.168.100.0/24"
      vpc_zone_name = "us-south-1"
      vpc_zone_cidr = "10.0.101.0/24"
    }
    zone2 = {
      dc_name = "dal12"
      pvs_dc_name = "dal12"
      pvs_dc_cidr = "192.168.102.0/24"
      vpc_zone_name = "us-south-2"
      vpc_zone_cidr = "10.0.102.0/24"
    }
    zone3 = {
      dc_name = "dal13"
      pvs_dc_name = "us-south"
      pvs_dc_cidr = "192.168.103.0/24"
      vpc_zone_name = "us-south-3"
      vpc_zone_cidr = "10.0.103.0/24"
    }
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


variable "workspace_plan" {
  type = string
  default = "public"
}


