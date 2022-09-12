resource "aws_vpc" "demo" {
  cidr_block           = var.vpc_cidr_block
  tags = {
    Name = "${var.project}"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.demo.id
  tags = {
    Name = "${var.project}-private"
  }
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.demo.default_route_table_id
  tags = {
    Name = "${var.project}-default"
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
    Name = "${var.project}-private-${index(var.private_subnets, each.value)}"
  }
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
  tags = {
    Name = "${var.project}-s3-endpoint"
  }
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
  tags = {
    Name = "${var.project}-dynamodb-endpoint"
  }
}

data "aws_subnet" "demo" {
  for_each = local.private_subnet_map
  id       = aws_subnet.private[each.key].id
}

resource "aws_vpc_endpoint_route_table_association" "private_dynamodb" {
  count = var.enable_dynamodb_vpc_endpoint ? 1 : 0

  vpc_endpoint_id = aws_vpc_endpoint.dynamodb[0].id
  route_table_id  = aws_route_table.private_route_table.id
}
