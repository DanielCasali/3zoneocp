output "ocp_instances_zone1" {
  value = local.ocp_instances_zone1
}

output "ocp_instances_zone2" {
  value = local.ocp_instances_zone2
}

output "ocp_instances_zone3" {
  value = local.ocp_instances_zone3
}

output "lnx_instances_zone1" {
  value = local.lnx_instances_zone1
}

output "lnx_instances_zone2" {
  value = local.lnx_instances_zone2
}
output "lnx_instances_zone3" {
  value = local.lnx_instances_zone3
}
output "pvs_zone1" {
  value = local.pvs_zone1
}

output "pvs_zone2" {
  value = local.pvs_zone2
}

output "pvs_zone3" {
  value = local.pvs_zone3
}

output "vpc_infra_init_config" {
  value = data.template_file.vpc_infra_init_config.rendered
}


output "bootstrap_init_file" {
  value = base64encode(data.template_file.bootstrap_init_config.rendered)
}


data "template_file" "bootstrap_init_config" {
  template = <<-EOF
{
  "ignition": {
    "version": "3.2.0",
    "proxy": {
      "httpProxy": "http://proxy.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain}:8080",
      "httpsProxy": "http://proxy.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain}:8080",
      "noProxy": [ ".apps.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain}", "api.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain}", "api-int.${var.ocp_config.ocp_cluster_name}.${var.ocp_config.ocp_cluster_domain}", "${var.region_entries.zone1.vpc_zone_cidr}", "${var.region_entries.zone2.vpc_zone_cidr}", "${var.region_entries.zone3.vpc_zone_cidr}", "${var.region_entries.zone1.pvs_dc_cidr}", "${var.region_entries.zone2.pvs_dc_cidr}", "${var.region_entries.zone3.pvs_dc_cidr}" ]
    },
    "config": {
      "replace": {
        "source": "https://s3.${var.region_entries.region}.cloud-object-storage.appdomain.cloud/${var.ibm_resource_group_id}/bootstrap.ign"
      }
    }
  }
}
EOF
}