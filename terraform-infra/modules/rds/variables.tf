variable "vpc_id"        { type = string }
variable "subnet_ids"    { type = list(string) }
variable "username"      { type = string }
variable "db_name"       { type = string }
variable "instance_class" { type = string }
variable "allowed_security_group_ids" {type = list(string)}