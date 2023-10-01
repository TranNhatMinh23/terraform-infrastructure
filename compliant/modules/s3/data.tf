

# data "aws_iam_policy_document" "allow_access_from_public" {
#   statement {
#     # sid = "1"
#     principals = ["*"]

#     actions = [
#       "s3:GetObject",
#     ]

#     resources = [
#       aws_s3_bucket.this.arn,
#       "${aws_s3_bucket.this.arn}/*",
#     ]
#   }
# }
