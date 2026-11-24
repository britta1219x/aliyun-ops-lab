# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "sg-2zebk6b96at2uglkw2hn"
resource "alicloud_security_group" "web" {
  description         = "System created security group."
  inner_access_policy = "Accept"
  security_group_name = "sg-2zebk6b96at2uglkw2hn"
  security_group_type = "normal"
  tags                = {}
  vpc_id              = "vpc-2zeqlfaqj150thy73403o"

  lifecycle {
    prevent_destroy = true
  }
}
