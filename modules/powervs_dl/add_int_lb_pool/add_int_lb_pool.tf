resource "ibm_is_lb_pool_member" "app" {
  for_each = var.ocp_instance_mac.instance-list
  lb        = var.lb_int_id
  pool      = var.lb_int_pool_app_id
  port      = 80
  target_address = each.value.ip_address
  weight    = 60
}

resource "ibm_is_lb_pool_member" "apps" {
  for_each = var.ocp_instance_mac.instance-list
  lb        = var.lb_int_id
  pool      = var.lb_int_pool_apps_id
  port      = 443
  target_address = each.value.ip_address
  weight    = 60
}

resource "ibm_is_lb_pool_member" "api" {
  for_each = var.ocp_instance_mac.instance-list
  lb        = var.lb_int_id
  pool      = var.lb_int_pool_api_id
  port      = 6443
  target_address = each.value.ip_address
  weight    = 60
}

resource "ibm_is_lb_pool_member" "cfgmgr" {
  for_each = var.ocp_instance_mac.instance-list
  lb        = var.lb_int_id
  pool      = var.lb_int_pool_cfgmgr_id
  port      = 22623
  target_address = each.value.ip_address
  weight    = 60
}

variable "lb_int_id" {}
variable "lb_int_pool_api_id" {}
variable "lb_int_pool_app_id" {}
variable "lb_int_pool_apps_id" {}
variable "lb_int_pool_cfgmgr_id" {}
variable "ocp_instance_mac" {}
variable "ibmcloud_api_key" {}
variable "this_workspace_id" {
  type = string
}