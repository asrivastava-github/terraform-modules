locals {
  private_subnet_map = {
    for i, entry in var.private_subnets :
    i => entry
  }
}