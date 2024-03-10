variable "instance_sizes" {}
variable "region_entries" {}


locals {
  pvs_zone1 = {
    network_cidr = var.region_entries.zone1.pvs_dc_cidr
    network_addr = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 0)
    network_mask = cidrnetmask(var.region_entries.zone1.pvs_dc_cidr, 0)
    network_gw   = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 1)
    net_start_ip = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 5)
    net_end_ip   = cidrhost(var.region_entries.zone1.pvs_dc_cidr, -2)
  }
  ocp_instances_zone1 = {
    bootstrap = {
      pi_instance_name = "bootstrap",
      pi_memory        = var.instance_sizes.size.bootstrap.pi_memory,
      pi_processors    = var.instance_sizes.size.bootstrap.pi_processors,
      pi_proc_type     = var.instance_sizes.size.bootstrap.pi_proc_type,
      pi_sys_type      = var.instance_sizes.size.bootstrap.pi_sys_type,
      pi_pin_policy    = var.instance_sizes.size.bootstrap.pi_pin_policy,
      pi_health_status = var.instance_sizes.size.bootstrap.pi_health_status,
      pi_user_data     = base64encode(file("${path.module}/../../bootstrap.ign")),
    }
    master = {
      pi_instance_name = "master1",
      pi_memory        = var.instance_sizes.size.master.pi_memory,
      pi_processors    = var.instance_sizes.size.master.pi_processors,
      pi_proc_type     = var.instance_sizes.size.master.pi_proc_type,
      pi_sys_type      = var.instance_sizes.size.master.pi_sys_type,
      pi_pin_policy    = var.instance_sizes.size.master.pi_pin_policy,
      pi_health_status = var.instance_sizes.size.master.pi_health_status,
      pi_user_data     = base64encode(file("${path.module}/../../master.ign")),
    }
    worker = {
      pi_instance_name = "worker1",
      pi_memory        = var.instance_sizes.size.worker.pi_memory,
      pi_processors    = var.instance_sizes.size.worker.pi_processors,
      pi_proc_type     = var.instance_sizes.size.worker.pi_proc_type,
      pi_sys_type      = var.instance_sizes.size.worker.pi_sys_type,
      pi_pin_policy    = var.instance_sizes.size.worker.pi_pin_policy,
      pi_health_status = var.instance_sizes.size.worker.pi_health_status,
      pi_user_data     = base64encode(file("${path.module}/../../worker.ign")),
    },
  }
  lnx_instances_zone1 = {
    lnx_instances = {
      linux = {
        pi_instance_name = "linux1",
        pi_memory        = var.instance_sizes.size.linux.pi_memory,
        pi_processors    = var.instance_sizes.size.linux.pi_processors,
        pi_proc_type     = var.instance_sizes.size.linux.pi_proc_type,
        pi_sys_type      = var.instance_sizes.size.linux.pi_sys_type,
        pi_pin_policy    = var.instance_sizes.size.linux.pi_pin_policy,
        pi_health_status = var.instance_sizes.size.linux.pi_health_status,
        pi_image_id      = "1fa28b82-16c8-4fa2-8f25-986d50ca2f36",
      }
    }
  }
  pvs_zone2 = {
    network_cidr = var.region_entries.zone2.pvs_dc_cidr
    network_addr = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 0)
    network_mask = cidrnetmask(var.region_entries.zone2.pvs_dc_cidr, 0)
    network_gw   = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 1)
    net_start_ip = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 5)
    net_end_ip   = cidrhost(var.region_entries.zone2.pvs_dc_cidr, -2)
  }
  ocp_instances_zone2 = {
    master = {
      pi_instance_name = "master2",
      pi_memory        = var.instance_sizes.size.master.pi_memory,
      pi_processors    = var.instance_sizes.size.master.pi_processors,
      pi_proc_type     = var.instance_sizes.size.master.pi_proc_type,
      pi_sys_type      = var.instance_sizes.size.master.pi_sys_type,
      pi_pin_policy    = var.instance_sizes.size.master.pi_pin_policy,
      pi_health_status = var.instance_sizes.size.master.pi_health_status,
      pi_user_data     = base64encode(file("${path.module}/../../master.ign")),
    }
    worker = {
      pi_instance_name = "worker2",
      pi_memory        = var.instance_sizes.size.worker.pi_memory,
      pi_processors    = var.instance_sizes.size.worker.pi_processors,
      pi_proc_type     = var.instance_sizes.size.worker.pi_proc_type,
      pi_sys_type      = var.instance_sizes.size.worker.pi_sys_type,
      pi_pin_policy    = var.instance_sizes.size.worker.pi_pin_policy,
      pi_health_status = var.instance_sizes.size.worker.pi_health_status,
      pi_user_data     = base64encode(file("${path.module}/../../worker.ign")),
    }
  }
  lnx_instances_zone2 = {
    lnx_instances = {
      linux = {
        pi_instance_name = "linux2",
        pi_memory        = var.instance_sizes.size.linux.pi_memory,
        pi_processors    = var.instance_sizes.size.linux.pi_processors,
        pi_proc_type     = var.instance_sizes.size.linux.pi_proc_type,
        pi_sys_type      = var.instance_sizes.size.linux.pi_sys_type,
        pi_pin_policy    = var.instance_sizes.size.linux.pi_pin_policy,
        pi_health_status = var.instance_sizes.size.linux.pi_health_status,
        pi_image_id      = "1fa28b82-16c8-4fa2-8f25-986d50ca2f36",
      }
    }
  }
  pvs_zone3 = {
    network_cidr = var.region_entries.zone3.pvs_dc_cidr
    network_addr = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 0)
    network_mask = cidrnetmask(var.region_entries.zone3.pvs_dc_cidr, 0)
    network_gw   = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 1)
    net_start_ip = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 5)
    net_end_ip   = cidrhost(var.region_entries.zone3.pvs_dc_cidr, -2)
  }
  ocp_instances_zone3 = {
    master = {
      pi_instance_name = "master3",
      pi_memory        = var.instance_sizes.size.master.pi_memory,
      pi_processors    = var.instance_sizes.size.master.pi_processors,
      pi_proc_type     = var.instance_sizes.size.master.pi_proc_type,
      pi_sys_type      = var.instance_sizes.size.master.pi_sys_type,
      pi_pin_policy    = var.instance_sizes.size.master.pi_pin_policy,
      pi_health_status = var.instance_sizes.size.master.pi_health_status,
      pi_user_data     = base64encode(file("${path.module}/../../master.ign")),
    }
    worker = {
      pi_instance_name = "worker3",
      pi_memory        = var.instance_sizes.size.worker.pi_memory,
      pi_processors    = var.instance_sizes.size.worker.pi_processors,
      pi_proc_type     = var.instance_sizes.size.worker.pi_proc_type,
      pi_sys_type      = var.instance_sizes.size.worker.pi_sys_type,
      pi_pin_policy    = var.instance_sizes.size.worker.pi_pin_policy,
      pi_health_status = var.instance_sizes.size.worker.pi_health_status,
      pi_user_data     = base64encode(file("${path.module}/../../worker.ign")),
    }
  }
  lnx_instances_zone3 = {
    lnx_instances = {
      linux = {
        pi_instance_name = "linux3",
        pi_memory        = var.instance_sizes.size.linux.pi_memory,
        pi_processors    = var.instance_sizes.size.linux.pi_processors,
        pi_proc_type     = var.instance_sizes.size.linux.pi_proc_type,
        pi_sys_type      = var.instance_sizes.size.linux.pi_sys_type,
        pi_pin_policy    = var.instance_sizes.size.linux.pi_pin_policy,
        pi_health_status = var.instance_sizes.size.linux.pi_health_status,
        pi_image_id      = "1fa28b82-16c8-4fa2-8f25-986d50ca2f36",
      }
    }
  }
}

