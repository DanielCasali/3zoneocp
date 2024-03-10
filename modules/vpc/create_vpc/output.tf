output "vpc_id" {
  value = ibm_is_vpc.vpc.id
}

output "vpc_crn" {
  value = ibm_is_vpc.vpc.crn
}

output "subnet1_vpc_id" {
  value = element(split("/", ibm_is_subnet.vpc_zone1_subnet.id), 1)
}

output "subnet2_vpc_id" {
  value = element(split("/", ibm_is_subnet.vpc_zone2_subnet.id), 1)
}

output "subnet3_vpc_id" {
  value = element(split("/", ibm_is_subnet.vpc_zone3_subnet.id), 1)
}

output "ssh_key_id" {
  value = ibm_is_ssh_key.vpc-ssh-key.id
}

output "security_group_id" {
  value = ibm_is_vpc.vpc.default_security_group
}