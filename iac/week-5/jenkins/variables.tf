# change me!
variable "prefix" {
  # default = "wangwei"
  # default = "keystone"
  default = "canzhi"
}

# if free ssl cert reach limit, change me!
variable "domain" {
  # default = "devopscamp.us"
  # default = "gkdevopscamp.uk"
  default = "gkdevopscamp.com"
}

# change me!
# Prefer: define environment variable
variable "github_username" {
  # default = "lyzhang1999"
  default = "gitkeystone"
}

# change me!
# Prefer: define environment variable
variable "github_personal_token" {
  default = ""
}

# change me!
# tencent cloud secret id
# Prefer: define environment variable
variable "secret_id" {
  default = "Your Access ID"
}

# change me!
# tencent cloud secret key
# Prefer: define environment variable
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

variable "harbor_password" {
  default = "Harbor12345"
}

variable "cluster_name" {
  type = string
  description = "(optional) describe your variable"
  default = "Jenkins"
}