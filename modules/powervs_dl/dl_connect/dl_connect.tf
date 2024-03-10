data "ibm_dl_ports" "ocp_ds_dl_ports" {
  location_name = "${var.this_pvs_dc}"
}

resource "ibm_dl_gateway" "ocp_dl_connect" {
  bgp_asn =  4206000412
  global = true
  metered = true
  name = "${var.this_pvs_dc}-directlinnk"
  speed_mbps = 1000
  type =  "connect"
  connection_mode = "transit"
  port =  data.ibm_dl_ports.ocp_ds_dl_ports.ports[0].port_id
  default_export_route_filter = "permit"
  default_import_route_filter = "permit"
  resource_group = var.ibm_resource_group_id
}


variable "this_pvs_dc" {}
variable "ibm_resource_group_id" {}
variable "ibmcloud_api_key" {}
variable "this_workspace_id" {
  type = string
}