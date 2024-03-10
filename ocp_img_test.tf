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

  sorted_rhcos_412_images = sort(local.rhcos_412_images[*].key)
  newest_rhcos_412_image = local.sorted_rhcos_412_images[length(local.sorted_rhcos_412_images) - 1]
}

output "newest_rhcos_412_image" {
  value = {
    key = local.newest_rhcos_412_image
  }
}