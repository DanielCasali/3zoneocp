output "dhcp_file" {
  value = base64encode(data.template_file.cloud_init_config.rendered)
}
