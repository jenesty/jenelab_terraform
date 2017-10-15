# resource "aws_s3_bucket" "hands-on-terraform-stat" {
#   bucket = "hands-on-terraform-state"
#   acl    = "private"

#   versioning {
#     enabled = true
#   }
# }

resource "aws_s3_bucket" "b" {
  bucket = "${var.s3_bucket}"
  acl    = "public-read"
  policy = "${file("policy.json")}"

  website {
    index_document = "index.html"
  }
}