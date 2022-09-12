resource "aws_vpc" "demo" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = module.tags.tags
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.demo.id
  tags   = module.tags.tags
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.demo.default_route_table_id

  tags = module.tags.tags
}

resource "aws_route_table_association" "private_route_table_association" {
  for_each = local.private_subnet_map

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_subnet" "private" {
  for_each = local.private_subnet_map

  vpc_id            = aws_vpc.demo.id
  cidr_block        = var.private_subnets[each.key]
  availability_zone = element(var.azs, each.key)
  tags              = module.tags.tags
}

data "aws_vpc_endpoint_service" "s3" {
  count = var.enable_s3_vpc_endpoint ? 1 : 0

  service      = "s3"
  service_type = "Gateway"
}

resource "aws_vpc_endpoint" "s3" {
  count = var.enable_s3_vpc_endpoint ? 1 : 0

  vpc_id       = aws_vpc.demo.id
  service_name = data.aws_vpc_endpoint_service.s3[0].service_name
  tags         = module.tags.tags
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  count = var.enable_s3_vpc_endpoint ? 1 : 0

  vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
  route_table_id  = aws_route_table.private_route_table.id
}

data "aws_vpc_endpoint_service" "dynamodb" {
  count = var.enable_dynamodb_vpc_endpoint ? 1 : 0

  service = "dynamodb"
}

resource "aws_vpc_endpoint" "dynamodb" {
  count = var.enable_dynamodb_vpc_endpoint ? 1 : 0

  vpc_id       = aws_vpc.demo.id
  service_name = data.aws_vpc_endpoint_service.dynamodb[0].service_name
  tags         = module.tags.tags
}

data "aws_vpc_endpoint_service" "ssm" {
  count = var.enable_ssm_vpc_endpoint ? 1 : 0

  service = "ssm"
}

data "aws_subnet" "demo" {
  for_each = local.private_subnet_map
  id       = aws_subnet.private[each.key].id
}

resource "aws_vpc_endpoint" "ssm" {
  count = var.enable_ssm_vpc_endpoint ? 1 : 0

  vpc_id              = aws_vpc.demo.id
  service_name        = data.aws_vpc_endpoint_service.ssm[0].service_name
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = var.enable_ssm_vpc_endpoint_private_dns
  security_group_ids  = var.ssm_vpc_endpoint_security_group_ids
  subnet_ids          = [for subnet_ids in local.availability_zone_subnets : subnet_ids[0]]
  tags                = module.tags.tags
}

resource "aws_vpc_endpoint_route_table_association" "private_dynamodb" {
  count = var.enable_dynamodb_vpc_endpoint ? 1 : 0

  vpc_endpoint_id = aws_vpc_endpoint.dynamodb[0].id
  route_table_id  = aws_route_table.private_route_table.id
}

# resource "aws_network_acl" "private" {
#   count      = var.disable_serverless_nacl ? 0 : 1
#   vpc_id     = aws_vpc.demo.id
#   subnet_ids = values(aws_subnet.private)[*].id

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 90
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 443
#     to_port    = 443
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 1024
#     to_port    = 65535
#   }

#   egress {
#     protocol   = "-1"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   tags = module.tags.tags
# }