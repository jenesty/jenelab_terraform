
#
# subnet
#
variable "private_subnet_length" {
  default = "2"
}

variable "private_subnet_settings" {
  type = "map"
  default = {
    subnet_cidr_16 = "10.0"
  }
}

#
# RDS
#
variable "rds_settings" {
  type = "map"
  default = {
    instance_class = "db.t2.micro"
    database_name = "wordpress"
    db_username = "wordpress"
  }
}

#
# Password
#
variable "password_length" {
  default = "10"
}