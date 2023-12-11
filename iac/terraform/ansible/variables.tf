variable "instance_name" {
  default = "ansible"
}

variable "secret_id" {
  default = "Your Access ID"
}

variable "secret_key" {
  default = "Your Access Key"
}

variable os_name {
 default = "centos"
}

variable "cpu" {
  default = "2"
}

variable "memory" {
  default = "4"
}

variable "region" {
  description = "The location where instacne will be created"
  default     = "ap-hongkong"
}

variable "password" {
  default = "password123"
}

