output "vpc_instance1_ip" {
  value = module.create_inst1.ibm_instance_ip
}

output "vpc_instance2_ip" {
  value = module.create_inst2.ibm_instance_ip
}