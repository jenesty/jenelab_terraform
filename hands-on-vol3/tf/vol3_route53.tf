# resource "aws_route53_zone" "main" {
#   name = "${var.route53_zone}"
# }

# resource "aws_route53_record" "ns" {
#   zone_id = "${aws_route53_zone.main.zone_id}"
#   name    = "${var.route53_zone}"
#   type    = "NS"
#   ttl     = "30"

#   records = [
#     "${aws_route53_zone.main.name_servers.0}",
#     "${aws_route53_zone.main.name_servers.1}",
#     "${aws_route53_zone.main.name_servers.2}",
#     "${aws_route53_zone.main.name_servers.3}",
#   ]
# }

resource "aws_route53_record" "www" {
  zone_id = "${var.route53_zoneid}"
  name    = "${var.route53_record}"
  type    = "A"
  alias {
    name                   = "${aws_elb.hands-on-elb.dns_name}"
    zone_id                = "${aws_elb.hands-on-elb.zone_id}"
    evaluate_target_health = true
  }
}

output "url" {
    value = "${var.route53_record}"
}