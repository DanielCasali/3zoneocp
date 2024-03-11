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
  value = base64encode(data.template_file.vpc_infra_init_config.rendered)
}
