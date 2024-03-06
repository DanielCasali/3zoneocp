
variable "instances" {}

variable "ibmcloud_api_key" {}

data "templatefile" "cloud_init_config" {
  template = <<-EOF
#cloud-config
write_files:
  - path: /path/to/file.txt
    content: |
      $${map_lines}

EOF
  vars = {
    map_lines = yamlencode(
      flatten(
        [
          "this is the beginning",
          [
            for instance_name, instance in var.instances.instance_list : [
            "# ${instance_name}",
            join(
              "\n# This is between key-value pairs of ${instance_name}\n",
              [for k, v in instance : "${k}=${v}"]
            ),
            "something in the end"
          ]
          ]
        ]
      )
    )
  }
}

