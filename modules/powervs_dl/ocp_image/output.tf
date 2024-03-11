output "this_ocp_image_id" {
  value = element(split("/", ibm_pi_image.openshift.id), 1)
}