# change me!
variable "prefix" {
  # default = "wangwei"
  # default = "keystone"
  default = "canzhi"
}

# if free cert reach limit, change me!
# devopscamp.us （20230905提供）
# gkdevopscamp.uk  （20230906提供）
# gkdevopscamp2.com
# devopscamp.uk
# devopscamp.us
# devopscamp.work
# gkdevopscamp.com
# gkdevopscamp.uk
variable "domain" {
  # default = "devopscamp.us"
  # default = "gkdevopscamp.uk"
  default = "gkdevopscamp.com"
}

# change me!
variable "secret_id" {
  default = "Your Access ID"
}

# change me!
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

variable "cluster_name" {
  type = string
  description = "cluster's name"
  default = "Harbor"
}