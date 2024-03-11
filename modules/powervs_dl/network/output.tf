output "this_network_id" {
  value = element(split("/", ibm_pi_network.power_networks.id), 1)
}