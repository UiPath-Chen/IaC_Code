terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
      version = "~> 1.0" # v1.81.45
    }
  }
}

provider "tencentcloud" {
    region = "na-siliconvalley"
}

# COS
data "tencentcloud_user_info" "info" {}

locals {
  app_id = data.tencentcloud_user_info.info.app_id
}

resource "tencentcloud_cos_bucket" "terraform-state" {
  bucket               = "terraform-state-${local.app_id}"
  acl                  = "private"
  encryption_algorithm = "AES256"
}
