locals {
  private_subnet_count = length(var.private_subnets)

  private_subnet_map = {
    for i, entry in var.private_subnets :
    i => entry
  }

  availability_zone_subnets = {
    for s in data.aws_subnet.this : s.availability_zone => s.id...
  }
}