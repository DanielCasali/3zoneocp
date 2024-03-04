terraform {
  required_providers {
    region = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.61.0"
    }
    powervs1 = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.61.0"
    }
    powervs2 = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.61.0"
    }
    powervs3 = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.61.0"
    }
  }

  required_version = ">= 1.2.9"
}