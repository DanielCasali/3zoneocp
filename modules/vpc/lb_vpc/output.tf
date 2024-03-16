output "lb_ext_hostname" {
  value = ibm_is_lb.lb_ext.hostname
}


output "lb_int_hostname" {
  value = ibm_is_lb.lb_int.hostname
}

output "lb_int_id" {
  value = ibm_is_lb.lb_int.id
}

output "lb_int_pool_api_id" {
  value = element(split("/", ibm_is_lb_pool.api.id), 1)
}

output "lb_int_pool_apps_id" {
  value = element(split("/", ibm_is_lb_pool.apps.id), 1)
}

output "lb_int_pool_app_id" {
  value = element(split("/", ibm_is_lb_pool.app.id), 1)
}

output "lb_int_pool_cfgmgr_id" {
  value = element(split("/", ibm_is_lb_pool.cfgmgr.id), 1)
}
