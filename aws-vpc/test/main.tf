data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  private_subnets = [
    for i, entry in data.aws_availability_zones.available.names :
    cidrsubnet(var.vpc_cidr_block, 8, i)
  ]
}

resource "aws_security_group" "ssm" {
  name        = "ssm"
  description = "Allow SSM traffic"
  vpc_id      = module.vpc.vpc_id
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

  enable_dns_hostnames                = true
  enable_dns_support                  = true
  enable_s3_vpc_endpoint              = true
  enable_dynamodb_vpc_endpoint        = true
  enable_ssm_vpc_endpoint             = true
  enable_ssm_vpc_endpoint_private_dns = true
  ssm_vpc_endpoint_security_group_ids = [aws_security_group.ssm.id]

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