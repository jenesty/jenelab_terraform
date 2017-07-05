variable "key_pair" {
  default = "jenelab-hands-on"
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
variable "subnet_length" {
  default = "2"
}

variable "az_list" {
    default = "ap-northeast-1a,ap-northeast-1c"
}

variable "subnet_settings" {
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