output "vpc_instance1_ip" {
  value = module.create_inst1.ibm_instance_ip
}

output "vpc_instance2_ip" {
  value = module.create_inst2.ibm_instance_ip
}


output "lb-int-id" {
  value = module.lb_int.lb-int-id
}

output "lb-int-pool-id" {
  value = module.lb_int.lb-int-pool-id
}