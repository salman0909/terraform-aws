resource "aws_s3_bucket" "remotebucket" {
  
  bucket =  "eocbucketstorebackend2024"
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.remotebucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.remotebucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


#create dynamoDB
resource "aws_dynamodb_table" "statelock" {
   name = "state-lock"
   billing_mode = "PAY_PER_REQUEST"
   hash_key = "LockID" 
   attribute {
     name = "LockID"
     type = "S"
   }
}
