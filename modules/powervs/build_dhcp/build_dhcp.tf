data "template_file" "cloud_init_config" {
  template = <<-EOF
#cloud-config
write_files:
  - path: /etc/dhcp/dhcpd.conf
    content: |
      $${map_lines}
packages:
  - dhcp-server
runcmd:
  - [ systemctl, enable, dhcpd.service ]
  - [ systemctl, start, dhcpd.service ]
EOF
  vars = {
    map_lines = join("\n", concat(
      ["default-lease-time 900;"],
      ["      max-lease-time 7200; "],
      ["      subnet ${var.this_network_addr} netmask ${var.this_network_mask} {"],
      ["              option routers ${var.this_network_gw}; "],
      ["              option subnet-mask ${var.this_network_mask}; "],
      ["              option domain-search \"${var.ocp_cluster_name}.${var.ocp_cluster_domain}\";"],
      ["              option domain-name-servers ${var.internal_vpc_dns1}; "],
      ["      }"],
      flatten([
        for instance_name, instance in var.ocp_instance_mac.instance_list : [
          "      host ${instance_name} {",
          [for k, v in instance : "      ${k == "mac_address" ? "hardware ethernet" : k == "ip_address" ? "fixed-address" : k } ${v};"],
          ["      option host-name \"${instance_name}.${var.ocp_cluster_name}.${var.ocp_cluster_domain}\";"],
          ["      }"]
        ]
      ])
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
