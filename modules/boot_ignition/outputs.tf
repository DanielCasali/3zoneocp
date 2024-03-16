output "bootstrap_init_file" {
  value = base64encode(data.template_file.bootstrap_init_config.rendered)
}


data "template_file" "bootstrap_init_config" {
  template = <<-EOF
{
  "ignition":{
    "version": "3.2.0",
    "config": {
      "replace": {
        "source": "https://s3.${ibm_cos_bucket.cos_bucket.region_location}.cloud-object-storage.appdomain.cloud/${ibm_cos_bucket.cos_bucket.bucket_name}/${ibm_cos_bucket_object.bootstrap.key}"
      }
    }
  }
}
EOF
}

