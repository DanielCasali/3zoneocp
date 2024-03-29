resource "ibm_is_lb" "lb_int" {
  name           = "internal-lb"
  subnets        = [var.subnet1_vpc_id, var.subnet2_vpc_id, var.subnet3_vpc_id]
  type           = "private"
  resource_group = var.ibm_resource_group_id
}



resource "ibm_is_lb_pool" "proxy" {
  depends_on = [ibm_is_lb.lb_int]
  name           = "proxy"
  lb             = ibm_is_lb.lb_int.id
  algorithm      = "round_robin"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 5
  health_timeout = 2
  health_type    = "tcp"
  proxy_protocol = "disabled"
}

resource "ibm_is_lb_pool" "apps" {
  depends_on = [ibm_is_lb.lb_int]
  name           = "apps"
  lb             = ibm_is_lb.lb_int.id
  algorithm      = "round_robin"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 5
  health_timeout = 2
  health_type    = "tcp"
  proxy_protocol = "disabled"
}

resource "ibm_is_lb_pool" "app" {
  depends_on = [ibm_is_lb.lb_int]
  name           = "app"
  lb             = ibm_is_lb.lb_int.id
  algorithm      = "round_robin"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 5
  health_timeout = 2
  health_type    = "tcp"
  proxy_protocol = "disabled"
}

resource "ibm_is_lb_pool" "api" {
  depends_on = [ibm_is_lb.lb_int]
  name           = "api"
  lb             = ibm_is_lb.lb_int.id
  algorithm      = "round_robin"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 5
  health_timeout = 2
  health_type    = "tcp"
  proxy_protocol = "disabled"
}

resource "ibm_is_lb_pool" "cfgmgr" {
  depends_on = [ibm_is_lb.lb_int]
  name           = "cfgmgr"
  lb             = ibm_is_lb.lb_int.id
  algorithm      = "round_robin"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 5
  health_timeout = 2
  health_type    = "tcp"
  proxy_protocol = "disabled"
}


resource "ibm_is_lb_listener" "proxy" {
  depends_on = [ibm_is_lb_pool.proxy]
  lb           = ibm_is_lb.lb_int.id
  port         = "8080"
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.proxy.pool_id
}


resource "ibm_is_lb_listener" "apps" {
  depends_on = [ibm_is_lb_pool.apps]
  lb           = ibm_is_lb.lb_int.id
  port         = "443"
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.apps.pool_id
}

resource "ibm_is_lb_listener" "app" {
  depends_on = [ibm_is_lb_pool.app]
  lb           = ibm_is_lb.lb_int.id
  port         = "80"
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.app.pool_id
}

resource "ibm_is_lb_listener" "api" {
  depends_on = [ibm_is_lb_pool.api]
  lb           = ibm_is_lb.lb_int.id
  port         = "6443"
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.api.pool_id
}


resource "ibm_is_lb_listener" "cfgmgr" {
  depends_on = [ibm_is_lb_pool.cfgmgr]
  lb           = ibm_is_lb.lb_int.id
  port         = "22623"
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.cfgmgr.pool_id
}



resource "ibm_is_lb_pool_member" "proxy1" {
  depends_on = [ibm_is_lb_listener.proxy]
  lb        = ibm_is_lb.lb_int.id
  pool      = element(split("/", ibm_is_lb_pool.proxy.id), 1)
  port      = 3128
  target_id = var.instance1_id
  weight    = 60
}

resource "ibm_is_lb_pool_member" "proxy2" {
  depends_on = [ibm_is_lb_listener.proxy]
  lb        = ibm_is_lb.lb_int.id
  pool      = element(split("/", ibm_is_lb_pool.proxy.id), 1)
  port      = 3128
  target_id = var.instance2_id
  weight    = 60
}

resource "ibm_is_lb_pool_member" "api_bootstrap" {
  depends_on = [ibm_is_lb_listener.api]
  lb        = ibm_is_lb.lb_int.id
  pool      = element(split("/", ibm_is_lb_pool.api.id), 1)
  port      = 6443
  target_address = var.ocp_instances_zone1.ocp_instances.bootstrap.ip_address
  weight    = 60
}

