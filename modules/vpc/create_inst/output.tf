output "ibm_instance_id" {
  value = ibm_is_instance.instance.id
}

output "ibm_instance_ip" {
  value = ibm_is_instance.instance.primary_network_interface.primary_ip.address
}