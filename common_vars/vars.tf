# キーペア名をdefaultに設定してください。
variable "key_pair" {
  default = "jenelab-hands-on"
}

# bucketにs3バケット名を設定してください。
terraform {
  backend "s3" {
    bucket = "hands-on-terraform-state"
    region = "ap-northeast-1"
    key    = "terraform.tfstate"
    #lock_table = "terraform-state-lock"
  }
}

#
# vpc
#
variable "vpc_settings" {
  type = "map"
  default = {
    enable_dns_hostnames  = true
    enable_dns_support  = true
    cidr = "10.0.0.0/16"
  }
}

#
# subnet
#
variable "public_subnet_length" {
  default = "2"
}

variable "az_list" {
    default = "ap-northeast-1a,ap-northeast-1c"
}

variable "public_subnet_settings" {
  type = "map"
  default = {
    subnet_cidr_16 = "10.0"
    map_public_ip_on_launch = "true"
  }
}

#
# ec2
#
variable "web_settings" {
  type = "map"
  default = {
    ec2_count = "2"
    ec2_type = "t2.micro"
    ami_id = "ami-e9dbd98e"
  }
}


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

#
# S3
#
variable "s3_bucket" {
    default = "jenelab-wordpress"
}

#
# Route 53
#
variable "route53_zone" {
    default = "jenelab-hands-on.com"
}
variable "route53_zoneid" {
    default = "Z3HEA6RWGTOE56"
}

variable "route53_record" {
    default = "www.jenelab-hands-on.com"
}