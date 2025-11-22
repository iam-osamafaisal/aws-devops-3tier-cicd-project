terraform {
  backend "s3" {
    bucket         = "terraform-state-osama-3tier"   # <-- apna bucket name daalo
    key            = "3tier-app/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"          # <-- apna lock table name
    encrypt        = true
  }
}
