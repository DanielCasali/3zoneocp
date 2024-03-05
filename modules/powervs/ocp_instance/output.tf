data "ibm_pi_instances" "ds_instance" {
  pi_cloud_instance_id = var.this_workspace_id
}


output "ocp_instance_mac" {
  value = {
    for instance in data.ibm_pi_instances.ds_instance.pvm_instances : instance.pvm_instance_id => {
      ip_address = instance.networks[0].ip
      mac_address = instance.networks[0].macaddress
    }
  }
}