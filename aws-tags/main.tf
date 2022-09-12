locals {
  default_tags = {
    "Name" : var.name,
    "Environment" : var.environment,
  }

  s3_obj_tags = {
    "Name" : var.name,
    "Environment" : var.environment,
  }

  merged_tags        = merge(local.default_tags, var.tags)
  merged_s3_obj_tags = merge(local.s3_obj_tags, var.tags)
}