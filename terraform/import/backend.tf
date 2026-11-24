terraform {
  backend "oss" {
    bucket   = "zjy-tfstate-bj"
    prefix   = "import"
    key      = "terraform.tfstate"
    region   = "cn-beijing"
    endpoint = "oss-cn-beijing-internal.aliyuncs.com"
    encrypt  = true
  }
}
