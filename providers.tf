provider "ibm" {
  region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}


provider "ibm" {
  alias  = "powervs1"
  region = var.provider_region
  zone   = "dal10"
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider "ibm" {
  alias  = "powervs2"
  region = var.provider_region
  zone   = "dal12"
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider "ibm" {
  alias  = "powervs3-dl"
  region = var.provider_region
  zone   = "us-south"
  ibmcloud_api_key = var.ibmcloud_api_key
}