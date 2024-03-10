module "create_vpc" {
  source          = "./create_vpc"
  ibm_resource_group_id = var.ibm_resource_group_id
  ibmcloud_api_key = var.ibmcloud_api_key
  vpc_name = var.vpc_name
  vpc_zone1_cidr = var.vpc_zone1_cidr
  vpc_zone2_cidr = var.vpc_zone2_cidr
  vpc_zone3_cidr = var.vpc_zone3_cidr
  vpc_zone_1 = var.vpc_zone_1
  vpc_zone_2 = var.vpc_zone_2
  vpc_zone_3 = var.vpc_zone_3
  pi_ssh_key = var.pi_ssh_key

}

module "sec_roles" {
  depends_on = [module.create_vpc]
  source          = "./sec_roles"
  ibm_resource_group_id = var.ibm_resource_group_id
  ibmcloud_api_key = var.ibmcloud_api_key
  security_group_id = module.create_vpc.security_group_id
  pvs_zone1_cidr = var.pvs_zone1_cidr
  pvs_zone2_cidr = var.pvs_zone2_cidr
  pvs_zone3_cidr = var.pvs_zone3_cidr
  vpc_zone1_cidr = var.vpc_zone1_cidr
  vpc_zone2_cidr = var.vpc_zone2_cidr
  vpc_zone3_cidr = var.vpc_zone3_cidr

}

module "create_inst1" {
  depends_on = [module.create_vpc, module.sec_roles]
  source     = "./create_inst"
  ibmcloud_api_key = ""
  instance_name = "infra1"
  ssh_key_id = module.create_vpc.ssh_key_id
  vpc_id = module.create_vpc.vpc_id
  user_data =  base64encode(data.template_file.vpc_infra_init_config.rendered)
  zone_name = var.vpc_zone_1
  image_id = local.centos_image_id
  subnet_id = module.create_vpc.subnet1_vpc_id
}

module "create_inst2" {
  depends_on = [module.create_vpc, module.sec_roles]
  source     = "./create_inst"
  ibmcloud_api_key = ""
  instance_name = "infra2"
  ssh_key_id = module.create_vpc.ssh_key_id
  vpc_id = module.create_vpc.vpc_id
  user_data =  base64encode(data.template_file.vpc_infra_init_config.rendered)
  zone_name = var.vpc_zone_2
  image_id = local.centos_image_id
  subnet_id = module.create_vpc.subnet2_vpc_id
}


module "lb_int" {
  depends_on = [module.create_inst1,module.create_inst2]
  source     = "./lb_int"
  ibmcloud_api_key = var.ibmcloud_api_key
  subnet1_vpc_id = module.create_vpc.subnet1_vpc_id
  subnet2_vpc_id = module.create_vpc.subnet2_vpc_id
  subnet3_vpc_id = module.create_vpc.subnet3_vpc_id
  instance1_id = module.create_inst1.ibm_instance_id
  instance2_id = module.create_inst2.ibm_instance_id
}


module "create_dns"{
  depends_on = [module.lb_int]
  source = "./create_dns"
  ibmcloud_api_key = var.ibmcloud_api_key
  ibm_resource_group_id = var.ibm_resource_group_id
  ocp_cluster_domain = var.ocp_cluster_domain
  ocp_cluster_name = var.ocp_cluster_name
  vpc_crn = module.create_vpc.vpc_crn
  lb-int-hostname = module.lb_int.lb-int-hostname
}


variable "ocp_cluster_name" {}
variable "ocp_cluster_domain" {}
variable "provider_region" {}
variable "vpc_name" {}
variable "ibm_resource_group_id" {}
variable "ibmcloud_api_key" {}
variable "pi_ssh_key" {}
variable "pvs_zone1_cidr" {}
variable "pvs_zone2_cidr" {}
variable "pvs_zone3_cidr" {}
variable "vpc_zone1_cidr" {}
variable "vpc_zone2_cidr" {}
variable "vpc_zone3_cidr" {}
variable "vpc_zone_1" {}
variable "vpc_zone_2" {}
variable "vpc_zone_3" {}


locals {
  centos_image_name = "ibm-centos-stream-9-*"
  centos_image_id = [
    for image in data.ibm_is_images.all_images.images :
    image
    if image.name != null
    && image.status == "available"
    && length(regexall("^${local.centos_image_name}$", image.name)) > 0
  ][0]
}

data "ibm_is_images" "all_images" {
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
      allow ${var.pvs_zone1_cidr}
      allow ${var.pvs_zone2_cidr}
      allow ${var.pvs_zone3_cidr}
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
runcmd:
  - [ systemctl, enable, squid.service ]
  - [ systemctl, start, squid.service ]
  - [ systemctl, enable, dnsmasq.service ]
  - [ systemctl, start, dnsmasq.service ]
  - [ systemctl, enable, chronyd.service ]
  - [ systemctl, start, chronyd.service ]
EOF
}