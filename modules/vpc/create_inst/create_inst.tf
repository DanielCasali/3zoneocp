resource "ibm_is_instance" "instance
" {
  name    = var.instance_name
  image   = var.image_id
  profile = "cx2-2x4"
  primary_network_interface {
    name   = "eth0"
    subnet = var.subnet_id
    allow_ip_spoofing = false
  }
  vpc  = var.vpc_id
  zone = var.zone_name
  keys = [var.ssh_key_id]

  //User can configure timeouts
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

variable "subnet_id" {}
variable "image_id" {}
variable "instance_name" {}
variable "ssh_key_id" {}
variable "zone_name" {}
variable "vpc_id" {}
variable "ibmcloud_api_key" {}

