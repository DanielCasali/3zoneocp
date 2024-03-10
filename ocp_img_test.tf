data "http" "bucket_contents" {
  url = "https://s3.us-south.cloud-object-storage.appdomain.cloud/rhcos-powervs-images-us-south/"
}

locals {
  bucket_xml = xml(data.http.bucket_contents.body)

  rhcos_412_images = [
    for content in local.bucket_xml.ListBucketResult.Contents :
    {
      key           = content.Key
      last_modified = content.LastModified
    }
    if length(regexall("rhcos-412", content.Key)) > 0
  ]

  newest_rhcos_412_image = max(local.rhcos_412_images[*].last_modified)
}

output "newest_rhcos_412_image" {
  value = {
    key           = [for image in local.rhcos_412_images : image.key if image.last_modified == local.newest_rhcos_412_image][0]
    last_modified = local.newest_rhcos_412_image
  }
}