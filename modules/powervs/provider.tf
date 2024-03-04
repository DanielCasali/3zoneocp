provider "ibm" {
  region = var.provider_region
  zone   = var.this_zone
  ibmcloud_api_key = var.ibmcloud_api_key
}