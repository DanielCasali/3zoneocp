resource "ibm_pi_instance_action" "reboot_worker" {
  for_each = {
    for key, value in var.ocp_instance_mac.instance_list : key => value
    if startswith(key, "worker")
  }
  pi_cloud_instance_id = var.this_workspace_id
  pi_instance_id       = each.value.instance_id
  pi_action            = "soft-reboot"
  pi_health_status     = "WARNING"
}

variable "ocp_instance_mac" {}
variable "ibmcloud_api_key" {}
variable "this_workspace_id" {
  type = string
}