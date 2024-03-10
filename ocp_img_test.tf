data "http" "bucket_contents" {
  url = "https://s3.us-south.cloud-object-storage.appdomain.cloud/rhcos-powervs-images-us-south/"
}

locals {
  bucket_xml = data.http.bucket_contents.response_body

  rhcos_412_images = [
    for key in distinct(regexall("<Key>(rhcos-412[^<]*)</Key>", local.bucket_xml)) :
    {
      key = key[0]
    }
  ]

  newest_rhcos_412_image = max(local.rhcos_412_images[*].key)
}

output "newest_rhcos_412_image" {
  value = {
    key = local.newest_rhcos_412_image
  }
}