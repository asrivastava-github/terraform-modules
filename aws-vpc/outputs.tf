output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "The VPC ARN"
  value       = aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "private_subnets" {
  description = "List of private subnets"
  value       = values(aws_subnet.private)[*].id
}

output "private_route_table" {
  description = "ID of the private route table"
  value       = aws_route_table.private_route_table.*.id
}

output "aws_vpc_endpoint_s3" {
  description = "ID of the S3 VPC endpoint"
  value       = aws_vpc_endpoint.s3.*.id
}

output "aws_vpc_endpoint_ssm" {
  description = "ID of the SSM VPC endpoint"
  value       = aws_vpc_endpoint.ssm.*.id
}

output "aws_vpc_endpoint_dynamodb" {
  description = "ID of the dynamodb VPC endpoint"
  value       = aws_vpc_endpoint.dynamodb.*.id
}