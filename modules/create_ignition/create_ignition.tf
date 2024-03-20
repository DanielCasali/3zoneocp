variable "pull_secret_file" {
  default = "pull-secret"
}

variable "ssh_public_key_file" {
  default = "id_rsa.pub"
}

locals {
  pull_secret = file(var.pull_secret_file)
  ssh_public_key = file("${path.module}/${var.ssh_public_key_file}")

  install_config = {
    apiVersion = "v1"
    baseDomain = "${var.ocp_config.ocp_cluster_domain}"
    proxy = {
      httpProxy  = "http://proxy.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain}:8080"
      httpsProxy = "http://proxy.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain}:8080"
      noProxy    = ".apps.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain},api.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain},api-int.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain},${var.region_entries.zone1.vpc_zone_cidr},${var.region_entries.zone2.vpc_zone_cidr},${var.region_entries.zone3.vpc_zone_cidr},${var.region_entries.zone1.pvs_dc_cidr},${var.region_entries.zone2.pvs_dc_cidr},${var.region_entries.zone3.pvs_dc_cidr}"
    }
    compute = [
      {
        hyperthreading = "Enabled"
        name           = "worker"
        replicas       = 3
        architecture   = "ppc64le"
      }
    ]
    controlPlane = {
      hyperthreading = "Enabled"
      name           = "master"
      replicas       = 3
      architecture   = "ppc64le"
    }
    metadata = {
      name = "${var.ocp_config.ocp_cluster_name}"
    }
    networking = var.ocp_config.networking
    platform = {
      none = {}
    }
    pullSecret = local.pull_secret
    sshKey = local.ssh_public_key
  }
}

resource "local_file" "install_config" {
  content  = yamlencode(local.install_config)
  filename = "${path.module}/install-config.yaml"
}



locals {
  chrony_config = <<-EOT
    # Add your chrony configuration here
    server ${var.internal_vpc_dns1} iburst
    server ${var.internal_vpc_dns2} iburst
    driftfile /var/lib/chrony/drift
    makestep 1.0 3
    rtcsync
    logdir /var/log/chrony
  EOT
}

data "ignition_file" "chrony_config" {
  filesystem = "root"
  path       = "/etc/chrony.conf"
  mode       = "0644"
  content {
    content = base64encode(local.chrony_config)
  }
}


variable "region_entries" {}

variable "ocp_config" {}

variable "internal_vpc_dns1" {
  type = string
}

variable "internal_vpc_dns2" {
  type = string
}