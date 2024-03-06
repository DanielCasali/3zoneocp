data "template_file" "cloud_init_config" {
  template = <<-EOF
#cloud-config
packages:
  - dhcp-server
write_files:
  - path: /etc/dhcp/dhcpd.conf
    content: |
      $${map_lines}

EOF
  vars = {
    map_lines = join("\n", concat(
      ["default-lease-time 900;"],
      ["      max-lease-time 7200; "],
      ["      subnet $$this_network_addr netmask $$this_network_mask {"],
      ["              option routers $$this_network_gw; "],
      ["              option subnet-mask $$this_network_mask; "],
      ["              option domain-search \"$$ocp_cluster_name.$$ocp_cluster_domain\";"],
      ["              option domain-name-servers $; "],
      ["      }"],
      flatten([
        for instance_name, instance in var.ocp_instance_mac.instance_list : [
          "      host ${instance_name} {",
          [for k, v in instance : "      ${k == "mac_address" ? "hardware ethernet" : k == "ip_address" ? "fixed-address" : k } ${v};"],
          ["      }"]
        ]
      ]),
      ["runcmd:"],
      ["  - [ systemctl, enable, dhcpd.service ]"],
      ["  - [ systemctl, start, dhcpd.service ]"]
    ))
  }
}


variable "internal_vpc_dns1" {
  type = string
}
variable "ocp_instance_mac" {
  type = map(any)
}

variable "ibmcloud_api_key" {
  type = string
}

variable "ocp_cluster_name" {
  type = string
}

variable "ocp_cluster_domain" {
  type = string
}

variable "this_network_addr" {
  type = string
}

variable "this_network_mask" {
  type = string
}

variable "this_network_gw" {
  type = string
}