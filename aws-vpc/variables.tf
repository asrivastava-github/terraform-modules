variable "project" {
  description = "Name of project"
  type        = string
}

variable "environment" {
  description = "The project environment to be used for naming"
  type        = string
}

variable "azs" {
  description = "The availability zones that this VPC should create subnets in."
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  type        = string
}

variable "private_subnets" {
  description = "The private subnet CIDR ranges."
  type        = list(string)
}

variable "region" {
  description = "Region to deploy the application."
  type        = string
  default     = "eu-west-1"
}

variable "enable_s3_vpc_endpoint" {
  description = "Enable gateway endpoint for AWS S3 service."
  type        = bool
  default     = false
}

variable "enable_dynamodb_vpc_endpoint" {
  description = "Enable gateway endpoint for AWS Dynamo DB service."
  type        = bool
  default     = false
}
