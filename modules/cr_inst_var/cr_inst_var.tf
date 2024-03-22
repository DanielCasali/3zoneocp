variable "instance_sizes" {}
variable "region_entries" {}
variable "internal_vpc_dns1" {}
variable "internal_vpc_dns2" {}

#output "worker_distribution" {
#  value = {
#    total_workers         = var.instance_sizes.size.worker.number
#    num_workers_per_zone  = local.num_workers_per_zone
#    remaining_workers     = local.remaining_workers
#    num_workers_zone1     = local.num_workers_zone1
#    num_workers_zone2     = local.num_workers_zone2
#    num_workers_zone3     = local.num_workers_zone3
#    worker_instances_zone1 = local.worker_instances_zone1
#    worker_instances_zone2 = local.worker_instances_zone2
#    worker_instances_zone3 = local.worker_instances_zone3
#  }
#}

locals {
  num_workers_per_zone = floor(var.instance_sizes.size.worker.number / 3)
  remaining_workers = (var.instance_sizes.size.worker.number % 3)
  num_workers_zone1 = (local.num_workers_per_zone + (local.remaining_workers > 0 ? 1 : 0))
  num_workers_zone2 = (local.num_workers_per_zone + (local.remaining_workers > 1 ? 1 : 0))
  num_workers_zone3 = (local.num_workers_per_zone + (local.remaining_workers > 2 ? 1 : 0))
  worker_instances_zone1 = {
    for i in range(1, local.num_workers_zone1 + 1 ) :
    format("worker%d", (i - 1) * 3 + 1) => {
      pi_instance_name = format("worker%d", (i - 1) * 3 + 1 )
      pi_memory        = var.instance_sizes.size.worker.pi_memory
      pi_processors    = var.instance_sizes.size.worker.pi_processors
      pi_proc_type     = var.instance_sizes.size.worker.pi_proc_type
      pi_sys_type      = var.instance_sizes.size.worker.pi_sys_type
      pi_pin_policy    = var.instance_sizes.size.worker.pi_pin_policy
      pi_health_status = var.instance_sizes.size.worker.pi_health_status
      ip_address       = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 7 + i)
      pi_user_data     = base64encode(local.worker_ignition_updated),
    }
  }
  worker_instances_zone2 = {
    for i in range(1, local.num_workers_zone2 + 1 ) :
    format("worker%d", (i - 1) * 3 + 2) => {
      pi_instance_name = format("worker%d", (i - 1) * 3 + 2)
      pi_memory        = var.instance_sizes.size.worker.pi_memory
      pi_processors    = var.instance_sizes.size.worker.pi_processors
      pi_proc_type     = var.instance_sizes.size.worker.pi_proc_type
      pi_sys_type      = var.instance_sizes.size.worker.pi_sys_type
      pi_pin_policy    = var.instance_sizes.size.worker.pi_pin_policy
      pi_health_status = var.instance_sizes.size.worker.pi_health_status
      ip_address       = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 7 + i)
      pi_user_data     = base64encode(local.worker_ignition_updated),
    }
  }
  worker_instances_zone3 = {
    for i in range(1, local.num_workers_zone3 + 1 ) :
    format("worker%d", (i - 1) * 3 + 3) => {
      pi_instance_name = format("worker%d", (i - 1) * 3 + 3)
      pi_memory        = var.instance_sizes.size.worker.pi_memory
      pi_processors    = var.instance_sizes.size.worker.pi_processors
      pi_proc_type     = var.instance_sizes.size.worker.pi_proc_type
      pi_sys_type      = var.instance_sizes.size.worker.pi_sys_type
      pi_pin_policy    = var.instance_sizes.size.worker.pi_pin_policy
      pi_health_status = var.instance_sizes.size.worker.pi_health_status
      ip_address       = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 7 + i)
      pi_user_data     = base64encode(local.worker_ignition_updated),
    }
  }
  pvs_zone1 = {
    name         = var.region_entries.zone1.pvs_workspace1_name
    network_cidr = var.region_entries.zone1.pvs_dc_cidr
    network_addr = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 0)
    network_mask = cidrnetmask(var.region_entries.zone1.pvs_dc_cidr)
    network_gw   = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 1)
    net_start_ip = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 5)
    net_end_ip   = cidrhost(var.region_entries.zone1.pvs_dc_cidr, -2)
  }
  ocp_instances_zone1 = {
    ocp_instances = merge({
      bootstrap = {
        pi_instance_name = "bootstrap",
        pi_memory        = var.instance_sizes.size.bootstrap.pi_memory,
        pi_processors    = var.instance_sizes.size.bootstrap.pi_processors,
        pi_proc_type     = var.instance_sizes.size.bootstrap.pi_proc_type,
        pi_sys_type      = var.instance_sizes.size.bootstrap.pi_sys_type,
        pi_pin_policy    = var.instance_sizes.size.bootstrap.pi_pin_policy,
        pi_health_status = var.instance_sizes.size.bootstrap.pi_health_status,
        ip_address       = cidrhost(var.region_entries.zone1.pvs_dc_cidr, -2),
        pi_user_data     = base64encode(local.bootstrap_ignition_updated),
      }
      master1 = {
        pi_instance_name = "master1",
        pi_memory        = var.instance_sizes.size.master.pi_memory,
        pi_processors    = var.instance_sizes.size.master.pi_processors,
        pi_proc_type     = var.instance_sizes.size.master.pi_proc_type,
        pi_sys_type      = var.instance_sizes.size.master.pi_sys_type,
        pi_pin_policy    = var.instance_sizes.size.master.pi_pin_policy,
        pi_health_status = var.instance_sizes.size.master.pi_health_status,
        ip_address       = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 6),
        pi_user_data     = base64encode(local.master_ignition_updated),
      }
    }, local.worker_instances_zone1)
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
        ip_address       = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 5)
      }
    }
  }
  pvs_zone2 = {
    name         = var.region_entries.zone2.pvs_workspace2_name
    network_cidr = var.region_entries.zone2.pvs_dc_cidr
    network_addr = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 0)
    network_mask = cidrnetmask(var.region_entries.zone1.pvs_dc_cidr)
    network_gw   = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 1)
    net_start_ip = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 5)
    net_end_ip   = cidrhost(var.region_entries.zone2.pvs_dc_cidr, -2)
  }
  ocp_instances_zone2 = {
    ocp_instances = merge({
      master2 = {
        pi_instance_name = "master2",
        pi_memory        = var.instance_sizes.size.master.pi_memory,
        pi_processors    = var.instance_sizes.size.master.pi_processors,
        pi_proc_type     = var.instance_sizes.size.master.pi_proc_type,
        pi_sys_type      = var.instance_sizes.size.master.pi_sys_type,
        pi_pin_policy    = var.instance_sizes.size.master.pi_pin_policy,
        pi_health_status = var.instance_sizes.size.master.pi_health_status,
        ip_address       = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 6),
        pi_user_data     = base64encode(local.master_ignition_updated),
      }
    }, local.worker_instances_zone2)
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
        ip_address       = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 5),
      }
    }
  }
  pvs_zone3 = {
    name         = var.region_entries.zone3.pvs_workspace3_name
    network_cidr = var.region_entries.zone3.pvs_dc_cidr
    network_addr = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 0)
    network_mask = cidrnetmask(var.region_entries.zone1.pvs_dc_cidr)
    network_gw   = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 1)
    net_start_ip = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 5)
    net_end_ip   = cidrhost(var.region_entries.zone3.pvs_dc_cidr, -2)
  }
  ocp_instances_zone3 = {
    ocp_instances = merge({
      master3 = {
        pi_instance_name = "master3",
        pi_memory        = var.instance_sizes.size.master.pi_memory,
        pi_processors    = var.instance_sizes.size.master.pi_processors,
        pi_proc_type     = var.instance_sizes.size.master.pi_proc_type,
        pi_sys_type      = var.instance_sizes.size.master.pi_sys_type,
        pi_pin_policy    = var.instance_sizes.size.master.pi_pin_policy,
        pi_health_status = var.instance_sizes.size.master.pi_health_status,
        ip_address       = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 6),
        pi_user_data     = base64encode(local.master_ignition_updated),
      }
    }, local.worker_instances_zone3)
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
        ip_address       = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 5),
      }
    }
  }
}







