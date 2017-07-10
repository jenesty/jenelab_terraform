resource "random_id" "wp_password" {
  byte_length = "${var.password_length * 3 / 4}"
}

output "wp_password" {
  value = "${random_id.wp_password.b64}"
}