# change me!
variable "prefix" {
  # default = "wangwei"
  default = "keystone"
}

# if free cert reach limit, change me!
variable "domain" {
  default = "devopscamp.us"
  # default = "upcloud.com"
}

variable "secret_id" {
  default = "Your Access ID"
}

variable "secret_key" {
  default = "Your Access Key"
}

variable "region" {
  description = "The location where instacne will be created"
  default     = "ap-hongkong"
}

variable "password" {
  default = "password123"
}

