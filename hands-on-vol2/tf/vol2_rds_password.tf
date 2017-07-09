resource "random_id" "rds_password" {
  byte_length = "${var.password_length * 3 / 4}"
}

output "rds_password" {
  value = "${random_id.rds_password.b64}"
}