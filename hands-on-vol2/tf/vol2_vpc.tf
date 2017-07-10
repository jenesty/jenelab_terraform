resource "aws_vpc" "hands-on-vpc" {
  cidr_block  = "${lookup(var.vpc_settings, "cidr")}"
  enable_dns_hostnames  = "${lookup(var.vpc_settings, "enable_dns_hostnames")}"
  enable_dns_support  = "${lookup(var.vpc_settings, "enable_dns_support")}"
  tags {
    Name = "hands-on-vpc"
  }
}

resource "aws_internet_gateway" "hands-on-vpc" {
  vpc_id = "${aws_vpc.hands-on-vpc.id}"
}

resource "aws_route_table" "public" {
  vpc_id  = "${aws_vpc.hands-on-vpc.id}"
}

resource "aws_route" "public_internet_gateway" {
  route_table_id  = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id  = "${aws_internet_gateway.hands-on-vpc.id}"
}

resource "aws_subnet" "public" {
  count = "${var.private_subnet_length}"
  vpc_id  = "${aws_vpc.hands-on-vpc.id}"
  cidr_block = "${lookup(var.public_subnet_settings, "subnet_cidr_16")}.${count.index + 1}.0/24"
  map_public_ip_on_launch = "${lookup(var.public_subnet_settings, "map_public_ip_on_launch")}"
  availability_zone = "${element(split(",", var.az_list), count.index)}"
  tags {
    Name = "Public Subnet"
  }
}

resource "aws_route_table_association" "public" {
  count = "${var.private_subnet_length}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}


resource "aws_subnet" "private" {
  count = "${var.private_subnet_length}"
  vpc_id  = "${aws_vpc.hands-on-vpc.id}"
  cidr_block = "${lookup(var.private_subnet_settings, "subnet_cidr_16")}.${count.index + 100}.0/24"
  availability_zone = "${element(split(",", var.az_list), count.index)}"
  tags {
    Name = "DB Subnet"
  }
}
