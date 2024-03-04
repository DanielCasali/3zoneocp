provider ibm {
  region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider daniel {
  region = var.provider_region

  ibmcloud_api_key = var.ibmcloud_api_key
}