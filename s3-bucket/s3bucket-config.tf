resource "aws_s3_bucket" "eoc_bucket" {
  bucket = "eoc-bucket-${random_id.bucket_id.hex}"
}
resource "random_id" "bucket_id" {
  byte_length = 8
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.eoc_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.eoc_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.eoc_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
