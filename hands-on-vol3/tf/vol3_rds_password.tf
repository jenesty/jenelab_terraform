resource "random_id" "rds_password" {
  byte_length = "${var.password_length * 3 / 4}"
}