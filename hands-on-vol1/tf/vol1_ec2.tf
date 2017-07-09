resource "aws_instance" "Web" {
  depends_on = [
    "aws_vpc.hands-on-vpc"
  ]
  count = "${lookup(var.web_settings, "ec2_count")}"
  ami = "${lookup(var.web_settings, "ami_id")}"
  instance_type = "${lookup(var.web_settings, "ec2_type")}"
  vpc_security_group_ids = [
    "${aws_security_group.Web-SG.id}"
  ]
  key_name = "${var.key_pair}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index % var.private_subnet_length)}"
  user_data = "${file("vol1_web_userdata.sh")}"
  tags {
    Role = "Web"
    Env = "Development"
    Name = "Web Server"
  }
}

resource "aws_eip" "Web" {
    count = "${lookup(var.web_settings, "ec2_count")}"
    instance = "${element(aws_instance.Web.*.id, count.index)}"
    vpc = true
}

output "Web.0.ip" {
  value = "${aws_instance.Web.0.public_ip}"
}

output "Web.1.ip" {
  value = "${aws_instance.Web.1.public_ip}"
}