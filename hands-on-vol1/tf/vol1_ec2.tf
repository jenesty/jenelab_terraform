resource "template_file" "user_data_web" {
  template = "${file("vol1_web_userdata.tpl")}"
}

resource "aws_instance" "web" {
  depends_on = [
    "aws_vpc.hands-on-vpc"
  ]
  count = "${lookup(var.web_settings, "ec2_count")}"
  ami = "${lookup(var.web_settings, "ami_id")}"
  instance_type = "${lookup(var.web_settings, "ec2_type")}"
  vpc_security_group_ids = [
    "${aws_security_group.web_security_group.id}"
  ]
  key_name = "${var.key_pair}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index % var.public_subnet_length)}"
  user_data = "${template_file.user_data_web.rendered}"
  tags {
    Role = "Web"
    Env = "Development"
    Name = "Webサーバ"
  }
}

resource "aws_eip" "web" {
    count = "${lookup(var.web_settings, "ec2_count")}"
    instance = "${element(aws_instance.web.*.id, count.index)}"
    vpc = true
}