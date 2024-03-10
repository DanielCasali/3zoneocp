output workspace_id {
  value = ibm_pi_workspace.powervs_service_instance.id
}

output workspace_crn {
  value = ibm_pi_workspace.powervs_service_instance.workspace_details.crn
}