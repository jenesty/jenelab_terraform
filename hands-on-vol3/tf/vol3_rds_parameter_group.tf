resource "aws_db_parameter_group" "wordpress2" {
  name   = "wordpress2"
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