locals {
  bootstrap_ignition = file("${path.module}/../../bootstrap.ign")
  master_ignition = file("${path.module}/../../master.ign")
  worker_ignition = file("${path.module}/../../worker.ign")
  chrony_config = <<-EOF
    server ${var.internal_vpc_dns1} iburst
    server ${var.internal_vpc_dns2} iburst

    driftfile /var/lib/chrony/drift
    makestep 1.0 3
    rtcsync

    logdir /var/log/chrony
  EOF
  chrony_config_base64 = base64encode(local.chrony_config)
  chrony_file = [
    {
      path     = "/etc/chrony.conf"
      mode     = 420
      contents = {
        source = "data:text/plain;charset=utf-8;base64,${local.chrony_config_base64}"
      }
    }
  ]

  bootstrap_ignition_updated = merge(local.bootstrap_ignition, {
    storage = {
      files = local.chrony_file
    }
  })

  worker_ignition_updated = merge(local.worker_ignition, {
    storage = {
      files = local.chrony_file
    }
  })

  master_ignition_updated = merge(local.master_ignition, {
    storage = {
      files = local.chrony_file
    }
  })
}


data "template_file" "vpc_infra_init_config" {
  template = <<-EOF
#cloud-config
write_files:
  - path: /etc/chrony.conf
    content: |
      server 0.centos.pool.ntp.org iburst
      server 1.centos.pool.ntp.org iburst
      server 2.centos.pool.ntp.org iburst
      server 3.centos.pool.ntp.org iburst
      driftfile /var/lib/chrony/drift
      makestep 1.0 3
      rtcsync
      allow ${var.region_entries.zone1.pvs_dc_cidr}
      allow ${var.region_entries.zone2.pvs_dc_cidr}
      allow ${var.region_entries.zone3.pvs_dc_cidr}
      bindcmdaddress 0.0.0.0
      logdir /var/log/chrony
packages:
  - dnsmasq
  - squid
  - chrony
runcmd:
  - [ /usr/bin/sed, -ie, '/acl SSL_ports port 443/a acl SSL_ports port 6443', /etc/squid/squid.conf ]
  - [ /usr/bin/sed, -ie, '/acl Safe_ports port 443/a acl Safe_ports port 6443', /etc/squid/squid.conf ]
  - [ /usr/bin/sed, -ie, 's/interface=lo//', /etc/dnsmasq.conf ]
  - [ systemctl, enable, squid.service, --now ]
  - [ systemctl, enable, dnsmasq.service, --now ]
  - [ systemctl, restart, squid.service ]
  - [ systemctl, enable, chronyd.service ]
  - [ systemctl, restart, chronyd.service ]
EOF
}