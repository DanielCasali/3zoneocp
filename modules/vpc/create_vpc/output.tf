output "vpc_id" {
  value = ibm_is_vpc.vpc.id
}

output "subnet1_vpc_id" {
  value = element(split("/", ibm_is_subnet.vpc-zone1-subnet.id), 1)
}

output "subnet2_vpc_id" {
  value = element(split("/", ibm_is_subnet.vpc-zone2-subnet.id), 1)
}

output "subnet3_vpc_id" {
  value = element(split("/", ibm_is_subnet.vpc-zone3-subnet.id), 1)
}

output "ssh_key_id" {
  value = ibm_is_ssh_key.vpc-ssh-key.id
}

output "security_group_id" {
  value = ibm_is_vpc.vpc.security_group.group_id
}