output "bootstrap_init_file" {
  value = base64encode(data.template_file.bootstrap_init_config.rendered)
}


data "template_file" "bootstrap_init_config" {
  template = <<-EOF
{
  "ignition":{
    "version": "3.2.0",
    "config": {
      "proxy" {
        "httpProxy": "http://proxy.${var.ocp_cluster_name}.${var.ocp_cluster_domain}:8080",
        "httpsProxy": "http://proxy.${var.ocp_cluster_name}.${var.ocp_cluster_domain}:8080",
        "noProxy": [ ".apps.${var.ocp_cluster_name}.${var.ocp_cluster_domain}", "api.${var.ocp_cluster_name}.${var.ocp_cluster_domain}", "api-int.${var.ocp_cluster_name}.${var.ocp_cluster_domain}", "${var.zone1_vpc_zone_cidr}", "${var.zone2_vpc_zone_cidr}", "${var.zone3_vpc_zone_cidr}", "${var.zone1_pvs_dc_cidr}", "${var.zone2_pvs_dc_cidr}", "${var.zone3_pvs_dc_cidr}" ]
      },
      "replace": {
        "source": "https://s3.${ibm_cos_bucket.cos_bucket.region_location}.cloud-object-storage.appdomain.cloud/${ibm_cos_bucket.cos_bucket.bucket_name}/${ibm_cos_bucket_object.bootstrap.key}"
      }
    }
  }
}
EOF
}




