# Upload files to S3 Bucket 
resource "aws_s3_object" "provision_source_files" {
    bucket  = aws_s3_bucket.eoc_bucket.id
    
    # myapp/ is the Directory contains files to be uploaded to S3
    for_each = fileset("myapp/", "**/*.*")
    key    = each.value
    source = "myapp/${each.value}"
    content_type = each.value
}



resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.eoc_bucket.id
  acl    = "public-read"
}