resource "ibm_is_lb_pool_member" "api_master" {
  for_each       = local.all_master_instances
  depends_on = [ibm_is_lb_listener.api]
  lb        = ibm_is_lb.lb_int.id
  pool      = element(split("/", ibm_is_lb_pool.api.id), 1)
  port      = 6443
  target_address = each.value.ip_address
  weight    = 60
}

resource "ibm_is_lb_pool_member" "cfgmgr_bootstrap" {
  depends_on = [ibm_is_lb_listener.cfgmgr]
  lb        = ibm_is_lb.lb_int.id
  pool      = element(split("/", ibm_is_lb_pool.cfgmgr.id), 1)
  port      = 22623
  target_address = var.ocp_instances_zone1.ocp_instances.bootstrap.ip_address
  weight    = 60
}

resource "ibm_is_lb_pool_member" "cfgmgr_master" {
  for_each       = local.all_master_instances
  depends_on = [ibm_is_lb_listener.cfgmgr]
  lb        = ibm_is_lb.lb_int.id
  pool      = element(split("/", ibm_is_lb_pool.cfgmgr.id), 1)
  port      = 22623
  target_address = each.value.ip_address
  weight    = 60
}


resource "ibm_is_lb_pool_member" "app_worker" {
  for_each       = local.all_worker_instances
  depends_on     = [ibm_is_lb_listener.app]
  lb             = ibm_is_lb.lb_int.id
  pool           = element(split("/", ibm_is_lb_pool.app.id), 1)
  port           = 80
  target_address = each.value.ip_address
  weight         = 60
}

resource "ibm_is_lb_pool_member" "apps_worker" {
  for_each       = local.all_worker_instances
  depends_on     = [ibm_is_lb_listener.apps]
  lb             = ibm_is_lb.lb_int.id
  pool           = element(split("/", ibm_is_lb_pool.apps.id), 1)
  port           = 443
  target_address = each.value.ip_address
  weight         = 60
}


resource "ibm_is_lb" "lb_ext" {
  name           = "external-lb"
  subnets        = [var.subnet1_vpc_id, var.subnet2_vpc_id, var.subnet3_vpc_id]
  type           = "public"
  resource_group = var.ibm_resource_group_id
}


resource "ibm_is_lb_pool" "ssh1" {
  depends_on = [ibm_is_lb.lb_ext]
  name           = "ssh1"
  lb             = ibm_is_lb.lb_ext.id
  algorithm      = "round_robin"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 5
  health_timeout = 2
  health_type    = "tcp"
  proxy_protocol = "disabled"
}

resource "ibm_is_lb_pool" "ssh2" {
  depends_on = [ibm_is_lb.lb_ext]
  name           = "ssh2"
  lb             = ibm_is_lb.lb_ext.id
  algorithm      = "round_robin"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 5
  health_timeout = 2
  health_type    = "tcp"
  proxy_protocol = "disabled"
}

resource "ibm_is_lb_pool" "ext_apps" {
  depends_on = [ibm_is_lb.lb_ext]
  name           = "apps"
  lb             = ibm_is_lb.lb_ext.id
  algorithm      = "round_robin"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 5
  health_timeout = 2
  health_type    = "tcp"
  proxy_protocol = "disabled"
}

resource "ibm_is_lb_pool" "ext_app" {
  depends_on = [ibm_is_lb.lb_ext]
  name           = "app"
  lb             = ibm_is_lb.lb_ext.id
  algorithm      = "round_robin"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 5
  health_timeout = 2
  health_type    = "tcp"
  proxy_protocol = "disabled"
}

resource "ibm_is_lb_pool" "ext_api" {
  depends_on = [ibm_is_lb.lb_ext]
  name           = "api"
  lb             = ibm_is_lb.lb_ext.id
  algorithm      = "round_robin"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 5
  health_timeout = 2
  health_type    = "tcp"
  proxy_protocol = "disabled"
}


