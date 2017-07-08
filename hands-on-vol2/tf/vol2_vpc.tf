resource "aws_subnet" "private" {
  count = "${var.private_subnet_length}"
  vpc_id  = "${aws_vpc.hands-on-vpc.id}"
  cidr_block = "${lookup(var.private_subnet_settings, "subnet_cidr_16")}.${count.index + 100}.0/24"
  availability_zone = "${element(split(",", var.az_list), count.index)}"
  tags {
    Name = "DB Subnet"
  }
}
