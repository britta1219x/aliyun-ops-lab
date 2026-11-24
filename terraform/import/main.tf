terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 2.3"
    }
  }
}

provider "alicloud" {}

import {
  to = alicloud_security_group.web
  id = "sg-2zebk6b96at2uglkw2hn"
}
