output workspace_id {
  value = ibm_pi_workspace.powervs_service_instance.id
}

output workspace_crn {
  value = local.workspace_crn
}



data "ibm_pi_workspace" "workspace" {
  pi_cloud_instance_id = ibm_pi_workspace.powervs_service_instance.id
}

locals {
  workspace_crn = data.ibm_pi_workspace.workspace.pi_workspace_details.crn
}