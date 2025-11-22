variable "aws_region" { default = "ap-south-1" }
variable "project"    { default = "3tier-app" }

variable "db_name"     { default = "appdb" }
variable "db_username" { default = "admin" }
variable "db_password" { default = "ChangeThis123!" }
variable "instance_type" { default = "t3.small" }   # for RDS
