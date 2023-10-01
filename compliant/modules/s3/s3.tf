resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = true

 
}
resource "aws_s3_bucket_policy" "allow_access_from_public" {
  bucket = aws_s3_bucket.this.id
  policy = jsonencode(var.policy)
  depends_on = [aws_s3_bucket_public_access_block.this]
}

resource "aws_s3_bucket_ownership_controls" "this" {
  depends_on = [
    aws_s3_bucket_public_access_block.this,
  ]

  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  for_each                = var.public_access_blocks
  block_public_acls       = each.value.block_public_acls
  block_public_policy     = each.value.block_public_policy
  ignore_public_acls      = each.value.ignore_public_acls
  restrict_public_buckets = each.value.restrict_public_buckets
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [
    aws_s3_bucket_ownership_controls.this,
  ]

  bucket = aws_s3_bucket.this.id
  acl    = "public-read"
}
