data "http" "bucket_contents" {
  url = "https://s3.us-south.cloud-object-storage.appdomain.cloud/rhcos-powervs-images-us-south/"
}

locals {
  bucket_xml = data.http.bucket_contents.response_body

  rhcos_412_images = [
    for match in regexall("<Contents>\\s*<Key>(rhcos-412[^<]*)</Key>\\s*<LastModified>([^<]*)</LastModified>", local.bucket_xml) :
    {
      key           = match[1]
      last_modified = match[2]
    }
  ]

  newest_rhcos_412_image = max(local.rhcos_412_images[*].last_modified)
}

output "newest_rhcos_412_image" {
  value = {
    key           = [for image in local.rhcos_412_images : image.key if image.last_modified == local.newest_rhcos_412_image][0]
    last_modified = local.newest_rhcos_412_image
  }
}