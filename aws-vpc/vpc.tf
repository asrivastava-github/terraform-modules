resource "aws_vpc" "demo" {
  cidr_block           = var.vpc_cidr_block
  tags = {
    Name = "${var.project}-${var.environment}"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.demo.id
  tags = {
    Name = "${var.project}-private-${var.environment}"
  }
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.demo.default_route_table_id
  tags = {
    Name = "${var.project}-default-${var.environment}"
  }
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
  tags = {
    Name = "${var.project}-private-${each.key}-${var.environment}"
  }
}

# Create and attach a Network access control list to private subnet for traffic control
resource "aws_network_acl" "nacl_private" {
  vpc_id     = aws_vpc.demo.id
  subnet_ids = [for k, v in aws_subnet.private : aws_subnet.private[k].id]
  tags = {
    Name = "${var.project}-private-acl-${var.environment}"
  }
  depends_on = [aws_vpc.demo]
}

# Provide a way for DynamoDB response to reach to lambda. Access on ephemeral ports
resource "aws_network_acl_rule" "private_nacl_rules_in_dynamoDB_EP" {
  network_acl_id = aws_network_acl.nacl_private.id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 100
  cidr_block     = "0.0.0.0/0"
  to_port        = 65535
  from_port      = 1024
  lifecycle {
    create_before_destroy = false
  }
  depends_on = [aws_vpc.demo]
}

data "aws_vpc_endpoint_service" "s3" {
  count = local.one_time

  service      = "s3"
  service_type = "Gateway"
}

resource "aws_vpc_endpoint" "s3" {
  count = local.one_time

  vpc_id       = aws_vpc.demo.id
  service_name = data.aws_vpc_endpoint_service.s3[0].service_name
  tags = {
    Name = "${var.project}-s3-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  count = local.one_time

  vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
  route_table_id  = aws_route_table.private_route_table.id
}

data "aws_vpc_endpoint_service" "dynamodb" {
  count = local.one_time

  service = "dynamodb"
}

resource "aws_vpc_endpoint" "dynamodb" {
  count = local.one_time

  vpc_id       = aws_vpc.demo.id
  service_name = data.aws_vpc_endpoint_service.dynamodb[0].service_name
  tags = {
    Name = "${var.project}-dynamodb-endpoint"
  }
}

data "aws_subnet" "demo" {
  for_each = local.private_subnet_map
  id       = aws_subnet.private[each.key].id
}

resource "aws_vpc_endpoint_route_table_association" "private_dynamodb" {
  count = local.one_time

  vpc_endpoint_id = aws_vpc_endpoint.dynamodb[0].id
  route_table_id  = aws_route_table.private_route_table.id
}
