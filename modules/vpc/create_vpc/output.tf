output "vpc_id" {
  value = ibm_is_vpc.vpc.id
}

output "security_group_id" {
  value = ibm_is_vpc.vpc.security_group.group_id
}