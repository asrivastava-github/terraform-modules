/**
 * # Terraform :: Tags - Usage
 *
 * The sample code in this directory shows how to use this module on a simple S3 bucket resource. This is applicable for all resources.
 *
 * Check [main.tf](main.tf) for the code sample. Please note that the source url must be a git url like (git::ssh://git@github.com/asrivastava-github/terraform-modules-tag.git?ref=0.1.0)
 */

module "tags" {
  source             = "../"
  name               = "test-tag-rap-dev"
}

resource "aws_kms_key" "dev-bucket" {
  description         = "test-tag-rap-dev"
  tags                = module.tags-dev.tags
  enable_key_rotation = true
}

###############

module "tags-custom" {
  source             = "../"
  name               = "test-tag-rap-custom"
  environment        = "PreProduction"
  tags = {
    custom_tag = "custom_tag"
  }
}

resource "aws_kms_key" "custom-tagged-bucket" {
  description         = "test-tag-rap-custom-tagged"
  tags                = module.tags-custom.tags
  enable_key_rotation = true
}

###############

resource "aws_kms_key" "custom-tagged-inline-bucket" {
  description         = "test-tag-rap-custom-tagged-inline"
  tags                = merge(module.tags-custom.tags, { another_tag = "some_other_tag" })
  enable_key_rotation = true
}
###################

module "tags-s3-obj" {
  source  = "../"
  name    = "s3-object-tagging"
}

resource "aws_s3_bucket" "custom-tagged-bucket" {
  tags   = module.tags-s3.tags
  bucket = "example-s3-bucket"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_object" "custom-tagged-bucket-object" {
  bucket                 = aws_s3_bucket.custom-tagged-bucket.id
  key                    = "testfile.txt"
  server_side_encryption = "aws:kms"
  tags                   = module.tags-s3-obj.s3objtags
}