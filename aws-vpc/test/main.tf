data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  private_subnets = [
    for i, entry in data.aws_availability_zones.available.names :
    cidrsubnet(var.vpc_cidr_block, 8, i)
  ]
}

resource "aws_security_group_rule" "https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr_block]
  security_group_id = aws_security_group.ssm.id
}

module "vpc" {
  source          = "../"
  azs             = data.aws_availability_zones.available.names
  vpc_cidr_block  = var.vpc_cidr_block
  private_subnets = local.private_subnets
  environment     = "Demo"

  enable_s3_vpc_endpoint              = true
  enable_dynamodb_vpc_endpoint        = true
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_arn" {
  value = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  value = module.vpc.private_subnets
}