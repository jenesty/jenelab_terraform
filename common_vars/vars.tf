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