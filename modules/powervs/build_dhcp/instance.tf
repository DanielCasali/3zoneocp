
variable "instances" {}

variable "ibmcloud_api_key" {}


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