resource "template_file" "user_data_web" {
  template = "${file("vol2_web_userdata.tpl")}"
  vars {
    rds_password = "${random_id.rds_password.b64}"
    rds_endpoint = "${aws_db_instance.wordpress-rds-instance.address}"
  }
}

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
  subnet_id = "${element(aws_subnet.public.*.id, count.index % var.public_subnet_length)}"
  user_data = "${template_file.user_data_web.rendered}"
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