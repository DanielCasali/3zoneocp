output "lb-int-hostname" {
  value = ibm_is_lb.lb_int.hostname
}

output "lb-int-id" {
  value = ibm_is_lb.lb_int.id
}

output "lb-int-pool-id" {
  value = element(split("/", ibm_is_lb_pool.proxy.id), 1)
}
