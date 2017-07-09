terraform {
  backend "s3" {
    bucket = "hands-on-terraform-state"
    region = "ap-northeast-1"
    key    = "terraform.tfstate"
    #lock_table = "terraform-state-lock"
  }
}