provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"
}

#CREATE S3BUCKET
resource "aws_s3_bucket" "jaga-prod-blisslogs" {
  bucket = var.prod-blisslogs-bucket-name
  versioning {
    enabled = true
  }
  tags = {
    Name        = "env"
    value = "prod"
  }
}

#resource "aws_s3_bucket_acl" "jaga-prod.blisslogs-acl" {
#  bucket = aws_s3_bucket.b.id
#  acl    = "private"
#}

resource "aws_s3_bucket_acl" "jaga-prod-blisslogs-log_bucket_acl" {
  bucket = aws_s3_bucket.jaga-prod-blisslogs.id
  acl    = "log-delivery-write"
}

#SERVERSIDE ENCRYPTION
resource "aws_s3_bucket_server_side_encryption_configuration" "jaga-prod-blisslogs-server-side-encryption" {
  bucket = aws_s3_bucket.jaga-prod-blisslogs.bucket

  rule {
    apply_server_side_encryption_by_default {
#      kms_master_key_id = aws_kms_key.mykey.arn
     sse_algorithm     = "AES256"
    }
  }
}

#CREATE S3BUCKET c5-bliss-trail-n-virginia
resource "aws_s3_bucket" "jaga-c5-bliss-trail-n-virginia" {
  bucket = var.c5-bliss-trail-n-virginia
#DISSABLE BUCKET VERSIONING SO made ENABLED equal to FALSE
  versioning {
    enabled = false
  }
#  tags = {
#    name        = "Name"
#    value = "user-ssh-login-details"
#  }
}

#resource "aws_s3_bucket_acl" "jaga-prod.blisslogs-acl" {
#  bucket = aws_s3_bucket.b.id
#  acl    = "private"
#}

#S3 log delivery group -> Objects(Write), Bucket ACL (Read)
#resource "aws_s3_bucket_acl" "jaga-ssh-recodringlogs-log_bucket_acl" {
#  bucket = aws_s3_bucket.jaga-ssh-recodringlogs.id
#  acl    = "log-delivery-write"
#}

#SERVERSIDE ENCRYPTION DISABLED SO COMMENTED
#resource "aws_s3_bucket_server_side_encryption_configuration" "jaga-ssh-recodringlogs-server-side-encryption" {
#  bucket = aws_s3_bucket.jaga-ssh-recodringlogs.bucket

#  rule {
#    apply_server_side_encryption_by_default {
#      kms_master_key_id = aws_kms_key.mykey.arn
#     sse_algorithm     = "AES256"
#    }
#  }
#}

resource "aws_s3_bucket_logging" "jaga-c5-bliss-trail-n-virginia_bucket_logging" {
  bucket = aws_s3_bucket.jaga-c5-bliss-trail-n-virginia.id

  target_bucket = aws_s3_bucket.jaga-c5-bliss-trail-n-virginia.id
  target_prefix = "log/"
}


#CREATE S3BUCKET ssh-recodringlogs
resource "aws_s3_bucket" "jaga-ssh-recodringlogs" {
  bucket = var.ssh-recodringlogs-bucket-name
#DISSABLE BUCKET VERSIONING SO made ENABLED equal to FALSE
  versioning {
    enabled = false
  }
  tags = {
    name        = "Name"
    value = "user-ssh-login-details"
  }
}

#resource "aws_s3_bucket_acl" "jaga-prod.blisslogs-acl" {
#  bucket = aws_s3_bucket.b.id
#  acl    = "private"
#}

#S3 log delivery group -> Objects(Write), Bucket ACL (Read)
#resource "aws_s3_bucket_acl" "jaga-ssh-recodringlogs-log_bucket_acl" {
#  bucket = aws_s3_bucket.jaga-ssh-recodringlogs.id
#  acl    = "log-delivery-write"
#}

#SERVERSIDE ENCRYPTION
resource "aws_s3_bucket_server_side_encryption_configuration" "jaga-ssh-recodringlogs-server-side-encryption" {
  bucket = aws_s3_bucket.jaga-ssh-recodringlogs.bucket

  rule {
    apply_server_side_encryption_by_default {
#      kms_master_key_id = aws_kms_key.mykey.arn
     sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_logging" "jaga-ssh-recodringlogs_bucket_logging" {
  bucket = aws_s3_bucket.jaga-ssh-recodringlogs.id

  target_bucket = aws_s3_bucket.jaga-c5-bliss-trail-n-virginia.id
  target_prefix = "s3_servers_accesslog/"
}

resource "aws_s3_bucket_public_access_block" "jaga-ssh-recodringlogs_public_access_block" {
  bucket = aws_s3_bucket.jaga-ssh-recodringlogs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
