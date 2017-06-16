variable "name" {
  default  = "hands-on-vpc"
}

variable "cidr" {
  default  = "10.0.0.0/16"
}

variable "subnet_length" {
  default = "2"
}

variable "vpc_cidr_16" {
  default = "10.0"
}

variable "az_list" {
    default = "ap-northeast-1a,ap-northeast-1c"
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = []
}

variable "web_settings" {
  type = "map"
  default = {
    ec2_count = "2"
    ec2_type = "t2.micro"
    ami_id = "ami-e9dbd98e"
  }
}

variable "key_pair" {
  default = "jenelab-hands-on"
}