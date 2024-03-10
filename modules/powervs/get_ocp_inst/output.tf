
output "ocp_instance_mac" {
  value = local.prod
}


locals {
  prod = {
    instance_list = {
      for instance in data.ibm_pi_instances.ds_instance.pvm_instances : instance.pvm_instance_id => {
        ip_address  = instance.networks[0].ip
        mac_address = instance.networks[0].macaddress
      }
    }
  }
  plan = {
    instance_list = {
      verylongid1 ={
        ip_address  = "192.168.0.1"
        mac_address = "00:11:22:33:44:55"
      }
      verylongid3 ={
        ip_address  = "192.168.0.4"
        mac_address = "00:11:22:33:44:aa"
      }
      verylongid2 ={
        ip_address  = "192.168.0.5"
        mac_address = "00:11:22:33:44:66"
      }
    }
  }
}