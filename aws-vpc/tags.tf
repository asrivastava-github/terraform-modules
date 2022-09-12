module "tags" {
  source = "../aws-tags"
  name   = "VPC Tags"
  tags   = var.tags_override
}