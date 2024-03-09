resource "ibm_is_vpc" "example_vpc" {
  name           = "ocp"
  resource_group = data.ibm_resource_group.default.id
}

variable "ocp_instance_mac" {}
variable "ibmcloud_api_key" {}
variable "this_workspace_id" {}