provider ibm {
  region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs1"
  region = var.provider_region
  zone = var.zone1
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs2"
  region = var.provider_region
  zone = var.zone2
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs3"
  region = var.provider_region
  zone = var.zone3
  ibmcloud_api_key = var.ibmcloud_api_key
}