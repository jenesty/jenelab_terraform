data "aws_acm_certificate" "acm" {
  domain   = "*.${var.route53_zone}"
  statuses = ["ISSUED"]
}