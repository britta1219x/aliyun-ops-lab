terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 2.3"
    }
  }
}

provider "alicloud" {} # 从环境变量读 AK 和地域

locals {
  tags = {
    project    = "cloud-practice"
    env        = "lab"
    managed-by = "terraform"
  }
}

data "alicloud_zones" "az" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "lab" {
  vpc_name   = "tf-lab-vpc"
  cidr_block = "10.10.0.0/16"
  tags       = local.tags
}

resource "alicloud_vswitch" "lab" {
  vswitch_name = "tf-lab-vsw-a"
  vpc_id       = alicloud_vpc.lab.id
  cidr_block   = "10.10.1.0/24"
  zone_id      = data.alicloud_zones.az.zones[0].id
  tags         = local.tags
}

resource "alicloud_security_group" "lab" {
  security_group_name = "tf-lab-sg"
  vpc_id              = alicloud_vpc.lab.id
  tags                = local.tags
}

resource "alicloud_security_group_rule" "ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "22/22"
  cidr_ip           = "203.0.113.10/32"
  security_group_id = alicloud_security_group.lab.id
  policy            = "accept"
  priority          = 1
}

output "vpc_id" { value = alicloud_vpc.lab.id }
output "vswitch_id" { value = alicloud_vswitch.lab.id }
output "zone" { value = alicloud_vswitch.lab.zone_id }
