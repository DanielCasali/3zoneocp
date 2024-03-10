resource "ibm_is_security_group_rule" "out" {
  group     = var.security_group_id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_security_group_rule" "ping" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {
    code = 8
  }
}

resource "ibm_is_security_group_rule" "ssh" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}


resource "ibm_is_security_group_rule" "ssh_lb" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22222
    port_max = 22223
  }
}

resource "ibm_is_security_group_rule" "http" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_security_group_rule" "https" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 443
    port_max = 443
  }
}

resource "ibm_is_security_group_rule" "api" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 6443
    port_max = 6443
  }
}

resource "ibm_is_security_group_rule" "pvs_zone1_cidr" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = var.pvs_zone1_cidr
}

resource "ibm_is_security_group_rule" "pvs_zone2_cidr" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = var.pvs_zone2_cidr
}

resource "ibm_is_security_group_rule" "pvs_zone3_cidr" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = var.pvs_zone3_cidr
}

resource "ibm_is_security_group_rule" "vpc_zone1_cidr" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = var.vpc_zone1_cidr
}

resource "ibm_is_security_group_rule" "vpc_zone2_cidr" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = var.vpc_zone2_cidr
}

resource "ibm_is_security_group_rule" "vpc_zone3_cidr" {
  group     = var.security_group_id
  direction = "inbound"
  remote    = var.vpc_zone3_cidr
}



variable "pvs_zone1_cidr" {}
variable "pvs_zone2_cidr" {}
variable "pvs_zone3_cidr" {}
variable "vpc_zone1_cidr" {}
variable "vpc_zone2_cidr" {}
variable "vpc_zone3_cidr" {}
variable "security_group_id" {}
variable "ibmcloud_api_key" {}