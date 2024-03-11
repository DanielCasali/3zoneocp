output "vpc_instance1_ip" {
  value = module.create_inst1.ibm_instance_ip
}

output "vpc_instance2_ip" {
  value = module.create_inst2.ibm_instance_ip
}

output "vpc_id" {
  value = module.create_vpc.vpc_id
}

output "vpc_crn" {
  value = module.create_vpc.vpc_crn
}