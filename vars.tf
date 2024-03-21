variable "ibmcloud_api_key" {
  default = "Not_this_API_KEY"
  description = "On the safe side, create a terraform.tfvars file with the content with the ssh_key"
}

variable "pi_ssh_key" {
  default = "Not_this_ssh_key"
  description = "On the safe side, create a terraform.tfvars file with the content with the ibmcloud_api_key"
}

variable "ocp_config" {
  default = {
    ocp_cluster_name   = "ocp"
    ocp_cluster_domain = "example.com"
    #Maintain this format for ocp_version, we will download the latest ova for the version
    ocp_version  = "4.12"
    networking = {
      clusterNetwork = [
        {
          cidr        = "10.128.0.0/14"
          hostPrefix  = 23
        }
      ]
      networkType    = "OpenShiftSDN"
      serviceNetwork = ["172.30.0.0/16"]
    }
  }
}

#
#The configuration uses proxy for security, no public IP will be exposed into your PowerVS Subnet, make sure to add these lines into install-config.yaml when generating the ignitions
#proxy:
#  httpProxy: http://proxy.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain}:8080
#  httpsProxy: http://proxy.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain}:8080
#  noProxy: ".apps.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain},api.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain},api-int.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain},${var.region_entries.zone1.vpc_zone_cidr},${var.region_entries.zone2.vpc_zone_cidr},${var.region_entries.zone3.vpc_zone_cidr},${var.region_entries.zone1.pvs_dc_cidr},${var.region_entries.zone2.pvs_dc_cidr},${var.region_entries.zone3.pvs_dc_cidr}"
#
#Here is an example (the private DNS will be created automatically for you - you may or not add a public DNS or use your enterprise DNS - feel free to choose):
#
#proxy:
#  httpProxy: http://proxy.ocp.example.com:8080
#  httpsProxy: http://proxy.ocp.example.com:8080
#  noProxy: .ocp.example.com,api.ocp.example.com,api-int.ocp.example.com,10.0.101.0/24,10.0.102.0/24,10.0.103.0/24,192.168.101.0/24,192.168.102.0/24,192.168.103.0/24


variable "region_entries" {
  default = {
    region = "us-south"
    vpc_name = "ocp-vpc"
    zone1 = {
      dc_name = "dal10"
      ws_zone_name = "dal10"
      vpc_zone_name = "us-south-1"
      pvs_dc_cidr = "192.168.101.0/24"
      vpc_zone_cidr = "10.0.101.0/24"
    }
    zone2 = {
      dc_name = "dal12"
      ws_zone_name = "dal12"
      vpc_zone_name = "us-south-2"
      pvs_dc_cidr = "192.168.102.0/24"
      vpc_zone_cidr = "10.0.102.0/24"
    }
    zone3 = {
      dc_name = "dal13"
      ws_zone_name = "us-south"
      vpc_zone_name = "us-south-3"
      pvs_dc_cidr = "192.168.103.0/24"
      vpc_zone_cidr = "10.0.103.0/24"
    }
  }
}

variable "instance_sizes" {
  type    = map(any)
  default = {
    size = {
      bootstrap = {
        #There will be only one bootstrap, this server is not needed after install
        pi_memory        = "16",
        pi_processors    = "0.25",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING",
      },
      master = {
        #There will be 3 masters one each zone number is not configurable.
        pi_memory        = "16",
        pi_processors    = "0.25",
        pi_proc_type     = "shared",
        pi_sys_type      = "s922",
        pi_pin_policy    = "none",
        pi_health_status = "WARNING",
      },
      worker = {
        #Choose the number of workers here:
        number           = 3,
        pi_memory        = "16",
        pi_processors    = "0.25",
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





