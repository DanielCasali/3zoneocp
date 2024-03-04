resource "ibm_resource_group" "resourceGroup" {
  name     = "three-site-ocp"
}

variable "provider_region" {}
variable "ibmcloud_api_key" {}