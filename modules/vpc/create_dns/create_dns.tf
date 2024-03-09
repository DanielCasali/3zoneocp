resource "ibm_resource_instance" "ocp-dns-instance" {
  name           =  "ocp-dns-instance"
  resource_group_id  =  var.ibm_resource_group_id
  location           =  "global"
  service        =  "dns-svcs"
  plan           =  "standard-dns"
}

resource "ibm_dns_zone" "ocp-dns-zone" {
  depends_on = [ibm_resource_instance.ocp-dns-instance]
  name = "${var.ocp_cluster_name}.${var.ocp_cluster_domain}"
  instance_id = ibm_resource_instance.ocp-dns-instance.guid
  description = "This is the OCP DNS Zone"
}

resource "ibm_dns_permitted_network" "ocp-dns-permitted-network" {
  depends_on = [ibm_dns_zone.ocp-dns-zone]
  instance_id = ibm_resource_instance.ocp-dns-instance.guid
  zone_id     = ibm_dns_zone.ocp-dns-zone.zone_id
  vpc_crn     = var.vpc_crn
}

resource "ibm_dns_resource_record" "ocp-proxy-cname" {
  instance_id = ibm_resource_instance.ocp-dns-instance.guid
  zone_id     = ibm_dns_zone.ocp-dns-zone.zone_id
  type        = "CNAME"
  name        = "proxy"
  rdata       = var.lb-int-hostname
}

resource "ibm_dns_resource_record" "ocp-apps-cname" {
  instance_id = ibm_resource_instance.ocp-dns-instance.guid
  zone_id     = ibm_dns_zone.ocp-dns-zone.zone_id
  type        = "CNAME"
  name        = "*.apps"
  rdata       = var.lb-int-hostname
}

resource "ibm_dns_resource_record" "ocp-api-int-cname" {
  instance_id = ibm_resource_instance.ocp-dns-instance.guid
  zone_id     = ibm_dns_zone.ocp-dns-zone.zone_id
  type        = "CNAME"
  name        = "api-int"
  rdata       = var.lb-int-hostname
}


resource "ibm_dns_resource_record" "ocp-api-cname" {
  instance_id = ibm_resource_instance.ocp-dns-instance.guid
  zone_id     = ibm_dns_zone.ocp-dns-zone.zone_id
  type        = "CNAME"
  name        = "api"
  rdata       = var.lb-int-hostname
}


resource "ibm_dns_resource_record" "test-pdns-resource-record-a" {
  instance_id = ibm_resource_instance.ocp-dns-instance.guid
  zone_id     = ibm_dns_zone.ocp-dns-zone.zone_id
  type        = "A"
  name        = "testa"
  rdata       = "1.2.3.4"
  ttl         = 3600
}

resource "ibm_dns_resource_record" "test-pdns-resource-record-ptr" {
  instance_id = ibm_resource_instance.ocp-dns-instance.guid
  zone_id     = ibm_dns_zone.ocp-dns-zone.zone_id
  type        = "PTR"
  name        = "1.2.3.4"
  rdata       = "testa.${var.ocp_cluster_name}.${var.ocp_cluster_domain}"
}



variable "lb-int-hostname" {}
variable "vpc_crn" {}
variable "ocp_cluster_name" {}
variable "ocp_cluster_domain" {}
variable "ibmcloud_api_key" {}
variable "ibm_resource_group_id" {}
