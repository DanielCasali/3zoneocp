provider "ibm" {
  alias  = "powervs2"
  region = var.provider_region
  zone   = "dal12"
  ibmcloud_api_key = var.ibmcloud_api_key
}