resource "ibm_is_vpc" "example_vpc" {
  name           = "ocp"
}

variable "ocp_instance_mac" {}
variable "ibmcloud_api_key" {}
variable "this_workspace_id" {}