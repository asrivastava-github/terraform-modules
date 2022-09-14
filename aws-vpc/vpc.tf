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

# Create and attach a NACL to private subnet for traffic control
resource "aws_network_acl" "nacl_private" {
  vpc_id     = aws_vpc.demo.id
  subnet_ids = [for k, v in aws_subnet.private : aws_subnet.private[k].id]
  tags = {
    Name = "${var.project}-private-acl-${var.environment}"
  }
  depends_on = [aws_vpc.demo]
}

# Allow DynamoDB response on ephemeral ports to lambda
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

resource "aws_network_acl_rule" "private_nacl_rules_out" {
  network_acl_id = aws_network_acl.nacl_private.id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 100
  cidr_block     = "0.0.0.0/0"
  to_port        = 443
  from_port      = 443
  egress         = true
  lifecycle {
    create_before_destroy = false
  }
  depends_on = [aws_vpc.demo]
}

# DynamoDB & s3 endpoint and it's route
data "aws_vpc_endpoint_service" "s3" {
  service      = "s3"
  service_type = "Gateway"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.demo.id
  service_name = data.aws_vpc_endpoint_service.s3.service_name
  tags = {
    Name = "${var.project}-s3-endpoint-${var.environment}"
  }
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
  route_table_id  = aws_route_table.private_route_table.id
}

data "aws_vpc_endpoint_service" "dynamodb" {
  service      = "dynamodb"
  service_type = "Gateway"
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = aws_vpc.demo.id
  service_name = data.aws_vpc_endpoint_service.dynamodb.service_name
  tags = {
    Name = "${var.project}-dynamodb-endpoint-${var.environment}"
  }
}

resource "aws_vpc_endpoint_route_table_association" "private_dynamodb" {
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb[0].id
  route_table_id  = aws_route_table.private_route_table.id
}