resource "ibm_is_lb_listener" "ssh1" {
  depends_on = [ibm_is_lb_pool.ssh1]
  lb           = ibm_is_lb.lb_ext.id
  port         = "22222"
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.ssh1.pool_id
  idle_connection_timeout = 7200
}

resource "ibm_is_lb_listener" "ssh2" {
  depends_on = [ibm_is_lb_pool.ssh2]
  lb           = ibm_is_lb.lb_ext.id
  port         = "22223"
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.ssh2.pool_id
  idle_connection_timeout = 7200
}


resource "ibm_is_lb_listener" "ext_apps" {
  depends_on = [ibm_is_lb_pool.ext_apps]
  lb           = ibm_is_lb.lb_ext.id
  port         = "443"
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.ext_apps.pool_id
}

resource "ibm_is_lb_listener" "ext_app" {
  depends_on = [ibm_is_lb_pool.ext_app]
  lb           = ibm_is_lb.lb_ext.id
  port         = "80"
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.ext_app.pool_id
}

resource "ibm_is_lb_listener" "ext_api" {
  depends_on = [ibm_is_lb_pool.ext_api]
  lb           = ibm_is_lb.lb_ext.id
  port         = "6443"
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.ext_api.pool_id
}

resource "ibm_is_lb_pool_member" "ssh1" {
  depends_on = [ibm_is_lb_listener.ssh1]
  lb        = ibm_is_lb.lb_ext.id
  pool      = element(split("/", ibm_is_lb_pool.ssh1.id), 1)
  port      = 22
  target_id = var.instance1_id
  weight    = 60
}

resource "ibm_is_lb_pool_member" "ssh2" {
  depends_on = [ibm_is_lb_listener.ssh2]
  lb        = ibm_is_lb.lb_ext.id
  pool      = element(split("/", ibm_is_lb_pool.ssh2.id), 1)
  port      = 22
  target_id = var.instance2_id
  weight    = 60
}


resource "ibm_is_lb_pool_member" "ext_api_master" {
  for_each       = local.all_master_instances
  depends_on = [ibm_is_lb_listener.ext_api]
  lb        = ibm_is_lb.lb_ext.id
  pool      = element(split("/", ibm_is_lb_pool.ext_api.id), 1)
  port      = 6443
  target_address = each.value.ip_address
  weight    = 60
}

resource "ibm_is_lb_pool_member" "ext_app_worker" {
  for_each       = local.all_worker_instances
  depends_on     = [ibm_is_lb_listener.ext_app]
  lb             = ibm_is_lb.lb_ext.id
  pool           = element(split("/", ibm_is_lb_pool.ext_app.id), 1)
  port           = 80
  target_address = each.value.ip_address
  weight         = 60
}

resource "ibm_is_lb_pool_member" "ext_apps_worker" {
  for_each       = local.all_worker_instances
  depends_on     = [ibm_is_lb_listener.ext_apps]
  lb             = ibm_is_lb.lb_ext.id
  pool           = element(split("/", ibm_is_lb_pool.ext_apps.id), 1)
  port           = 443
  target_address = each.value.ip_address
  weight         = 60
}


locals {
  all_ocp_instances = merge(
    var.ocp_instances_zone1.ocp_instances,
    var.ocp_instances_zone2.ocp_instances,
    var.ocp_instances_zone3.ocp_instances
  )

  all_worker_instances = { for k, v in local.all_ocp_instances : k => v if startswith(k, "worker") }
  all_master_instances = { for k, v in local.all_ocp_instances : k => v if startswith(k, "master") }
}





variable "ibm_resource_group_id" {}
variable "ocp_instances_zone1" {}
variable "ocp_instances_zone2" {}
variable "ocp_instances_zone3" {}
variable "instance1_id" {}
variable "instance2_id" {}
variable "ibmcloud_api_key" {}
variable "subnet1_vpc_id" {}
variable "subnet2_vpc_id" {}
variable "subnet3_vpc_id" {}
