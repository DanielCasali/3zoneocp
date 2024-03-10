provider ibm {
  region = var.region_entries.region
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs1"
  region = var.region_entries.region
  zone = var.region_entries.zone1.pvs_dc_name
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs2"
  region = var.region_entries.region
  zone = var.region_entries.zone2.pvs_dc_name
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider ibm {
  alias = "powervs3"
  region = var.region_entries.region
  zone = var.region_entries.zone3.pvs_dc_name
  ibmcloud_api_key = var.ibmcloud_api_key
}