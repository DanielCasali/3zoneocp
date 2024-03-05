resource "ibm_pi_instance_action" "example" {
  for_each = var.ocp_instance_mac
  pi_cloud_instance_id  = "d7bec597-4726-451f-8a63-e62e6f19c32c"
  pi_instance_id        = "cea6651a-bc0a-4438-9f8a-a0770b112ebb"
  pi_action             = "hard-reboot"
}

variable "ocp_instance_mac" {
  type = map(any)
}
variable "ibmcloud_api_key" {}