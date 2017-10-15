resource "aws_db_parameter_group" "wordpress" {
  name   = "wordpress"
  family = "mariadb10.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}