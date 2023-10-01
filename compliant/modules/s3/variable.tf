

variable "bucket_name" {
  type = string
}


variable "policy" {
  type = any
}

variable "public_access_blocks" {
  type = any

  default = {
    public_access_blocks = {
      block_public_acls       = false
      block_public_policy     = false
      ignore_public_acls      = false
      restrict_public_buckets = false
    }
  }

}
