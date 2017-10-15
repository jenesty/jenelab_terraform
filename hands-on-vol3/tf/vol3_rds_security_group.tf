resource "aws_security_group" "rds_security_group" {
  name = "rds security group"
  vpc_id  = "${aws_vpc.hands-on-vpc.id}"
  ingress {
    protocol = "tcp"
    from_port = 3306
    to_port = 3306
    cidr_blocks = ["10.0.0.0/16"]
    # cidr_blocks = [
    #   "${aws_security_group.web_security_group.id}"
    # ]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}