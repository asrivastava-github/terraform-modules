module "tags" {
  source = "../../aws-tags"
  name   = "project-test"
  tags   = local.generic-tags
}

locals {
  generic-tags = {
    "Environment"         = "Demo"
  }
}