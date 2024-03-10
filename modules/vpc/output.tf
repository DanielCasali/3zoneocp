output "vpc_instance1_ip" {
  value = module.create_inst1.ibm_instance_ip
}

output "vpc_instance2_ip" {
  value = module.create_inst2.ibm_instance_ip
}


output "lb_int_id" {
  value = module.lb_int.lb_int_id
}

output "lb_int_pool_apps_id" {
  value = module.lb_int.lb_int_pool_apps_id
}

output "lb_int_pool_app_id" {
  value = module.lb_int.lb_int_pool_app_id
}

output "lb_int_pool_cfgmgr_id" {
  value = module.lb_int.lb_int_pool_cfgmgr_id
}

output "lb_int_pool_api_id" {
  value = module.lb_int.lb_int_pool_api_id
}

output "vpc_id" {
  value = module.create_vpc.vpc_id
}

output "vpc_crn" {
  value = module.create_vpc.vpc_crn
}