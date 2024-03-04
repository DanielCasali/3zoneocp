provider region {
  region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider powervs1 {
  region = "us-south"
  zone = "dal10"
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider powervs2 {
  region = "us-south"
  zone = "dal12"
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider powervs3 {
  region = "us-south"
  zone = "dal13"
  ibmcloud_api_key = var.ibmcloud_api_key
}