provider "ibm" {
  region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}


provider "ibm" {
  alias  = "powervs1"
  region = var.provider_region
  zone   = var.region_zone1
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider "ibm" {
  alias  = "powervs2"
  region = var.provider_region
  zone   = var.region_zone2
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider "ibm" {
  alias  = "powervs3-dl"
  region = var.provider_region
  zone   = var.region_zone3
  ibmcloud_api_key = var.ibmcloud_api_key
}