provider ibm {
  region = var.provider_region
  ibmcloud_api_key = var.ibmcloud_api_key
  ibm_key = var.ibmcloud_api_key
  key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs1"
  region = "us-south"
  zone = "dal10"
  ibmcloud_api_key = var.ibmcloud_api_key
  ibm_key = var.ibmcloud_api_key
  key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs2"
  region = "us-south"
  zone = "dal12"
  ibmcloud_api_key = var.ibmcloud_api_key
  ibm_key = var.ibmcloud_api_key
  key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs3"
  region = "us-south"
  zone = "dal13"
  ibmcloud_api_key = var.ibmcloud_api_key
  ibm_key = var.ibmcloud_api_key
  key = var.ibmcloud_api_key
}