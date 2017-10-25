resource "aws_db_subnet_group" "wordpress2" {
  name       = "wordpress2"
  subnet_ids = ["${aws_subnet.private.0.id}", "${aws_subnet.private.1.id}"]
  tags {
    Name = "wordpress2"
  }
}