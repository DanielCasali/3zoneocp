variable "instance_sizes" {}
variable "region_entries" {}


locals {
  pvs_zone1 = {
    network_cidr = var.region_entries.zone1.pvs_dc_cidr
    network_addr = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 0)
    network_mask = cidrnetmask(var.region_entries.zone1.pvs_dc_cidr)
    network_gw   = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 1)
    net_start_ip = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 5)
    net_end_ip   = cidrhost(var.region_entries.zone1.pvs_dc_cidr, -2)
  }
  ocp_instances_zone1 = {
    ocp_instances = {
      bootstrap = {
        pi_instance_name = "bootstrap",
        pi_memory        = var.instance_sizes.size.bootstrap.pi_memory,
        pi_processors    = var.instance_sizes.size.bootstrap.pi_processors,
        pi_proc_type     = var.instance_sizes.size.bootstrap.pi_proc_type,
        pi_sys_type      = var.instance_sizes.size.bootstrap.pi_sys_type,
        pi_pin_policy    = var.instance_sizes.size.bootstrap.pi_pin_policy,
        pi_health_status = var.instance_sizes.size.bootstrap.pi_health_status,
        ip_address       = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 8),
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
        ip_address       = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 6),
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
        ip_address       = cidrhost(var.region_entries.zone1.pvs_dc_cidr, 7),
        pi_user_data     = base64encode(file("${path.module}/../../worker.ign")),
      }
    }
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
        pi_image_id      = "1fa28b82-16c8-4fa2-8f25-986d50ca2f36",
      }
    }
  }
  pvs_zone2 = {
    network_cidr = var.region_entries.zone2.pvs_dc_cidr
    network_addr = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 0)
    network_mask = cidrnetmask(var.region_entries.zone1.pvs_dc_cidr)
    network_gw   = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 1)
    net_start_ip = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 5)
    net_end_ip   = cidrhost(var.region_entries.zone2.pvs_dc_cidr, -2)
  }
  ocp_instances_zone2 = {
    ocp_instances = {
      master = {
        pi_instance_name = "master2",
        pi_memory        = var.instance_sizes.size.master.pi_memory,
        pi_processors    = var.instance_sizes.size.master.pi_processors,
        pi_proc_type     = var.instance_sizes.size.master.pi_proc_type,
        pi_sys_type      = var.instance_sizes.size.master.pi_sys_type,
        pi_pin_policy    = var.instance_sizes.size.master.pi_pin_policy,
        pi_health_status = var.instance_sizes.size.master.pi_health_status,
        ip_address       = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 6),
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
        ip_address       = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 7),
        pi_user_data     = base64encode(file("${path.module}/../../worker.ign")),
      }
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
        ip_address       = cidrhost(var.region_entries.zone2.pvs_dc_cidr, 5),
        pi_image_id      = "1fa28b82-16c8-4fa2-8f25-986d50ca2f36",
      }
    }
  }
  pvs_zone3 = {
    network_cidr = var.region_entries.zone3.pvs_dc_cidr
    network_addr = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 0)
    network_mask = cidrnetmask(var.region_entries.zone1.pvs_dc_cidr)
    network_gw   = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 1)
    net_start_ip = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 5)
    net_end_ip   = cidrhost(var.region_entries.zone3.pvs_dc_cidr, -2)
  }
  ocp_instances_zone3 = {
    ocp_instances = {
      master = {
        pi_instance_name = "master3",
        pi_memory        = var.instance_sizes.size.master.pi_memory,
        pi_processors    = var.instance_sizes.size.master.pi_processors,
        pi_proc_type     = var.instance_sizes.size.master.pi_proc_type,
        pi_sys_type      = var.instance_sizes.size.master.pi_sys_type,
        pi_pin_policy    = var.instance_sizes.size.master.pi_pin_policy,
        pi_health_status = var.instance_sizes.size.master.pi_health_status,
        ip_address       = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 6),
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
        ip_address       = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 7),
        pi_user_data     = base64encode(file("${path.module}/../../worker.ign")),
      }
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
        ip_address       = cidrhost(var.region_entries.zone3.pvs_dc_cidr, 5),
        pi_image_id      = "1fa28b82-16c8-4fa2-8f25-986d50ca2f36",
      }
    }
  }
}


data "template_file" "vpc_infra_init_config" {
  template = <<-EOF
#cloud-config
write_files:
  - path: /etc/chrony.conf
    content: |
      server 0.centos.pool.ntp.org.iburst
      server 1.centos.pool.ntp.org.iburst
      server 2.centos.pool.ntp.org.iburst
      server 3.centos.pool.ntp.org.iburst
      driftfile /var/lib/chrony/drift
      makestep 1.0 3
      rtcsync
      allow ${var.region_entries.zone1.pvs_dc_cidr}
      allow ${var.region_entries.zone2.pvs_dc_cidr}
      allow ${var.region_entries.zone3.pvs_dc_cidr}
      bindcmdaddress 0.0.0.0
      logdir /var/log/chrony
  -path: /etc/squid/squid.conf
    acl localnet src 10.0.0.0/8	# RFC1918 possible internal network
    acl localnet src 172.16.0.0/12	# RFC1918 possible internal network
    acl localnet src 192.168.0.0/16	# RFC1918 possible internal network
    acl localnet src fc00::/7       # RFC 4193 local private network range
    acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines
    acl SSL_ports port 443
    acl SSL_ports port 6443
    acl Safe_ports port 80		# http
    acl Safe_ports port 21		# ftp
    acl Safe_ports port 443		# https
    acl Safe_ports port 6443	# api
    acl Safe_ports port 70		# gopher
    acl Safe_ports port 210		# wais
    acl Safe_ports port 1025-65535	# unregistered ports
    acl Safe_ports port 280		# http-mgmt
    acl Safe_ports port 488		# gss-http
    acl Safe_ports port 591		# filemaker
    acl Safe_ports port 777		# multiling http
    acl CONNECT method CONNECT
    http_access deny !Safe_ports
    http_access deny CONNECT !SSL_ports
    http_access allow localhost manager
    http_access deny manager
    http_access allow localnet
    http_access allow localhost
    http_access deny all
    http_port 3128
    coredump_dir /var/spool/squid
    refresh_pattern ^ftp:		1440	20%	10080
    refresh_pattern ^gopher:	1440	0%	1440
    refresh_pattern -i (/cgi-bin/|\?) 0	0%	0
    refresh_pattern .		0	20%	4320
packages:
  - dnsmasq
  - squid
  - chrony
  - firewall-cmd --permanent --add-port=3128/tcp
  - firewall-cmd --permanent --add-port=53/tcp
  - firewall-cmd --permanent --add-port=53/udp
  - firewall-cmd --reload
runcmd:
  - [ systemctl, enable, squid.service ]
  - [ systemctl, start, squid.service ]
  - [ systemctl, enable, dnsmasq.service ]
  - [ systemctl, start, dnsmasq.service ]
  - [ systemctl, enable, chronyd.service ]
  - [ systemctl, start, chronyd.service ]
EOF
}